From: David Brownell <david-b@pacbell.net>
Subject: Re: SPI question
Date: Mon, 15 Jan 2007 13:27:44 -0800
Message-ID: <200701151327.45318.david-b@pacbell.net>
References: <BAY130-F292E20F8C782D7087AF55BF8B50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <BAY130-F292E20F8C782D7087AF55BF8B50@phx.gbl>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 15 January 2007 6:29 am, zil iram wrote:
>             I am working on SPI on the osk right now. I connected a sensor 
> to the uwire pins of the osk.
> I enabled the spi driver(spi.c),

That's the SPI "framework".  Which involves a controller driver (behind the
programming interface) and at least one "protocol" driver.


> and the microwire driver for omap. Is it  
> enough to use the spi.c APIs to access(read/write) the sensor that I have 
> attached through SPI? Does the SPI core driver(spi.c) wrap the microwire 
> driver?

Yes, and yes.  Although calling kernel programming interfaces an
"Application Programming Interface" (API) is a misnomer.  :)

- Dave
