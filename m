From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: am335x-bone-common: use phandles for
 USB and DMA refs
Date: Tue, 6 May 2014 09:37:18 -0700
Message-ID: <20140506163718.GK18474@atomide.com>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
 <1398718475-1883-1-git-send-email-guido@vanguardiasur.com.ar>
 <20140506161749.GN25849@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37815 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750942AbaEFQhY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2014 12:37:24 -0400
Content-Disposition: inline
In-Reply-To: <20140506161749.GN25849@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Guido =?utf-8?B?TWFydMOtbmV6?= <guido@vanguardiasur.com.ar>, bcousson@baylibre.com, linux-omap@vger.kernel.org, george.cherian@ti.com, Ezequiel =?utf-8?Q?Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>

* Felipe Balbi <balbi@ti.com> [140506 09:19]:
> On Mon, Apr 28, 2014 at 05:54:32PM -0300, Guido Mart=C3=ADnez wrote:
> > Use phandles instead of unit adresses to reference usb and dma node=
s.
> > This makes the DT more robust and readable.
> >=20
> > Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
>=20
> (acked wrong version previously, sorry)
>=20
> Acked-by: Felipe Balbi <balbi@ti.com>

Applying all four from the v2 into omap-for-v3.16/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
