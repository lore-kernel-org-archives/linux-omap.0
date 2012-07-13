From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Fri, 13 Jul 2012 11:57:37 +0100
Message-ID: <WC20120713105737.0900A2@terrafix.co.uk>
References: <WC20120712081507.600002@terrafix.co.uk> <alpine.DEB.2.00.1207120456100.25585@utopia.booyaka.com> <WC20120712144308.86003F@terrafix.co.uk> <alpine.DEB.2.00.1207121334150.25585@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:51761 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755993Ab2GMLFm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 07:05:42 -0400
In-Reply-To: <alpine.DEB.2.00.1207121334150.25585@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, "linux-omap\\\\@vger.kernel.org" <linux-omap@vger.kernel.org>

-----Original Message-----
=46rom: Paul Walmsley <paul@pwsan.com>
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Kevin Hilman <khilman@ti.com>, "linux-omap\\\\@vger.kernel.org" <li=
nux-omap@vger.kernel.org>
Date: Thu, 12 Jul 2012 13:35:14 -0600 (MDT)
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with =
RTC?

> Hello Joe,
>=20
> On Thu, 12 Jul 2012, Joe Woodward wrote:
>=20
> > I think this has fixed the following warning:
> > [    0.000000] clockdomain: mpu_clkdm: powerdomain =AC=F5`=C08=BAs=C0=
 does
> not exist
> > =20
> > But when I try and suspend I still get the same problems:
> > # echo mem > /sys/power/state
> > [   13.283935] PM: Syncing filesystems ... done.
> > [   13.300537] Freezing user space processes ... (elapsed 0.01
> seconds) done.
> > [   13.324859] Freezing remaining freezable tasks ... (elapsed 0.02
> seconds) done.
> > [   13.356140] Suspending console(s) (use no_console_suspend to
> debug)
> > [   13.487823] PM: suspend of devices complete after 120.578 msecs
> > [   13.491577] PM: late suspend of devices complete after 3.722 mse=
cs
> > [   13.497375] PM: noirq suspend of devices complete after 5.767
> msecs
> > [   13.497436] Disabling non-boot CPUs ...
> > [   15.806640] Powerdomain (iva2_pwrdm) didn't enter target state 1
> > [   15.806640] Powerdomain (dss_pwrdm) didn't enter target state 1
> > [   15.806671] Powerdomain (per_pwrdm) didn't enter target state 1
> > [   15.806671] Powerdomain (core_pwrdm) didn't enter target state 1
> > [   15.806671] Powerdomain (usbhost_pwrdm) didn't enter target stat=
e
> 1
> > [   15.806671] Could not enter target state in pm_suspend
> > [   15.809722] PM: noirq resume of devices complete after 2.868 mse=
cs
> > [   15.813598] PM: early resume of devices complete after 2.380 mse=
cs
> > [   16.179382] mmc1: error -110 during resume (card was removed?)
> > [   16.189575] PM: resume of devices complete after 375.824 msecs
> > [   16.279602] Restarting tasks ... done.
> > sh: write error: Operation not permitted
>=20
> Thanks for the test.  Perhaps you could try the following untested
> patch?
>=20
>=20
> - Paul
>=20

Thanks Paul,

That patch does indeed seem to fix all my problems!

With it I can now suspend, and all power domains hit the target states.

Kevin - I did reply to your request for logs, but haven't seen the mess=
age make it to the mailing list...
If you've not got it, let me know and I can try and send it again.

Cheers,
Joe

> ---
>  arch/arm/mach-omap2/pm34xx.c |   14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/pm34xx.c
> b/arch/arm/mach-omap2/pm34xx.c
> index e4fc88c..ced2f76 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -545,13 +545,10 @@ static void __init prcm_setup_regs(void)
>  			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
> =20
>  	/* Don't attach IVA interrupts */
> -	if (omap3_has_iva()) {
> -		omap2_prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
> -		omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
> -		omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
> -		omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD,
> -					OMAP3430_PM_IVAGRPSEL);
> -	}
> +	omap2_prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
> +	omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
> +	omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
> +	omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL)=
;
> =20
>  	/* Clear any pending 'reset' flags */
>  	omap2_prm_write_mod_reg(0xffffffff, MPU_MOD, OMAP2_RM_RSTST);
> @@ -565,8 +562,7 @@ static void __init prcm_setup_regs(void)
>  	/* Clear any pending PRCM interrupts */
>  	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET)=
;
> =20
> -	if (omap3_has_iva())
> -		omap3_iva_idle();
> +	omap3_iva_idle();
> =20
>  	omap3_d2d_idle();
>  }
> --=20
> 1.7.10


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
