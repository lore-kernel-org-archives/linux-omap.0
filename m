From: "zil iram" <zil_iram@hotmail.com>
Subject: SPI controller on omap5912
Date: Thu, 25 Jan 2007 02:06:10 +0000
Message-ID: <BAY130-F25DF6A55824D7E1548ED8EF8A30@phx.gbl>
References: <200701241125.24668.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200701241125.24668.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: david-b@pacbell.net, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Okey thanks Dave.

Has anyone used the "spi" controller on omap before? Is there an omap kernel 
which supports the "spi controller?"

Thanks,
Lizette

>From: David Brownell <david-b@pacbell.net>
>To: linux-omap-open-source@linux.omap.com
>CC: "zil iram" <zil_iram@hotmail.com>
>Subject: Re: SPI pins on omap5912
>Date: Wed, 24 Jan 2007 11:25:24 -0800
>
>On Wednesday 24 January 2007 6:21 am, zil iram wrote:
> > Hi,
> >
> > I am using linux 2.6.17 on the omap5912 board. I would like to use the 
>spif
> > pins, spif_cs0, spif_din, spif_dout, spif_sck on the board and connect 
>them
> > to the spi pins on my device. Do I still need to make my own controller
> > driver for the spi framework?
>
>yes
>
> > Or can I use the omap_uwire?
>
>not unless you're using the microwire controller ...

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
