From: "zil iram" <zil_iram@hotmail.com>
Subject: Re: SPI question
Date: Tue, 16 Jan 2007 02:21:06 +0000
Message-ID: <BAY130-F2459181A95E221191757ABF8B40@phx.gbl>
References: <200701151327.45318.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200701151327.45318.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: david-b@pacbell.net, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks Dave! Yep, calling it an API is a misnomer.. hhehehe, my bad. I am 
using the spidev driver by Andrea P. for my protocol driver. Do I need to 
add my sensor info to the board-osk.c, since it is connected to chip select 
1? Coz the probe function in the spidev driver is not called during start up 
of the kernel.

And may I know what exactly is the ads7846 driver? and the Mistral QVGA 
board?


>From: David Brownell <david-b@pacbell.net>
>To: linux-omap-open-source@linux.omap.com
>CC: "zil iram" <zil_iram@hotmail.com>
>Subject: Re: SPI question
>Date: Mon, 15 Jan 2007 13:27:44 -0800
>
>On Monday 15 January 2007 6:29 am, zil iram wrote:
> >             I am working on SPI on the osk right now. I connected a 
>sensor
> > to the uwire pins of the osk.
> > I enabled the spi driver(spi.c),
>
>That's the SPI "framework".  Which involves a controller driver (behind the
>programming interface) and at least one "protocol" driver.
>
>
> > and the microwire driver for omap. Is it
> > enough to use the spi.c APIs to access(read/write) the sensor that I 
>have
> > attached through SPI? Does the SPI core driver(spi.c) wrap the microwire
> > driver?
>
>Yes, and yes.  Although calling kernel programming interfaces an
>"Application Programming Interface" (API) is a misnomer.  :)
>
>- Dave

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/
