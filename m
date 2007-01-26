From: "zil iram" <zil_iram@hotmail.com>
Subject: Re: SPI controller on omap5912
Date: Fri, 26 Jan 2007 10:32:59 +0000
Message-ID: <BAY130-F164C85B58F5F5426D02C6EF8A20@phx.gbl>
References: <200701241833.47414.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200701241833.47414.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: david-b@pacbell.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



Ok,
       So I was using the microwire controller on omap and used spidev by 
Andrea P. I connected the microwire pins to my device. I performed reads and 
writes to my device but all I get are 0s (same as when I do not attach any 
device to the microwire pins). I probed the pins using a logic analyzer and 
when I perform reads or writes, the CS pin is the only pin that gets signals 
(It goes active low when I perform reads and writes which is correct). The 
other pins do not get any signal at all. Even the clock is always low.

Could anyone tell me what could be the reason for this please?

Thanks,
Lizette


>From: David Brownell <david-b@pacbell.net>
>To: "zil iram" <zil_iram@hotmail.com>
>CC: linux-omap-open-source@linux.omap.com
>Subject: Re: SPI controller on omap5912
>Date: Wed, 24 Jan 2007 18:33:47 -0800
>
>On Wednesday 24 January 2007 6:06 pm, zil iram wrote:
> >
> > Okey thanks Dave.
> >
> > Has anyone used the "spi" controller on omap before?
>
>Almost certainly, or I expect TI would have desupported it by now.
>
> > Is there an omap kernel
> > which supports the "spi controller?"
>
>Do you see a driver for it in the current OMAP GIT tree?
>If not, that's probably your answer ... someone may have
>some code floating around to use it, though.

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
