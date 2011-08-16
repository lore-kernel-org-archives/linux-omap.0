From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 05/15] PM QoS: generalize and export the constraints
 management code
Date: Tue, 16 Aug 2011 10:45:57 -0700
Message-ID: <20110816174557.GA17027@gvim.org>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
 <201108132234.17377.rjw@sisk.pl>
 <CAORVsuUz9qXFvUTsYOs4Z7rLQFXROKOcWVi=bZWTKJuA2Xu1Og@mail.gmail.com>
 <201108141537.43752.rjw@sisk.pl>
 <20110816040809.GA11921@gvim.org>
 <CAORVsuXDp4vYGg9BCLkJm6iMPobSCtE9s_1j4zNV5frKjQY1jg@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36961 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab1HPRqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 13:46:03 -0400
Received: by vxi9 with SMTP id 9so135805vxi.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 10:46:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAORVsuXDp4vYGg9BCLkJm6iMPobSCtE9s_1j4zNV5frKjQY1jg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: markgross@thegnar.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Tue, Aug 16, 2011 at 08:44:19AM +0200, Jean Pihet wrote:
> On Tue, Aug 16, 2011 at 6:08 AM, mark gross <markgross@thegnar.org> w=
rote:
> > On Sun, Aug 14, 2011 at 03:37:43PM +0200, Rafael J. Wysocki wrote:
> >> On Sunday, August 14, 2011, Jean Pihet wrote:
> >> > Hi Rafael, Mark,
> >> >
> >> > On Sat, Aug 13, 2011 at 10:34 PM, Rafael J. Wysocki <rjw@sisk.pl=
> wrote:
> >> > > On Saturday, August 13, 2011, mark gross wrote:
> >> > >> On Thu, Aug 11, 2011 at 05:06:42PM +0200, jean.pihet@newoldbi=
ts.com wrote:
> >> > >> > From: Jean Pihet <j-pihet@ti.com>
> >> > >> >
> >> > >> > In preparation for the per-device constratins support:
> >> > >> > - rename update_target to pm_qos_update_target
> >> > >> > - generalize and export pm_qos_update_target for usage by t=
he upcoming
> >> > >> > per-device latency constraints framework:
> >> > >> > =A0 =A0. operate on struct pm_qos_constraints for constrain=
ts management,
> >> > >> > =A0 =A0. introduce an 'action' parameter for constraints ad=
d/update/remove,
> >> > >> > =A0 =A0. the return value indicates if the aggregated const=
raint value has
> >> > >> > =A0 =A0 =A0changed,
> >> > >> > - update the internal code to operate on struct pm_qos_cons=
traints
> >> > >> > - add a NULL pointer check in the API functions
> >> > >> >
> >> > >> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
> >> > ...
> >> > >> > +/* Action requested to pm_qos_update_target */
> >> > >> > +enum pm_qos_req_action {
> >> > >> > + =A0 PM_QOS_ADD_REQ, =A0 =A0 =A0 =A0 /* Add a new request =
*/
> >> > >> > + =A0 PM_QOS_UPDATE_REQ, =A0 =A0 =A0/* Update an existing r=
equest */
> >> > >> > + =A0 PM_QOS_REMOVE_REQ =A0 =A0 =A0 /* Remove an existing r=
equest */
> >> > >> > +};
> >> > >> > +
> >> > >>
> >> > >> What do you need this enum for? =A0The function names *_updat=
e_*, *_add_*,
> >> > >> and =A0*_remove_* seem to be pretty redundant if you have to =
pass an enum
> >> > >> that could possibly conflict with the function name.
> >> > >>
> >> > >> > =A0#ifdef CONFIG_PM
> >> > >> > +int pm_qos_update_target(struct pm_qos_constraints *c, str=
uct plist_node *node,
> >> > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum pm_qos_req_ac=
tion action, int value);
> >> > >> The action for update_target better damn well be "PM_QOS_UPDA=
TE_REQ" or
> >> > >> there is something strange going on.... =A0BTW what shold thi=
s function do
> >> > >> if the pm_qos_req_action was *not* the UPDATE one?
> >> >
> >> > The meaning of pm_qos_update_target is 'update the PM QoS target
> >> > constraints lists'. As described in the changelog the intention =
of
> >> > this patch is to implement the constraints lists management logi=
c in
> >> > update_target and simplify the API functions (add/update/remove)=
=2E It
> >> > is also exported for the upcoming (patch 06/15]) to use it as we=
ll.
> >>
> >> The enums are fine by me and they allow us to simplify the code
> >> quite a bit.
> >>
> > Ok, but they look a bit sloppy to me as we now have an API that say=
s
> > "add" we can actually pass in an enum that says "remove".
> We have an API that says 'update target' that we pass in a parameter
> that says 'add request', 'update request' or 'remove request'.
> If it is required I could just rename the internal function
> update_target, in a later patch.

You are right.  I thought I saw the enum added to the other API's for
some reason.  Still, with this update we have an API overloaded through
that enum parameter providing 2 add, 2 delete and 2 update API's  Each
pair doing about the same thing.

To me it feels like a baby step toward an ioctl type of API that I don'=
t
like.  I'm not going to fight about it any more but I don't like such
API's as they tend to get hard to read and get out of control.

please rethink this a little.
--mark

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
