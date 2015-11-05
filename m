From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/5] spi: spi-ti-qspi: add mmap mode read support
Date: Thu, 5 Nov 2015 11:46:09 +0530
Message-ID: <563AF429.1000406@ti.com>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
 <1446545174-14193-3-git-send-email-vigneshr@ti.com>
 <20151104144112.GJ1717@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151104144112.GJ1717-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 11/04/2015 08:11 PM, Mark Brown wrote:
> On Tue, Nov 03, 2015 at 03:36:11PM +0530, Vignesh R wrote:
> 
>> +	ti_qspi_enable_memory_map(spi);
>> +	ti_qspi_setup_mmap_read(spi, read_opcode, addr_width,
>> +				dummy_bytes);
>> +	memcpy_fromio(buf, qspi->mmap_base + from, len);
>> +	*retlen = len;
>> +	ti_qspi_disable_memory_map(spi);
> 
> We'll be constantly enabling and disabling memory mapping with this.
> I'm not sure that's a meaningful cost given that it doesn't actually
> remap anything but rather just switches hardware modes, we can always
> optimise it later if it is.
> 

Hmm, I will move the ti_qspi_disable_memory_map() call to
ti_qspi_start_transfer_one(), so that mmap mode is disabled only when
normal SPI bus transfer is requested. Further, "mmap_enabled" status
flag can be used to determine whether mode switch is required or not.
This should help to overcome enabling and disabling memory mapping
between successive mmap read requests.

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
