From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: Enabling spidev in MCSPI1
Date: Wed, 13 Jan 2010 19:03:49 +0530 (IST)
Message-ID: <62081.10.24.255.18.1263389629.squirrel@dbdmail.itg.ti.com>
References: <4B4DC3FB.3020702@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42050 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993Ab0AMNdv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jan 2010 08:33:51 -0500
In-Reply-To: <4B4DC3FB.3020702@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> I'm trying to enable spidev on mcspi1, but when I do, the kernel while
> booting after the kernel is uncompressed. No useful messages are
> displayed. This is with a current git.
>
> I've attached the diff I use to add the spi driver to the board file.
> (OVero + Summit).
>
> With the #if 0 inplace the kernel boots, enable that code and it fails.
>
> +#if 0
> +       spi_register_board_info(overo_mcspi_board_info,
> +               ARRAY_SIZE(overo_mcspi_board_info));
> +#endif
>
> Does anyone see anything obviously wrong with what I am doing?
>

Is SPI1 also used for touchscreen on your board, if so it might be conflicting

