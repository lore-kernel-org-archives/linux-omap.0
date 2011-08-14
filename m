From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 05/15] PM QoS: generalize and export the constraints
 management code
Date: Sun, 14 Aug 2011 10:25:48 +0200
Message-ID: <CAORVsuUz9qXFvUTsYOs4Z7rLQFXROKOcWVi=bZWTKJuA2Xu1Og@mail.gmail.com>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
	<1313075212-8366-6-git-send-email-j-pihet@ti.com>
	<20110813030937.GE639@gvim.org>
	<201108132234.17377.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42520 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab1HNIZu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Aug 2011 04:25:50 -0400
Received: by qwk3 with SMTP id 3so2094430qwk.19
        for <linux-omap@vger.kernel.org>; Sun, 14 Aug 2011 01:25:49 -0700 (PDT)
In-Reply-To: <201108132234.17377.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, markgross@thegnar.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi Rafael, Mark,

On Sat, Aug 13, 2011 at 10:34 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote=
:
> On Saturday, August 13, 2011, mark gross wrote:
>> On Thu, Aug 11, 2011 at 05:06:42PM +0200, jean.pihet@newoldbits.com =
wrote:
>> > From: Jean Pihet <j-pihet@ti.com>
>> >
>> > In preparation for the per-device constratins support:
>> > - rename update_target to pm_qos_update_target
>> > - generalize and export pm_qos_update_target for usage by the upco=
ming
>> > per-device latency constraints framework:
>> > =A0 =A0. operate on struct pm_qos_constraints for constraints mana=
gement,
>> > =A0 =A0. introduce an 'action' parameter for constraints add/updat=
e/remove,
>> > =A0 =A0. the return value indicates if the aggregated constraint v=
alue has
>> > =A0 =A0 =A0changed,
>> > - update the internal code to operate on struct pm_qos_constraints
>> > - add a NULL pointer check in the API functions
>> >
>> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
=2E..
>> > +/* Action requested to pm_qos_update_target */
>> > +enum pm_qos_req_action {
>> > + =A0 PM_QOS_ADD_REQ, =A0 =A0 =A0 =A0 /* Add a new request */
>> > + =A0 PM_QOS_UPDATE_REQ, =A0 =A0 =A0/* Update an existing request =
*/
>> > + =A0 PM_QOS_REMOVE_REQ =A0 =A0 =A0 /* Remove an existing request =
*/
>> > +};
>> > +
>>
>> What do you need this enum for? =A0The function names *_update_*, *_=
add_*,
>> and =A0*_remove_* seem to be pretty redundant if you have to pass an=
 enum
>> that could possibly conflict with the function name.
>>
>> > =A0#ifdef CONFIG_PM
>> > +int pm_qos_update_target(struct pm_qos_constraints *c, struct pli=
st_node *node,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum pm_qos_req_action ac=
tion, int value);
>> The action for update_target better damn well be "PM_QOS_UPDATE_REQ"=
 or
>> there is something strange going on.... =A0BTW what shold this funct=
ion do
>> if the pm_qos_req_action was *not* the UPDATE one?

The meaning of pm_qos_update_target is 'update the PM QoS target
constraints lists'. As described in the changelog the intention of
this patch is to implement the constraints lists management logic in
update_target and simplify the API functions (add/update/remove). It
is also exported for the upcoming (patch 06/15]) to use it as well.

=2E..

>> > +int pm_qos_update_target(struct pm_qos_constraints *c, struct pli=
st_node *node,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum pm_qos_req_action ac=
tion, int value)
>> > =A0{
>> > =A0 =A0 unsigned long flags;
>> > - =A0 int prev_value, curr_value;
>> > + =A0 int prev_value, curr_value, new_value;
>> >
>> > =A0 =A0 spin_lock_irqsave(&pm_qos_lock, flags);
>> > - =A0 prev_value =3D pm_qos_get_value(o);
>> > - =A0 /* PM_QOS_DEFAULT_VALUE is a signal that the value is unchan=
ged */
>> > - =A0 if (value !=3D PM_QOS_DEFAULT_VALUE) {
>> > + =A0 prev_value =3D pm_qos_get_value(c);
>> > + =A0 if (value =3D=3D PM_QOS_DEFAULT_VALUE)
>> > + =A0 =A0 =A0 =A0 =A0 new_value =3D c->default_value;
>> > + =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 new_value =3D value;
>> > +
>> > + =A0 switch (action) {
>> > + =A0 case PM_QOS_REMOVE_REQ:
>> We have a remove request API already. =A0This overloading of this
>> interface feels wrong to me.
>>
>> > + =A0 =A0 =A0 =A0 =A0 plist_del(node, &c->list);
>> > + =A0 =A0 =A0 =A0 =A0 break;
>> > + =A0 case PM_QOS_UPDATE_REQ:
>> > =A0 =A0 =A0 =A0 =A0 =A0 /*
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0* to change the list, we atomically rem=
ove, reinit
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0* with new value and add, then see if t=
he extremal
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0* changed
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> > - =A0 =A0 =A0 =A0 =A0 plist_del(node, &o->constraints->list);
>> > - =A0 =A0 =A0 =A0 =A0 plist_node_init(node, value);
>> > - =A0 =A0 =A0 =A0 =A0 plist_add(node, &o->constraints->list);
>> > - =A0 } else if (del) {
>> > - =A0 =A0 =A0 =A0 =A0 plist_del(node, &o->constraints->list);
>> > - =A0 } else {
>> > - =A0 =A0 =A0 =A0 =A0 plist_add(node, &o->constraints->list);
>> > + =A0 =A0 =A0 =A0 =A0 plist_del(node, &c->list);
>> > + =A0 case PM_QOS_ADD_REQ:
>> Don't we have an API for adding a request? =A0if you want to overloa=
d
>> update like this then either we lose the add API or this shouldn't b=
e
>> here.
>>
=2E..
>> > @@ -216,20 +242,16 @@ EXPORT_SYMBOL_GPL(pm_qos_request_active);
>> > =A0void pm_qos_add_request(struct pm_qos_request *req,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int pm_qos_class, s32 valu=
e)
>> > =A0{
>> > - =A0 struct pm_qos_object *o =3D =A0pm_qos_array[pm_qos_class];
>> > - =A0 int new_value;
>> > + =A0 if (!req) /*guard against callers passing in null */
>> > + =A0 =A0 =A0 =A0 =A0 return;
>> >
>> > =A0 =A0 if (pm_qos_request_active(req)) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_add_request() cal=
led for already added request\n");
>> > =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > =A0 =A0 }
>> > - =A0 if (value =3D=3D PM_QOS_DEFAULT_VALUE)
>> > - =A0 =A0 =A0 =A0 =A0 new_value =3D o->constraints->default_value;
>> > - =A0 else
>> > - =A0 =A0 =A0 =A0 =A0 new_value =3D value;
>> > - =A0 plist_node_init(&req->node, new_value);
>> > =A0 =A0 req->pm_qos_class =3D pm_qos_class;
>> > - =A0 update_target(o, &req->node, 0, PM_QOS_DEFAULT_VALUE);
>> > + =A0 pm_qos_update_target(pm_qos_array[pm_qos_class]->constraints=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&req->node, PM_QO=
S_ADD_REQ, value);
>>
>> Ok, using pm_qos_update_target to reduce the LOC is ok but I don't t=
hink
>> this function and the enum should be exported outside of pm_qos.c
>
> They are used by the next patches adding the per-device QoS.
Exactly

>
> Thanks,
> Rafael
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
