From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PM-WIP-OPP][PATCH 3/4] omap: pm: opp: add ability to store
 data per opp
Date: Sun, 21 Mar 2010 22:50:58 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9EBAC2C6A@dnce01.ent.ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>
 <1268937891-19445-2-git-send-email-nm@ti.com>
 <1268937891-19445-3-git-send-email-nm@ti.com>
 <1268937891-19445-4-git-send-email-nm@ti.com>
 <20100319144333.GU18995@nokia.com> <4BA3975E.70206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52684 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab0CUVvJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Mar 2010 17:51:09 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4BA3975E.70206@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Hi Nishanth,

>From: Menon, Nishanth
>Sent: Friday, March 19, 2010 4:25 PM
>
>Felipe Balbi had written, on 03/19/2010 09:43 AM, the following:
>> hi,
>>
>> On Thu, Mar 18, 2010 at 07:44:50PM +0100, ext Nishanth Menon wrote:
>>> +int opp_store_data(struct omap_opp *opp, char *name, void *data)
>>> +{
>>> +   return -EINVAL;
>>
>> Would -ENODATA fit better ??
>wondered later on if 0 is better here and get_data with -ENODATA - for
>the actual code also..
>
>>
>>> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
>>> index bb8120e..15f6f7c 100644
>>> --- a/arch/arm/plat-omap/opp.c
>>> +++ b/arch/arm/plat-omap/opp.c
>>> @@ -14,12 +14,19 @@
>>> #include <linux/errno.h>
>>> #include <linux/err.h>
>>> #include <linux/init.h>
>>> +#include <linux/list.h>
>>> #include <linux/slab.h>
>>> #include <linux/cpufreq.h>
>>>
>>> #include <plat/opp_twl_tps.h>
>>> #include <plat/opp.h>
>>>
>>> +struct omap_opp_data {
>>> +   char *name;
>>> +   void *data;
>>> +   struct list_head list;
>>> +};
>>> +
>>> /**
>>>  * struct omap_opp - OMAP OPP description structure
>>>  * @enabled:        true/false - marking this OPP as enabled/disabled
>>> @@ -37,6 +44,7 @@ struct omap_opp {
>>>     unsigned long rate;
>>>     unsigned long u_volt;
>>>     u8 opp_id;
>>> +   struct list_head data_list;
>>> };
>>>
>>> /*
>>> @@ -218,6 +226,7 @@ static void omap_opp_populate(struct omap_opp *opp,
>>>     opp->rate = opp_def->freq;
>>>     opp->enabled = opp_def->enabled;
>>>     opp->u_volt = opp_def->u_volt;
>>> +   INIT_LIST_HEAD(&opp->data_list);
>>> }
>>>
>>> int opp_add(enum opp_t opp_type, const struct omap_opp_def *opp_def)
>>> @@ -352,6 +361,63 @@ int opp_disable(struct omap_opp *opp)
>>>     return 0;
>>> }
>>>
>>> +void *opp_get_data(struct omap_opp *opp, char *name)
>>> +{
>>> +   void *data = ERR_PTR(-EINVAL);
>>> +   struct omap_opp_data *tmp;
>>> +
>>> +   if (unlikely(!opp || !name))
>>> +           return ERR_PTR(-EINVAL);
>>> +
>>> +   list_for_each_entry(tmp, &opp->data_list, list)
>>> +           if (!strcmp(name, tmp->name)) {
>>> +                   data = tmp->data;
>>> +                   break;
>>> +           }
>>> +   return data;
>>> +}
>>> +
>>> +int opp_store_data(struct omap_opp *opp, char *name, void *data)
>>> +{
>>> +   struct omap_opp_data *new;
>>> +   if (unlikely(!opp || !name))
>>> +           return -EINVAL;
>>> +   /* NAK to double registration */
>>> +   if (unlikely(!IS_ERR(opp_get_data(opp, name))))
>>> +           return -EINVAL;
>>> +
>>> +   new = kmalloc(sizeof(struct omap_opp), GFP_KERNEL);
>>> +   if (!new)
>>> +           return -ENOMEM;
>>> +   new->name = kmalloc(strlen(name) + 1, GFP_KERNEL);
>>> +   if (!new->name) {
>>> +           kfree(new);
>>> +           return -ENOMEM;
>>> +   }
>>> +   new->data = data;
>>> +   strcpy(new->name, name);
>>> +   INIT_LIST_HEAD(&new->list);
>>> +   list_add(&new->list, &opp->data_list);
>>> +   return 0;
>>> +}
>>
>> will you really want to add several data entries there ? I don't see the
>> point. Maybe I'm missing something.
>>
>> I like the idea of having a void * to allow you to store anything there.
>> But generally that's a 1 - 1 relation:
>>
>> 1 device/bus/(in this case) opp - 1 data.
>
>I think I am lost here -> why device/bus/opp? this is a 1-many
>relationship. here is an example of it:
>OPP by definition is a tuple (voltage,frequency).
>
>for each OPP, we may have additional information which is custom to a
>specific SOC ->
>OMAP2 and OMAP1 have no SR module -> so I dont need to store SR nTarget
>value.
>
>data type 1: OMAP34xx and OMAP3630 have SR, and nTarget is a *per chip*
>calibration value specific to an OPP -however, we have 5 OPPs (or upto 7
>in the case of 3440 etc.) in omap34xx while omap3630 has upto 4 OPPs.
>in omap3630, we use ABB data which is in addition to nTarget (if my
>meager understanding of this is right)..
>
>data type 2: The dependency of vdd1 OPP to vdd2 opp is variant based on SOC.
>
>the types of data which is stored per OPP is changing all the time and
>in future we will have varied data again.
>
>Now, based on your proposal as I understand,
>struct omap2_data {
>blah_o21
>blah_o22
>};
>
>struct omap3_data {
>blah_o31
>blah_o32
>blah_o33
>}
>
>struct omap4_data {
>blah_o41
>blah_o42
>blah_o31
>blah_o32
>}
>
>and so on (remember we may have shared or similar data between various
>SOCs at times)
>
>redundancy, maintenance are the problems i see other than ability to
>have a module which uses blah_o31 to be generic and not know the
>difference between struct omap3_data and omap4_data
>the resultant module code will look like:
>if (cpu_is_omap3430()) {
>       my_blaho31 = ((struct omap3_data *) get_opp_data(opp))->blah_o31;
>} else if cpu_is...() {
>..
>}
>
>now in the approach I took,
>you could have:
>struct sr_ntarget_type{
>       unsigned long nTarget;
>       something else if needed
>}

I'm still not convinced...

It appears that there is still some confusion with what OPP is or should be.

The OPP layer, for my point of view was done to handle the freq -> voltage association per IP. This layer should be flexible because we can add or remove dynamically any OPP.

All the data related to SR and ABB belong to the characterized voltages that belong to a certain OPP for a voltage rail. These informations are not configurable at all and not related to any IP. They are well defined for a particular SoC techno (65nm, 45nm) for a voltage domain.
So they should belong to a SoC specific file, and should be hard coded for a voltage domain.
The point is that you should not tie SR Ntarget, ABB... to the OPP itself but to the voltage. Hence the need to have other voltage -> SR, ABB table in the voltage management code only.
We should not clutter the OPP layer with something that is voltage related.

The other point is that up to now, all voltage related data are a super set of the previous SoC data, so you can define only one voltage_data structure that work for all SoC. If the data is useless for previous platform, just put 0 or a flag to disable that parameter.


Regarding the link between voltage domains, there are two different types that should not be necessarily handled by the OPP layer.

- The first case is the one we have today to handle the MPU -> L3 dependency: In that case it is a pure policy dependency, that can or not be applied depending of the need and of the customer.
Is it the OPP layer responsibility to handle policy? If it is the case, we should add much more stuff to expose that to user mode and allow a certain amount of flexibility.
- The second case is due to HW limitation like on OMAP4, where we cannot have the highest OPP on MPU or IVA with the lowest one on the CORE.
In that case, we probably have to handle that in the low level voltage management part and not in the OPP layer.


Bottom line is I still think this is a little bit over-engineered for the real need, and on the other side that does not fully solve the needs.

Regards,
Benoit

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



