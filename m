From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 04/17] spi/qspi: parse control module register.
Date: Tue, 26 Nov 2013 16:48:58 +0530
Message-ID: <529483A2.3080000@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com> <1385451313-1875-5-git-send-email-sourav.poddar@ti.com> <20131126103104.GZ14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131126103104.GZ14725-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 November 2013 04:01 PM, Mark Brown wrote:
> On Tue, Nov 26, 2013 at 01:05:00PM +0530, Sourav Poddar wrote:
>> In qspi controller, we need to switch to memory mapped operations.
>> These switching depends on
> This will need to be added to the DT binding.


I have added a "reg-name" property. Does we need to add individual 
reg-names also?


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
