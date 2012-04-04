From: Ming Lei <ming.lei@canonical.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Wed, 4 Apr 2012 11:42:30 +0800
Message-ID: <CACVXFVOxCx-mwLqeM_yDrJDhQrpo6axOWuUvX7eoj87PoMTEsw@mail.gmail.com>
References: <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
	<CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
	<CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
	<CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
	<20120403092524.GD17741@mudshark.cambridge.arm.com>
	<CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
	<20120403094749.GH17741@mudshark.cambridge.arm.com>
	<CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
	<20120403123444.GL17741@mudshark.cambridge.arm.com>
	<878vicsxef.fsf@ti.com>
	<20120403160706.GP17741@mudshark.cambridge.arm.com>
	<87ehs4pfw4.fsf@ti.com>
	<alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49867 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651Ab2DDDmb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 23:42:31 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1SFH78-00013j-I3
	for linux-omap@vger.kernel.org; Wed, 04 Apr 2012 03:42:30 +0000
Received: by wejx9 with SMTP id x9so226813wej.19
        for <linux-omap@vger.kernel.org>; Tue, 03 Apr 2012 20:42:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Will Deacon <will.deacon@arm.com>, "Shilimkar\\, Santosh" <santosh.shilimkar@ti.com>, "eranian\\@gmail.com" <eranian@gmail.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list\\@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel\\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>

On Wed, Apr 4, 2012 at 7:29 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Tue, 3 Apr 2012, Kevin Hilman wrote:
>
>> Indeed, like you, I have to change the EMU clock domain to SWSUP[1] =
in
>> order to see any interrupts and see anything in perf top. =A0This is=
n't
>> really a mergeable workaround, so I'll look into this a little close=
r
>> with Santosh to see what we can do once we fully understand the HW
>> problem.
>
> Part of the problem is that the clockdomain data for the emu_sys
> clockdomain is wrong. =A0Here's something to try to fix it. =A0It mig=
ht just
> be enough to get it to work.
>
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Tue, 3 Apr 2012 17:13:48 -0600
> Subject: [PATCH] ARM: OMAP44xx: clockdomain data: correct the emu_sys=
_clkdm
> =A0CLKTRCTRL data
>
> According to the 4430 ES2.0 TRM vX Table 3-744 "CM_EMU_CLKSTCTRL",
> the emu_sys clockdomain data in mainline is incorrect.
>
> The emu_sys clockdomain does not support the DISABLE_AUTO state, and
> instead it supports the FORCE_WAKEUP state.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=EEt Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Ming Lei <ming.lei@canonical.com>
> ---
> =A0arch/arm/mach-omap2/clockdomains44xx_data.c | =A0 =A02 +-
> =A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/m=
ach-omap2/clockdomains44xx_data.c
> index 9299ac2..bd7ed13 100644
> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
> @@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm =3D =
{
> =A0 =A0 =A0 =A0.prcm_partition =A0 =3D OMAP4430_PRM_PARTITION,
> =A0 =A0 =A0 =A0.cm_inst =A0 =A0 =A0 =A0 =A0=3D OMAP4430_PRM_EMU_CM_IN=
ST,
> =A0 =A0 =A0 =A0.clkdm_offs =A0 =A0 =A0 =3D OMAP4430_PRM_EMU_CM_EMU_CD=
OFFS,
> - =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D CLKDM_CAN_HWSUP,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D CLKDM_CAN_ENABLE_AUTO=
 | CLKDM_CAN_FORCE_WAKEUP,

I tested the patch just now, but unfortunately, the change still doesn'=
t make
PMU to generate IRQs.

Mark the flags as CLKDM_CAN_SWSUP may work, but PMU will stop producing
IRQs after resuming from suspend.


Thanks
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
