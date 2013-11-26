From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 11/17] spi/qspi: set "mmap" flag to true.
Date: Tue, 26 Nov 2013 18:41:40 +0530
Message-ID: <52949E0C.20203@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com> <1385451313-1875-12-git-send-email-sourav.poddar@ti.com> <20131126131029.GI14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131126131029.GI14725-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 November 2013 06:40 PM, Mark Brown wrote:
> On Tue, Nov 26, 2013 at 01:05:07PM +0530, Sourav Poddar wrote:
>> Set mmap flag to true to indicate that the qspi controller
>> supports memory mapped operations.
> Please combine some of these patches - adding the mmap support and then
> separately adding this flag isn't really helping bisection, just have
> one patch enabling support for mmap in the driver.  Similarly adding
> internal functions to the driver with no users and then separately
> adding the users isn't really adding much.
Sure, I will do that in my next version.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
