From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: RE: [PATCH] ALSA: SoC: Add support for TI SDP3430
Date: Fri, 21 Nov 2008 00:18:46 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705A445CBB1@dlee07.ent.ti.com>
References: <1227241853-25944-1-git-send-email-mesak82@gmail.com>
 <200811202129.19255.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34195 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbYKUGS6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 01:18:58 -0500
In-Reply-To: <200811202129.19255.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "mesak82@gmail.com" <mesak82@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

> On Thursday 20 November 2008, mesak82@gmail.com wrote:
> > +=A0=A0=A0=A0=A0=A0=A0tristate "SoC Audio support for Texas Instrum=
ents SDP3430"
> > +=A0=A0=A0=A0=A0=A0=A0depends on SND_OMAP_SOC && MACH_OMAP_3430SDP
> > +=A0=A0=A0=A0=A0=A0=A0select SND_OMAP_SOC_MCBSP
> > +=A0=A0=A0=A0=A0=A0=A0select SND_SOC_TWL4030
>=20
> depends also on TWL4030_CORE, yes?
The machine driver itself doesn't depend on TWL4030_CORE, but TWL4030 S=
oC codec driver does (sound/soc/codecs/Kconfig)

config SND_SOC_TWL4030
        tristate
        depends on TWL4030_CORE

Although that dependency is overridden by _select_ statement.

What should be the best way to handle this dependency? Directly in kcon=
fig entry for each TWL4030-related machine driver?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
