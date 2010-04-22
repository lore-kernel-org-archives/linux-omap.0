From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 4/4][v3] OMAP:iommu- add TLB preservation support
Date: Thu, 22 Apr 2010 11:58:10 +0300 (EEST)
Message-ID: <20100422.115810.179947308.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B3BF953@dlee03.ent.ti.com>
	<20100421.090227.189716355.Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4B3C078F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26285 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab0DVI6U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 04:58:20 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B3C078F@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, felipe.contreras@gmail.com, tony@atomide.com

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 4/4][v3] OMAP:iommu- add TLB preservation support
Date: Thu, 22 Apr 2010 02:19:35 +0200

>> > @@ -241,6 +238,11 @@ int load_iotlb_entry(struct iommu *obj, struct
>> iotlb_entry *e)
>> >  			break;
>> >  	}
>> >
>> > +	if (l.base == obj->nr_tlb_entries) {
>> > +		dev_dbg(obj->dev, "%s: preserve entries full\n", __func__);
>> > +		err = -EBUSY;
>> 
>> I am afraid that this doesn't work. There are two cases where TLB
>> entries are set/updated:
>> 
>> 1) H/W TWL always updates TLB entries automatically, IOW, increments
>>    "vict" implicitly.
>> 2) A client module adds preservation TLB entry with explictly calling
>>    "load_iotlb_entry()". IOW, increments both  "vict" and "base"
>>    intentionally.
>> 
>> Because of 1), "vict" gets full soon and this is normal, but even if
>> this "vict" is full, a preservation entry "base" should be able to be
>> set by a client module unless "base" itself rearches full. IOW, Even
>> if all TLB entries are valid, a new preservation TLB entry should be
>> set by replacing one of the existing normal entry.
>> 
>> In the case of "e" with perservation bit , "load_iotlb_entry()"
>> doesn't usually fail because it replaces the exisiting normal entry,
>> but it would fail only if all TLB entries are preserved.
>> 
> 
> -- I agree with your comments. My implementation was under the
> assumption that the User locks the TLB entries only at startup time,
> but as you mentioned this would not work during run time as the
> entries would already be having valid entries. DSPBridge and the
> OMAP4 IPCs both locks the entries at init time.

I understand your cases, but the implementation should cover more
general cases too.

> The following changes in load_tlb_entry function should handle the
> run time case too. This change would lock an entry irrespective of
> existing entry is valid or not.
> Please let me know if you agree.

OK for me, just small comment inlined.

> @@ -230,22 +227,32 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
> 
>         clk_enable(obj->clk);
> 
> -       for (i = 0; i < obj->nr_tlb_entries; i++) {
> -               struct cr_regs tmp;
> -
> -               iotlb_lock_get(obj, &l);
> -               l.vict = i;
> -               iotlb_lock_set(obj, &l);
> -               iotlb_read_cr(obj, &tmp);
> -               if (!iotlb_cr_valid(&tmp))
> -                       break;
> -       }
> -
> -       if (i == obj->nr_tlb_entries) {
> -               dev_dbg(obj->dev, "%s: full: no entry\n", __func__);
> +       iotlb_lock_get(obj, &l);
> +       if (l.base == obj->nr_tlb_entries) {
> +               dev_dbg(obj->dev, "%s: preserve entries full\n", __func__);
>                 err = -EBUSY;

dev_warn()?

I guess that it might be better to inform this a bit louder since all
preservation entries are managed well by a client.
