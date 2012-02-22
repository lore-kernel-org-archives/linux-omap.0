From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Latest OMAP randconfig build error
Date: Wed, 22 Feb 2012 22:22:23 +0200
Message-ID: <CAK=WgbYCUCwCnqMPAmmK6+rjxiOcdz3B-kB5ChZrxn_wW3wJiw@mail.gmail.com>
References: <20120222085130.GE22675@n2100.arm.linux.org.uk>
 <CAK=WgbYxJyLoYs6vcj0dhSSAFX3vHqZAOHcr9t3+xEAh4ZPBNA@mail.gmail.com>
 <20120222175822.GV18185@atomide.com> <CAK=WgbY1b4qJXNr7=KyjdqGfexrum=XpTF3QYsw=OgFzv5NQ_A@mail.gmail.com>
 <20120222201236.GA8533@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42483 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab2BVUWn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 15:22:43 -0500
Received: by iacb35 with SMTP id b35so477942iac.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 12:22:43 -0800 (PST)
In-Reply-To: <20120222201236.GA8533@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "Anna, Suman" <s-anna@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

On Wed, Feb 22, 2012 at 10:12 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> +#ifdef CONFIG_ARCH_OMAP2
> +struct omap_mbox *omap2_mboxes[] =3D {
> + =A0 =A0 =A0 &mbox_dsp_info,
> +#ifdef CONFIG_SOC_OMAP2420
> + =A0 =A0 =A0 &mbox_iva_info,
> +#endif
> + =A0 =A0 =A0 NULL
> +};
> =A0#endif

Beautiful. Thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
