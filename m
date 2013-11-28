From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 12/17] spi/qspi: convert driver to enable/disable memory
 mapped.
Date: Thu, 28 Nov 2013 16:38:27 +0530
Message-ID: <5297242B.3040807@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com> <1385451313-1875-13-git-send-email-sourav.poddar@ti.com> <20131126131138.GJ14725@sirena.org.uk> <5296D37C.2020003@ti.com> <20131128104922.GK14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131128104922.GK14725-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 28 November 2013 04:19 PM, Mark Brown wrote:
> On Thu, Nov 28, 2013 at 10:54:12AM +0530, Sourav Poddar wrote:
>
>> At the beginning of this api, I am doing a "disable memory mapped",
>> as becuase of
>> the code implemntation, if the control has reaches this api, memory
>> mapped is not
>> the desired operation. Then, at the end of this api after
>> "spi_finalize_current_message(master)", which indicated the current
>> transfer complete, I
>> issue a end of transfer command. Only after which, I enable memory
>> mapped mode again.
>> So, will the condition you mention above will hit.? Please help me
>> understand if i am
>> missing something?
> Removing the mapping isn't going to stop another context which has
> obtained a handle on the map trying to look at the mapping.
hmm..so the  'memcpy' part should be made atomic.(if possible?).
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
