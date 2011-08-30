From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/3] TI814X: Create board support and enable build for TI8148 EVM
Date: Mon, 29 Aug 2011 17:13:04 -0700
Message-ID: <878vqbpxin.fsf@ti.com>
References: <1312479903-22909-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:38480 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755086Ab1H3ANJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 20:13:09 -0400
Received: by pzk32 with SMTP id 32so10799014pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 17:13:07 -0700 (PDT)
In-Reply-To: <1312479903-22909-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Thu, 4 Aug 2011 23:15:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hemant Pedanekar <hemantp@ti.com> writes:

> This patch adds minimal support and build configuration for TI8148 EVM. Also
> adds support for low level debugging on UART1 console on the EVM.
>
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>

[...]

> +static void __init ti8148_init_early(void)
> +{
> +	omap2_init_common_infrastructure();
> +	omap2_init_common_devices(NULL, NULL);

Note that this function no longer exists in mainline.

Kevin

