From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Mon, 12 May 2014 13:03:54 -0300
Message-ID: <20140512160354.GA16440@arch.cereza>
References: <1395300886-383-1-git-send-email-pekon@ti.com>
 <1395300886-383-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59739 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752124AbaELQEa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 12:04:30 -0400
Content-Disposition: inline
In-Reply-To: <1395300886-383-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>

Pekon,

A few questions regarding this patch, despite the fact I'm not sure it =
will
ever be included.

On 20 Mar 01:04 PM, Pekon Gupta wrote:
> +			0x70 (MUX_MODE0 | PIN_INPUT_PULLUP )	/* gpmc_wait0.gpmc_wait0 */
> +			0x74 (MUX_MODE7 | PIN_OUTPUT_PULLUP)	/* gpmc_wpn.gpio0_30 */

Is this output pin?

> +			0x7c (MUX_MODE0 | PIN_OUTPUT_PULLUP)	/* gpmc_csn0.gpmc_csn0  */

Again: is this output pin?

> +		gpmc,wait-on-read =3D "true";
> +		gpmc,wait-on-write =3D "true";

The devicetree binding says these wait properties are bool, so the abov=
e
should be:

		gpmc,wait-on-read;
		gpmc,wait-on-write;

But the problem is that there's no wait-pin defined, so this not enable=
d.

Could you explain what should be the correct binding? This is very conf=
using
for me.

Thanks!
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
