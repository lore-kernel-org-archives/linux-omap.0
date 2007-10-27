From: David Brownell <david-b@pacbell.net>
Subject: Re: TSC2101 kernel compilation error: Touch & Audio IOCTLs questions
Date: Fri, 26 Oct 2007 23:00:39 -0700
Message-ID: <200710262300.40124.david-b@pacbell.net>
References: <7f3c88400710261245o2cc4b77bq8739fbdb29ceadc6@mail.gmail.com>
	<4722CFB8.8000803@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4722CFB8.8000803@googlemail.com>
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

On Friday 26 October 2007, Dirk Behme wrote:
> Seems that
> 
> drivers/input/touchscreen/omap/ts_hx.c
> sound/arm/omap/omap-alsa-tsc2101.c
> sound/arm/omap/omap-alsa-tsc2101-mixer.c
> 
> still need to be converted to the reworked interface.

... and maybe hooked up to the drivers/spi/tsc210x.c code ...
