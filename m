From: Mike Chan <mikechan@google.com>
Subject: Re: [PATCH] OMAP3: PM: SDRC: ensure mux of SDRC clock enable pins for
	self-refresh
Date: Thu, 21 May 2009 16:17:19 -0700
Message-ID: <f476eb440905211617y3ccf85f7i7fff7f7cad147fed@mail.gmail.com>
References: <1242835699-11113-1-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.0905211635560.26015@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:36528 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119AbZEUXRn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2009 19:17:43 -0400
Received: from spaceape10.eur.corp.google.com (spaceape10.eur.corp.google.com [172.28.16.144])
	by smtp-out.google.com with ESMTP id n4LNHg7G029466
	for <linux-omap@vger.kernel.org>; Fri, 22 May 2009 00:17:42 +0100
Received: from pzk34 (pzk34.prod.google.com [10.243.19.162])
	by spaceape10.eur.corp.google.com with ESMTP id n4LNGrEQ022244
	for <linux-omap@vger.kernel.org>; Thu, 21 May 2009 16:17:40 -0700
Received: by pzk34 with SMTP id 34so1131391pzk.11
        for <linux-omap@vger.kernel.org>; Thu, 21 May 2009 16:17:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0905211635560.26015@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Thu, May 21, 2009 at 3:37 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi Kevin
>
> On Wed, 20 May 2009, Kevin Hilman wrote:
>
> > diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.=
c
> > index c832d83..d7807e2 100644
> > --- a/arch/arm/mach-omap2/sdrc.c
> > +++ b/arch/arm/mach-omap2/sdrc.c
> > @@ -136,5 +136,13 @@ void __init omap2_sdrc_init(struct omap_sdrc_p=
arams *sp)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << SDRC_POWER_PWDENA_SHIFT) |
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << SDRC_POWER_PAGEPOLICY_SHIFT);
> > =A0 =A0 =A0 sdrc_write_reg(l, SDRC_POWER);
> > +
> > + =A0 =A0 /* Ensure SDRC pins for both chip selcts are mux'd proper=
ly
> > + =A0 =A0 =A0* for self-refresh */
> > + =A0 =A0 if (cpu_is_omap34xx()) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 omap_cfg_reg(H16_34XX_SDRC_CKE0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 omap_cfg_reg(H17_34XX_SDRC_CKE1);
> > + =A0 =A0 }
> > +
> > =A0 =A0 =A0 omap2_sms_save_context();
> > =A0}
>
> would suggest keeping pin remuxing in board-*.c or maybe chip-*.c fil=
es;
> ideally this file would only pertain to the SDRC IP block itself.
>
>
> - Paul

Is there a reason why any board-*.c would not want this? It seems a
little silly for everyone to be doing the same repetitive pin muxing
if they want to suspend properly for a reasonable amount of time.

- Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
