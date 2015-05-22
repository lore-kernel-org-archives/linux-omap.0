From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] tty: serial: omap: use mctrl_gpio helpers
Date: Fri, 22 May 2015 10:34:23 -0500
Message-ID: <555F4C7F.9020307@ti.com>
References: <1432297017-1264-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59960 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757212AbbEVPei (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 May 2015 11:34:38 -0400
In-Reply-To: <1432297017-1264-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegorslists@googlemail.com, linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, gregkh@linuxfoundation.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Sekhar Nori <nsekhar@ti.com>

On 05/22/2015 07:16 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
> signals.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  .../devicetree/bindings/serial/omap_serial.txt     |    9 +
>  drivers/tty/serial/Kconfig                         |    1 +
>  drivers/tty/serial/omap-serial.c                   |  168 +++++++++++++++++++-
>  3 files changed, 171 insertions(+), 7 deletions(-)

Would we rather move introducing new features to 8250_omap.c rather
than doing that to omap-serial and keep feature creeping it such that
we wont ever be able to switch to 8250_omap ?


-- 
Regards,
Nishanth Menon
