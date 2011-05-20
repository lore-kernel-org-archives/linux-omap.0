From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Fri, 20 May 2011 10:03:50 +0300
Message-ID: <201105201003.50500.peter.ujfalusi@ti.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com> <4DD5BCD0.6040009@gmail.com> <20110520092911.d725b9c4.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37325 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932614Ab1ETHDx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 May 2011 03:03:53 -0400
In-Reply-To: <20110520092911.d725b9c4.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Steve Calfee <stevecalfee@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

Hi,

On Friday 20 May 2011 09:29:11 Jarkko Nikula wrote:
> This very likely sounds that in master mode the master clock to McBSP=
 is
> missing if there is no DMA running.

If the clock setup is correct for McBSP, than it runs the clocks, and s=
hifts=20
out data.

> Did you try to use internal 96 MHz
> from my example or did you try to use external CLKS what Pandora is
> using? That CLKS setup in Pandora requires that there is a clock comi=
ng
> to McBSP CLKS pin.

Really good point. PRCM/CORE (depending on the McBSP port) 96M_FCLK mus=
t be=20
used here.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
