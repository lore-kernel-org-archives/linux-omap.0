From: Mike Chan <mike@android.com>
Subject: Re: [PATCH] SDRC: Remove SDRC_POWER register configuration from SDRC
	init.
Date: Thu, 18 Jun 2009 12:00:42 -0700
Message-ID: <8bb80c380906181200i58d949c2y4b8cc0cf4d95e448@mail.gmail.com>
References: <1245245721-7052-1-git-send-email-Artem.Bityutskiy@nokia.com>
	 <alpine.DEB.2.00.0906171021120.3382@utopia.booyaka.com>
	 <62697B07E9803846BC582181BD6FB6B80D704A359D@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:37346 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378AbZFRTAj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 15:00:39 -0400
Received: by pxi27 with SMTP id 27so1279704pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 12:00:42 -0700 (PDT)
In-Reply-To: <62697B07E9803846BC582181BD6FB6B80D704A359D@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: samu.p.onkalo@nokia.com
Cc: dderrick@ti.com, r-woodruff2@ti.com, rnayak@ti.com, Artem.Bityutskiy@nokia.com, paul@pwsan.com, linux-omap@vger.kernel.org, tony@atomide.com

On Wed, Jun 17, 2009 at 11:03 PM, <samu.p.onkalo@nokia.com> wrote:
>
> Hi,
>
> Perhaps someone from TI could comment that. I'm not sure if I can sha=
re
> errata information for public discussion.
>
> Br,
> Samu
>
> >-----Original Message-----
> >From: ext Paul Walmsley [mailto:paul@pwsan.com]
> >Sent: 17 June, 2009 19:25
> >To: Onkalo Samu.P (Nokia-D/Tampere); Bityutskiy Artem
> >(Nokia-D/Helsinki)
> >Cc: linux-omap@vger.kernel.org; Tony Lindgren
> >Subject: Re: [PATCH] SDRC: Remove SDRC_POWER register
> >configuration from SDRC init.
> >
> >Hello Samu, Artem,
> >
> >On Wed, 17 Jun 2009, Artem Bityutskiy wrote:
> >
> >> From: Samu Onkalo <samu.p.onkalo@nokia.com>
> >>
> >> Bootloader must configure proper settings for SDRC before starting
> >> kernel from SDRAM. Furthermore, removed lines violated omap3430 an=
d
> >> omap2420 SDRC errata (see errata 1.150)
> >

This seems like it will make the kernel even more dependent on the
bootloader. As an example, there's code such as the IVA2 reset which
attempts to put the hardware in a good state even if the bootloader
screws up. Unfortunately not everyone has access to their bootloader
code.

-- Mike

>
> >The 2420 and 3430 errata data here seems to be old; neither
> >one contains 1.150. =A0While I wait for a new version to arrive,
> >can you provide some more context on this errata? =A0Does it
> >imply any restrictions on programming SDRC_POWER from SRAM,
> >e.g., the CORE DVFS code?
> >
> >
> >- Paul
> >
> >>
> >> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> >> ---
> >> =A0arch/arm/mach-omap2/sdrc.c | =A0 10 ++--------
> >> =A01 files changed, 2 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc=
=2Ec
> >> index 2045441..0874687 100644
> >> --- a/arch/arm/mach-omap2/sdrc.c
> >> +++ b/arch/arm/mach-omap2/sdrc.c
> >> @@ -86,8 +86,8 @@ void __init omap2_set_globals_sdrc(struct
> >omap_globals *omap2_globals)
> >> =A0 * @sp: pointer to a null-terminated list of struct omap_sdrc_p=
arams
> >> =A0 *
> >> =A0 * Turn on smart idle modes for SDRAM scheduler and controller.
> >> - * Program a known-good configuration for the SDRC to deal
> >with buggy
> >> - * bootloaders.
> >> + * Bootloaders should make proper configuration for SDRC
> >since kernel
> >> + * is running from SDRAM.
> >> =A0 */
> >> =A0void __init omap2_sdrc_init(struct omap_sdrc_params *sp) =A0{ @=
@
> >> -104,10 +104,4 @@ void __init omap2_sdrc_init(struct
> >omap_sdrc_params *sp)
> >> =A0 =A0 =A0sdrc_write_reg(l, SDRC_SYSCONFIG);
> >>
> >> =A0 =A0 =A0sdrc_init_params =3D sp;
> >> -
> >> - =A0 =A0/* XXX Enable SRFRONIDLEREQ here also? */
> >> - =A0 =A0l =3D (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
> >> - =A0 =A0 =A0 =A0 =A0 =A0(1 << SDRC_POWER_PWDENA_SHIFT) |
> >> - =A0 =A0 =A0 =A0 =A0 =A0(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
> >> - =A0 =A0sdrc_write_reg(l, SDRC_POWER);
> >> =A0}
> >> --
> >> 1.6.0.6
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> >linux-omap"
> >> in the body of a message to majordomo@vger.kernel.org More majordo=
mo
> >> info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >
> >
> >- Paul
> >--
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
