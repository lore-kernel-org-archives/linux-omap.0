From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: Common code for TSC 2101 and 2102
Date: Mon, 24 Sep 2007 00:37:21 +0200
Message-ID: <fb249edb0709231537p4de2f11aic934938f92e2936e@mail.gmail.com>
References: <fb249edb0706040644w55ac4c55k495ae2050f94aea0@mail.gmail.com>
	<200708102004.59747.david-b@pacbell.net>
	<20070813070512.GC13948@atomide.com>
	<200708132234.41538.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200708132234.41538.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi, sorry for late reply, I'm just catching up with email now.

On 14/08/2007, David Brownell <david-b@pacbell.net> wrote:
> Following this will be several patches, two related to
> this driver:
>
>  - H4 board support, using TSC2101 (not TSC2102)
>  - A biggish tsc210x cleanup patch, with some bugfixes

Thanks for this work.

>
> For boards using external VREF, that value should be in
> the tsc210x chip platform data.  (And Andrzej, I'm
> curious why you settled on VREF=1.25V vs 2.50V ... not
> that it's necessarily an issue, just "why".  A comment
> in the code might be good.)

Oh, I'm afraid I left it to be made configurable by the first person
who needs VREF of 2.5V, out of laziness. I settled on 1.25V
specifically because that's what PalmOS (the OS that ships with Palm
Tungsten E) uses. The device is a consumer PDA and I have no
schematics or even multimeter access to the chips, and likely I
wouldn't know how to use it if I had.

>
> Somewhat related, I think the TSC setup code should
> likely hold off until it can fetch calibration data
> from EEPROM or somesuch ... temperature readings are
> not all that useful until that data is available.
> Alternatively, do like I did in ads7846:  punt it all
> to userspace, just provide the raw milliVolt readings
> and expect someone else to compute temperature.

The board setup code can defer the TSC setup by registering the
tsc210x device only after all information is available to fill in the
pdata struct.

Regards
