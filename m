From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: OMAP3515 vs 3525 inversion
Date: Tue, 17 Nov 2009 16:49:34 +0300
Message-ID: <48239d390911170549o28f51ebdqda9e9ba53238a463@mail.gmail.com>
References: <48239d390911160228y61e3c3dbk11b7a819f266b4bd@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE563E29@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:57622 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbZKQNta (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 08:49:30 -0500
Received: by ywh40 with SMTP id 40so4051680ywh.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 05:49:35 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE563E29@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Nov 17, 2009 at 4:39 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Sergey Lapin
>> Sent: Monday, November 16, 2009 3:59 PM
>> To: linux-omap@vger.kernel.org
>> Subject: OMAP3515 vs 3525 inversion
>>
>> Hi, all!
>> I think I found a bug in processor detection code.
>> as I see,
>> > > + /* OMAP3430 and OMAP3530 are assumed to be same.
>> > > +  *
>> > > +  * OMAP3525, OMAP3515 and OMAP3503 can be detected only based
>> > > +  * on available features. Upon detection, update the CPU id
>> > > +  * and CPU class bits.
>> > > +  */
>> > > + if (omap3_has_iva() && omap3_has_sgx()) {
>> > > +         strcpy(cpu_name, "3430/3530");
>> > > + }
>> > > + else if (omap3_has_sgx()) {
>> > > +         omap_revision = OMAP3525_REV (rev);
>> > > +         strcpy(cpu_name, "3525");
>> > > + }
>> > > + else if (omap3_has_iva()) {
>> > > +         omap_revision = OMAP3515_REV (rev);
>> > > +         strcpy(cpu_name, "3515");
>> > > + }
>> > > + else {
>> > > +         omap_revision = OMAP3503_REV (rev);
>> > > +         strcpy(cpu_name, "3503");
>> > > + }
>>
>> But, actually, 3515 has no DSP, but has PowerVR,
>> and 3525 has no PowerVR but has DSP. In-tree code inverses
>> this detection.
>
> This error seems to have crept in while reworking the patch. I
> believe the patch can be minimized to:
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 1c15112..e5a0747 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -270,11 +270,11 @@ void __init omap3_cpuinfo(void)
>                strcpy(cpu_name, "3630");
>        else if (omap3_has_iva() && omap3_has_sgx())
>                strcpy(cpu_name, "3430/3530");
> -       else if (omap3_has_sgx()) {
> +       else if (omap3_has_iva()) {
>                omap_revision = OMAP3525_REV(rev);
>                strcpy(cpu_name, "3525");
>        }
> -       else if (omap3_has_iva()) {
> +       else if (omap3_has_sgx()) {
>                omap_revision = OMAP3515_REV(rev);
>                strcpy(cpu_name, "3515");
>        }
>
> I can submit this on your behalf.

Fine by me.

S.
