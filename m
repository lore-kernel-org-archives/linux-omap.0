From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH - Omapzoom] [NAND] Add prefetch and DMA support
Date: Mon, 8 Sep 2008 15:27:35 -0700
Message-ID: <200809081527.35446.david-b@pacbell.net>
References: <DFEF307E035C8647B119E6A60DB62D4AEE4F7561@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:41648 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753522AbYIHW1h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 18:27:37 -0400
In-Reply-To: <DFEF307E035C8647B119E6A60DB62D4AEE4F7561@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kamat, Nishant" <nskamat@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Singh, Vimal" <vimalsingh@ti.com>

On Monday 08 September 2008, Kamat, Nishant wrote:
> +config MTD_NAND_OMAP_PREFETCH
> + =A0 =A0 =A0 bool "GPMC prefetch support for NAND Flash device"
> + =A0 =A0 =A0 depends on MTD_NAND && MTD_NAND_OMAP2
> + =A0 =A0 =A0 default n
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0The NAND device can be accessed for Read/Write using=
 GPMC PREFETCH engine
> + =A0 =A0 =A0 =A0to improve the performance.

Is there a reason this isn't always enabled, and the choice is just
whether to use DMA or not?


I'd be interested to see performance measurements for the three cases.

	- current/slow code
	- the readsw() update I sent previously
	- this "prefetch engine"

And I'd expect this "prefetch engine" code would also be improved by
using readsw() and writesw() when DMA isn't in use.

On one ARM926 I observed a 16% speedup *just* from switching from
slow byte-at-a-time PIO to using readsb ... this current code has
that same pessimization.

- Dave


> +
> +choice
> + =A0 =A0 =A0 prompt "Prefetch engine support for GPMC"
> + =A0 =A0 =A0 depends on MTD_NAND_OMAP_PREFETCH
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0The GPMC PREFETCH engine can be configured eigther i=
n MPU interrupt mode
> + =A0 =A0 =A0 =A0or in DMA interrupt mode.
> +
> +config MTD_NAND_OMAP_PREFETCH_MPU
> + =A0 =A0 =A0 depends on MTD_NAND_OMAP_PREFETCH
> + =A0 =A0 =A0 bool "MPU mode always for spare area + MPU mode for mai=
n area"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0Say y if... you want MPU interrupt mode for both spa=
re area and main area accesses.
> +
> +config MTD_NAND_OMAP_PREFETCH_DMA
> + =A0 =A0 =A0 depends on MTD_NAND_OMAP_PREFETCH
> + =A0 =A0 =A0 bool "MPU mode always for spare area + DMA mode for mai=
n area"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0Say y if... you want MPU interrupt mode for spare ar=
ea and DMA mode for main
> + =A0 =A0 =A0 =A0area access.
> +
> +endchoice
> +


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
