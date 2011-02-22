From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: hwmod: multi-omap: disabling smartreflex on AM3517
Date: Tue, 22 Feb 2011 19:18:15 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BBE29A4@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB5930248A017D9@dbde02.ent.ti.com>
 <4D5A75FF.5040703@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024B83BF08@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024BD4894D@dbde02.ent.ti.com>
 <4D623ED8.4050906@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024BD489B1@dbde02.ent.ti.com>
 <4D6273FE.3000205@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024BD48BED@dbde02.ent.ti.com>,<4D62F7E0.1000102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34612 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813Ab1BVNus convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 08:50:48 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1MDojce006449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 07:50:47 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1MDoiei021482
	for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 19:20:44 +0530 (IST)
In-Reply-To: <4D62F7E0.1000102@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2/21/2011 4:41 PM, Premi, Sanjeev wrote:
>
> [...]
>
> >> The comment is already there BTW, so you just have to replace that by some
> >> real code:-)
> >
> > [sp] I have already added real code, but the problem lies here:
> >       On same file (few lines up) omap_chip.oc is assigned value of
> >       CHIP_IS_OMAP3430. CHIP_IS_AM3517 now needs to be added to all
> >       places where CHIP_IS_OMAP3430ES3_1 is chosen.
> >
> >       All this to support a chip that differs in 4 peripherals and IVA.
> >       ... and this is what I was planning to minimize.
>
> This is what we've being using for some time to handle small diff
> between ES.
>
> >       Leaving aside AM3517; we have AM3703 - same as OMAP3630 but without
> >       IVA and SGX. Here obviously hwmods for either of IVA, SGX shouldn't
> >       be initialized. Isn't it?
> >
> >       Creating CHIP_IS_ ... here would be an overkill. Thoughts?
>
> It depends how many variant you plan to do :-) We still have some room
> for 18 more variants / chip.
>
> You can still create a new CHIP_IS, and add a alias
> CHIP_IS_OMAP36XX_COMMON = CHIP_IS_OMAP3630 | CHIP_IS_AM3703 and then
> replace all the existing entry with that alias.

[sp] This means we would need 5 bits for AM37xx devices. Adding another
     5 bits for OMAP35xx and 3 bits for AM35xx device, we are left with
     only 5. (Assuming no further silicon revisions across these devices)

    We will be short of bits when support for TI814x variants come in.
    Also, there are going to be too many ORs for the HWMODs that are
    reused across the ARM Cortex-A8 family.

    In my previous mail, I was proposing simpler scheme where default
    definition is "inclusive" as now; and then ones not applicable for
    each specific device is simply "excluded" from consideration before
    HWMODs are initialized.

>
> If we want to avoid using these defines, you will have potentially to
> add a feature entry in every hwmod / clock / power domain entry that
> already uses the omap_chip today.
> And then during the init we can filter on both the chip revision and
> chip features.
> The drawback is that we are going to waste at least 300 x 32 bits to
> store that :-)
> Whereas with the extra CHIP_IS_, it is just a couple of defines... no
> memory impact.

[sp] It is not just one additional bit; but 1 bit for the family e.g.
     CHIP_IS_OMAP36XX_COMMON; and then one per variant.

     Much less than 300x32 but still lot of code changes compared to
     actual difference between the devices.

>
> In between, you can consider a hwmod class to feature mapping, in order
> to know what hwmod class will be excluded if the feature is not there
> during the iteration.

[sp] Here is what I had been proposing with one hwmod as example.

static struct omap_hwmod omap34xx_sr1_hwmod = {
	.name		= "sr1_hwmod",

...removed much of code...

	.select		= true;		/* new flag. True by default. */
};

Later:

int __init omap3xxx_hwmod_init(void)
{
	if (cpu_is_omap3505()) {
		omap3505_hwmod_select();
	}
	else if (cpu_is_omap3517()) {
		omap3505_hwmod_select();
	}
	else if (cpu_is_omap34xx()) {
		if (cpu_is_omap3503())
			omap3503_hwmod_select();
		else if (cpu_is_omap3515())
			omap3515_hwmod_select();
	}
	...and so on...

	return omap_hwmod_init(omap3xxx_hwmods);
}

where,

void __init omap3505_hwmod_select(void)
{
	omap34xx_sr1_hwmod.select = false;
	omap34xx_sr2_hwmod.select = false;

	... etc. etc. ...
}

And the omap_hwmod_init() first checks for .select to be true.
Current processing works as is.

This way, we don't need additional bits per chip variant; and
we reuse the existing "feature" bits.

~sanjeev

>
> I think I still prefer the first solution.
>
> Regards,
> Benoit
>
>