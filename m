From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH RFC] ARM: dts: am335x: update USB DT references
Date: Wed, 23 Apr 2014 12:48:43 -0300
Message-ID: <20140423154842.GA6969@arch.cereza>
References: <1397647595-10927-1-git-send-email-leigh@solinno.co.uk>
 <5356794C.7070707@baylibre.com>
 <20140423144822.GA4833@atomide.com>
 <20140423151734.GA5867@arch.cereza>
 <5357DEF0.7030000@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59065 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753825AbaDWPtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 11:49:12 -0400
Content-Disposition: inline
In-Reply-To: <5357DEF0.7030000@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, Leigh Brown <leigh@solinno.co.uk>, Mugunthan V N <mugunthanvnm@ti.com>, devicetree@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>

On Apr 23, Benoit Cousson wrote:
> Hi Ezequiel,
>=20
> On 23/04/2014 17:17, Ezequiel Garcia wrote:
> >On Apr 23, Tony Lindgren wrote:
> >>* Benoit Cousson <bcousson@baylibre.com> [140422 07:14]:
> >>>Hi Leigh,
> >>>
> >>>On 16/04/2014 13:26, Leigh Brown wrote:
> >>>>In "ARM: dts: am33xx: correcting dt node unit address for usb", t=
he
> >>>>usb_ctrl_mod and cppi41dma nodes were updated with the correct re=
gister
> >>>>addresses.  However, the dts files that reference these nodes wer=
e not
> >>>>updated, and those devices are no longer being enabled.
> >>>>
> >>>>This patch corrects the references for the affected dts files.
> >
> >Maybe someone can take care of using phandles instead?
> >
> >This way, the board's dts files would be immune to such .dtsi change=
s.
>=20
> Indeed, that will avoid such issues.
>=20
> Are you volunteer for that cleanup ? :-)
>=20

Sure, I've already done that for my custom dts. It's a simple change.

If someone feels like doing this before I get to send the patches,
be my guest :-)
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
