From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 03/17] spi/qspi: parse register by name.
Date: Tue, 26 Nov 2013 16:47:49 +0530
Message-ID: <5294835D.5090902@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com> <1385451313-1875-4-git-send-email-sourav.poddar@ti.com> <20131126103029.GY14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131126103029.GY14725-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 November 2013 04:00 PM, Mark Brown wrote:
> On Tue, Nov 26, 2013 at 01:04:59PM +0530, Sourav Poddar wrote:
>> Modify the qspi driver to parse reg information by name.
> This presumably needs an update to the device tree bindings so that
> there's a name defined?
I have added "reg-names" property in dt bindings. (17/17) patch of
this series has that info.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
