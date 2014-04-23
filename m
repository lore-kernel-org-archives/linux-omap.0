From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH RFC] ARM: dts: am335x: update USB DT references
Date: Wed, 23 Apr 2014 12:17:34 -0300
Message-ID: <20140423151734.GA5867@arch.cereza>
References: <1397647595-10927-1-git-send-email-leigh@solinno.co.uk>
 <5356794C.7070707@baylibre.com>
 <20140423144822.GA4833@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:58763 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753720AbaDWPSF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 11:18:05 -0400
Content-Disposition: inline
In-Reply-To: <20140423144822.GA4833@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Leigh Brown <leigh@solinno.co.uk>, Mugunthan V N <mugunthanvnm@ti.com>, devicetree@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Apr 23, Tony Lindgren wrote:
> * Benoit Cousson <bcousson@baylibre.com> [140422 07:14]:
> > Hi Leigh,
> >=20
> > On 16/04/2014 13:26, Leigh Brown wrote:
> > >In "ARM: dts: am33xx: correcting dt node unit address for usb", th=
e
> > >usb_ctrl_mod and cppi41dma nodes were updated with the correct reg=
ister
> > >addresses.  However, the dts files that reference these nodes were=
 not
> > >updated, and those devices are no longer being enabled.
> > >
> > >This patch corrects the references for the affected dts files.

Maybe someone can take care of using phandles instead?

This way, the board's dts files would be immune to such .dtsi changes.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
