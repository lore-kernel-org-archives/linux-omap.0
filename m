From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] OMAP4: McBSP: Clear rx_irq at probe time
Date: Wed, 18 May 2011 15:39:46 +0300
Message-ID: <201105181539.46959.peter.ujfalusi@ti.com>
References: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com> <20110517152954.477365e6.jhnikula@gmail.com> <20110517125700.GY5323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39315 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933012Ab1ERMjv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 08:39:51 -0400
In-Reply-To: <20110517125700.GY5323@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

Hi Tony,

On Tuesday 17 May 2011 15:57:00 Tony Lindgren wrote:
> This file should be under drivers/ somewhere, can you
> guys please take care of that?

Do you have a place in mind?
We have several things under arch/arm/plat-omap, like i2c, dma, fb, gpi=
o,=20
mcbsp, usb...
Should we create a directory for omap specific drivers under drivers?
=46or example drivers/omap/ and move the mcbsp there first, without any=
 API=20
change?
If needed we can think of changing the interface within McBSP if it is =
needed=20
for other use later.
IMHO invention a common framework (as Jarkko was suggesting) for simila=
r=20
interfaces need more work, and synchronization between other platforms.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
