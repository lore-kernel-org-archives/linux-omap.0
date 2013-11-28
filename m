From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 09/17] spi/spi.h: Add "mem" variable in spi master.
Date: Thu, 28 Nov 2013 10:08:44 +0530
Message-ID: <5296C8D4.80004@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com> <1385451313-1875-10-git-send-email-sourav.poddar@ti.com> <20131126130119.GH14725@sirena.org.uk> <52949C9F.10008@ti.com> <20131126132051.GO14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131126132051.GO14725-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 November 2013 06:50 PM, Mark Brown wrote:
> On Tue, Nov 26, 2013 at 06:35:35PM +0530, Sourav Poddar wrote:
>> On Tuesday 26 November 2013 06:31 PM, Mark Brown wrote:
>>> Is this really generic enough to put here rather than in the driver
>>> data?
>> The thought behind this was that if a master controller supports
>> memory mapped operation and slave wants to use memcpy in his
>> driver(bypassing spi ), then we should have a mean to communicate
>> between the
>> master and the slave. So, 'spi_master' seems to be the place for me
>> for this data,
>> which could be parsed in the slave side also.
> I would have expected that the address would be returned by the function
> that maps the buffer in rather than stored permanently in the master.
Yes, it could be be done the above way. I will change.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
