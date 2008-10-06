From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch twl 1/2] remove <linux/i2c/twl4030-rtc.h>
Date: Mon, 6 Oct 2008 09:39:44 -0700
Message-ID: <200810060939.45259.david-b@pacbell.net>
References: <200810012342.50866.david-b@pacbell.net> <87hc7pvkj9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:26747 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752717AbYJFQjr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 12:39:47 -0400
In-Reply-To: <87hc7pvkj9.fsf@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Monday 06 October 2008, Kevin Hilman wrote:
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -40,7 +40,6 @@
> =A0#include <mach/keypad.h>
> =A0#include <mach/dma.h>
> =A0#include <mach/gpmc.h>
> -#include <linux/i2c/twl4030-rtc.h>
> =A0
> =A0#include <asm/io.h>
> =A0#include <asm/delay.h>

Good catch -- my bad. =20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
