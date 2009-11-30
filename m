From: Peter Barada <peterb@logicpd.com>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Mon, 30 Nov 2009 11:36:50 -0500
Message-ID: <1259599010.4649.51.camel@thunk>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:27903 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752132AbZK3Qgl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 11:36:41 -0500
In-Reply-To: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Mon, 2009-11-30 at 10:46 +0200, Mika Westerberg wrote:
> Hi Tony,
> 
> Current omap serial driver takes control of all 3 (4 on OMAP3640)
> UARTS. However, we have such a setup where UART2 for example is used
> by bluetooth driver. It uses the UART as non-standard way (there are
> some Nokia extensions to H4 protocol) so we cannot use the standard
> driver for driving the UART but have written special one for that
> purpose.
> 
> Question is: Is there any, upstreamable, way of preventing omap serial
> driver to do this? Currently this is done with custom #ifdef hackery to
> mach-omap2/serial.c. Alternative solution that comes into mind is to
> specify UART configuration in board files and let serial driver to use
> that instead of hard-coded one. Or do you have some nice alternatives?

Previously (back around 2.6.28-rc8) in the board file, the
omap_uart_config struct controlled which serial ports were enabled on
startup.  It was used in omap_serial_init, and it looks like that code
went away with the following commit:
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blobdiff;f=arch/arm/mach-omap2/serial.c;h=2e17b57f5b23bb6703a2d621103585af1d8d729b;hp=555e735524381cbf8ef9f20d778ad81f9438e24e;hb=4355c41a635943d30e9396b95185314343dcb551;hpb=7e9ccf7776bb68b5367eb0bb35e519df62bea35c

I'm kinda in the same boat as I want to use some of the unused serial
port pins for GPIO, but they are setup as serial ports....


> Thanks,
> MW
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

