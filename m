From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH, RFC] ARM: OMAP: Convert gpio-switch to platform_driver
Date: Fri, 10 Nov 2006 01:29:57 +0200
Message-ID: <20061109232957.GM16172@atomide.com>
References: <fb249edb0611051733x6fe980d4r7384d37f79797645@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0611051733x6fe980d4r7384d37f79797645@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [061106 03:42]:
> [I'm not very sure about this, but shouldn't the driver be a platform
> driver if its parent bus is the platform bus? It's especially annoying
> on resuming from sleep because the driver structure is passed to
> platform_resume_early() where it is casted to struct platform_device
> and .resume_early returns a bogus value. The kernel Oops'es but since
> the LCD is not yet resumed the device looks like dead and it's hard to
> track down.]
> 
> Converts the gpio-switch driver to platform_driver to avoid bad cast
> which occurs because the bus type is set to platform bus. Also
> silences the following warnings:
> 
> arch/arm/plat-omap/gpio-switch.c:292: warning: ignoring return value
> of 'device_create_file', declared with attribute warn_unused_result
> arch/arm/plat-omap/gpio-switch.c:293: warning: ignoring return value
> of 'device_create_file', declared with attribute warn_unused_result
> arch/arm/plat-omap/gpio-switch.c:294: warning: ignoring return value
> of 'device_create_file', declared with attribute warn_unused_result

Sounds like this code had missed the platform device conversion earlier.
Pushing today.

Tony
