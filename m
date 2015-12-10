From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 4/5] ARM: dts: DRA7: add entry for qspi mmap region
Date: Thu, 10 Dec 2015 10:34:23 +0530
Message-ID: <566907D7.6040003@ti.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
 <1448860515-28336-5-git-send-email-vigneshr@ti.com>
 <20151130223408.GJ23396@atomide.com> <565D25E6.4070206@ti.com>
 <20151201163950.GR23396@atomide.com> <566017A8.5040106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <566017A8.5040106-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 12/03/2015 03:51 PM, Vignesh R wrote:
> 
> 
> On 12/01/2015 10:09 PM, Tony Lindgren wrote:
>> * Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> [151130 20:46]:
>>> On 12/01/2015 04:04 AM, Tony Lindgren wrote:
>>>>
...
>>
>> OK. They are both on L3 main so that won't cause any issues for separate
>> interconnect driver instances. As they are still separate targets flushing
>> a posted write to one area will not flush anything to the other.
>>
> 
> I didn't quite understand what you meant by interconnect driver instance.
> qspi_base and qspi_mmap region are tightly bound to each other and both
> needs to be accessed by ti-qspi driver (though different targets).
> Besides qspi_mmap region is only used to read data, there will not be
> any write accesses to this target. Are you saying this binding is not
> viable?
> 

As I stated above qspi_base and qspi_mmap region are tightly bound,
there is no way to use qspi_mmap region w/o accessing qspi_base. So I am
planning to keep them as it is. I will move qspi_ctrlmod to use syscon.
Something like:

qspi: qspi@4b300000 {
       compatible = "ti,dra7xxx-qspi";
       reg = <0x4b300000 0x100>,
             <0x5c000000 0x4000000>,
       reg-names = "qspi_base", "qspi_mmap";
       syscon-chipselects = <&scm_conf 0x558>;
       #address-cells = <1>;
       #size-cells = <0>;
       spi-max-frequency = <48000000>;
       ti,hwmods = "qspi";
};

Do you think this is not viable in future?


-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
