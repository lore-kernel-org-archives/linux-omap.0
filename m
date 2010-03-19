From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH 3/4] omap: pm: opp: add ability to store data
 per opp
Date: Fri, 19 Mar 2010 10:25:18 -0500
Message-ID: <4BA3975E.70206@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com> <1268937891-19445-2-git-send-email-nm@ti.com> <1268937891-19445-3-git-send-email-nm@ti.com> <1268937891-19445-4-git-send-email-nm@ti.com> <20100319144333.GU18995@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36442 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451Ab0CSPZw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 11:25:52 -0400
In-Reply-To: <20100319144333.GU18995@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Felipe Balbi had written, on 03/19/2010 09:43 AM, the following:
> hi,
> 
> On Thu, Mar 18, 2010 at 07:44:50PM +0100, ext Nishanth Menon wrote:
>> +int opp_store_data(struct omap_opp *opp, char *name, void *data)
>> +{
>> +	return -EINVAL;
> 
> Would -ENODATA fit better ??
wondered later on if 0 is better here and get_data with -ENODATA - for 
the actual code also..

> 
>> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
>> index bb8120e..15f6f7c 100644
>> --- a/arch/arm/plat-omap/opp.c
>> +++ b/arch/arm/plat-omap/opp.c
>> @@ -14,12 +14,19 @@
>> #include <linux/errno.h>
>> #include <linux/err.h>
>> #include <linux/init.h>
>> +#include <linux/list.h>
>> #include <linux/slab.h>
>> #include <linux/cpufreq.h>
>>
>> #include <plat/opp_twl_tps.h>
>> #include <plat/opp.h>
>>
>> +struct omap_opp_data {
>> +	char *name;
>> +	void *data;
>> +	struct list_head list;
>> +};
>> +
>> /**
>>  * struct omap_opp - OMAP OPP description structure
>>  * @enabled:	true/false - marking this OPP as enabled/disabled
>> @@ -37,6 +44,7 @@ struct omap_opp {
>> 	unsigned long rate;
>> 	unsigned long u_volt;
>> 	u8 opp_id;
>> +	struct list_head data_list;
>> };
>>
>> /*
>> @@ -218,6 +226,7 @@ static void omap_opp_populate(struct omap_opp *opp,
>> 	opp->rate = opp_def->freq;
>> 	opp->enabled = opp_def->enabled;
>> 	opp->u_volt = opp_def->u_volt;
>> +	INIT_LIST_HEAD(&opp->data_list);
>> }
>>
>> int opp_add(enum opp_t opp_type, const struct omap_opp_def *opp_def)
>> @@ -352,6 +361,63 @@ int opp_disable(struct omap_opp *opp)
>> 	return 0;
>> }
>>
>> +void *opp_get_data(struct omap_opp *opp, char *name)
>> +{
>> +	void *data = ERR_PTR(-EINVAL);
>> +	struct omap_opp_data *tmp;
>> +
>> +	if (unlikely(!opp || !name))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	list_for_each_entry(tmp, &opp->data_list, list)
>> +		if (!strcmp(name, tmp->name)) {
>> +			data = tmp->data;
>> +			break;
>> +		}
>> +	return data;
>> +}
>> +
>> +int opp_store_data(struct omap_opp *opp, char *name, void *data)
>> +{
>> +	struct omap_opp_data *new;
>> +	if (unlikely(!opp || !name))
>> +		return -EINVAL;
>> +	/* NAK to double registration */
>> +	if (unlikely(!IS_ERR(opp_get_data(opp, name))))
>> +		return -EINVAL;
>> +
>> +	new = kmalloc(sizeof(struct omap_opp), GFP_KERNEL);
>> +	if (!new)
>> +		return -ENOMEM;
>> +	new->name = kmalloc(strlen(name) + 1, GFP_KERNEL);
>> +	if (!new->name) {
>> +		kfree(new);
>> +		return -ENOMEM;
>> +	}
>> +	new->data = data;
>> +	strcpy(new->name, name);
>> +	INIT_LIST_HEAD(&new->list);
>> +	list_add(&new->list, &opp->data_list);
>> +	return 0;
>> +}
> 
> will you really want to add several data entries there ? I don't see the 
> point. Maybe I'm missing something.
> 
> I like the idea of having a void * to allow you to store anything there. 
> But generally that's a 1 - 1 relation:
> 
> 1 device/bus/(in this case) opp - 1 data.

I think I am lost here -> why device/bus/opp? this is a 1-many 
relationship. here is an example of it:
OPP by definition is a tuple (voltage,frequency).

for each OPP, we may have additional information which is custom to a 
specific SOC ->
OMAP2 and OMAP1 have no SR module -> so I dont need to store SR nTarget 
value.

data type 1: OMAP34xx and OMAP3630 have SR, and nTarget is a *per chip* 
calibration value specific to an OPP -however, we have 5 OPPs (or upto 7 
in the case of 3440 etc.) in omap34xx while omap3630 has upto 4 OPPs.
in omap3630, we use ABB data which is in addition to nTarget (if my 
meager understanding of this is right)..

data type 2: The dependency of vdd1 OPP to vdd2 opp is variant based on SOC.

the types of data which is stored per OPP is changing all the time and 
in future we will have varied data again.

Now, based on your proposal as I understand,
struct omap2_data {
blah_o21
blah_o22
};

struct omap3_data {
blah_o31
blah_o32
blah_o33
}

struct omap4_data {
blah_o41
blah_o42
blah_o31
blah_o32
}

and so on (remember we may have shared or similar data between various 
SOCs at times)

redundancy, maintenance are the problems i see other than ability to 
have a module which uses blah_o31 to be generic and not know the 
difference between struct omap3_data and omap4_data
the resultant module code will look like:
if (cpu_is_omap3430()) {
	my_blaho31 = ((struct omap3_data *) get_opp_data(opp))->blah_o31;
} else if cpu_is...() {
..
}

now in the approach I took,
you could have:
struct sr_ntarget_type{
	unsigned long nTarget;
	something else if needed
}

And in SR driver, the module doesnot need to care which silicon it is 
running on.. it just does opp_get_data(opp,"sr_ntarget") and gets the 
correct data for that silicon on that OPP. It is much simpler and 
similar to the manner implemented in many other frameworks such as clock 
etc..

[...]

-- 
Regards,
Nishanth Menon
