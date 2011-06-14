From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP4: McBSP: Clear rx_irq at probe time
Date: Tue, 14 Jun 2011 15:05:30 +0300
Message-ID: <20110614150530.87e594a5.jhnikula@gmail.com>
References: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com>
	<201106081051.27234.peter.ujfalusi@ti.com>
	<20110613133542.GD3352@atomide.com>
	<27857936.rzNg0PjYWH@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34730 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083Ab1FNMEK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 08:04:10 -0400
Received: by ewy4 with SMTP id 4so1965225ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Jun 2011 05:04:08 -0700 (PDT)
In-Reply-To: <27857936.rzNg0PjYWH@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

On Tue, 14 Jun 2011 14:19:34 +0300
P=E9ter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> We have discussion ongoing about the mcbsp code move, and so far the =
current=20
> understanding/plan is (Jarkko/Liam correct me if I'm wrong):
> - Fix the OMAP4 support
> - move the code under sound/soc/omap/
>  - the reason for this is that McBSP block can be only used for strea=
ming type=20
> of modes (from omap2430 onwards McBSP does not have clock stop functi=
onality).
> This makes other type of usage hard to say the least.
> - Clean up the code (remove the SPI mode, remove unused code paths at=
 the same=20
> time)
> - Consolidate the interface for audio only use

Yeah, now is perfect time to tell if there is any need for something
else than audio.

OMAP1xxx/59xx and 2420 are already something like more
than 5 years old obsolete components and we haven't seen that any of
them would need SPI/clock stop functionality. Actually we haven't seen
any other use for McBSP than audio.

> - Only OMAP3 has sidetone (on OMAP2 EAC block has the sidetone), migh=
t need=20
> some change, but I think the current way can be reused.
>=20
Yeah, they probably need work on kernel side (hwmod stuff etc) but I
think for keeping userspace intact over the cleanup we might want to
keep these special sysfs nodes for sidetone filter coefficients, dma
operating mode and FIFO threshold as it over the cleanup.

--=20
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
