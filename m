From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v4 0/4] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Thu, 4 Jul 2013 22:27:07 +0530
Message-ID: <51D5A963.6020102@ti.com>
References: <1372764757-29511-1-git-send-email-pekon@ti.com> <20980858CB6D3A4BAE95CA194937D5E73E9E46CA@DBDE04.ent.ti.com> <1372857987.9767.162.camel@sauron.fi.intel.com> <201307031527.17219.arnd@arndb.de> <20980858CB6D3A4BAE95CA194937D5E73E9E47B4@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33771 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756593Ab3GDQ6N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Jul 2013 12:58:13 -0400
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9E47B4@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "tony@atomide.com" <tony@atomide.com>, "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>, "olof@lixom.net" <olof@lixom.net>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On 7/3/2013 11:34 PM, Gupta, Pekon wrote:
>> On Wednesday 03 July 2013, Artem Bityutskiy wrote:
>>> On Wed, 2013-07-03 at 13:16 +0000, Gupta, Pekon wrote:
>>>> [Pekon]: Yes, I'm not seeing these build issues, as I'm cleanly
>>>> returning from probe with pr_err(), if the required libraries (/lib/bch.c)
>>>> are not build-in the system.
>>>> -------------------
>>>> [Patch v4 1/4]: mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC..
>>>> @@static int omap_nand_probe(struct platform_device *pdev)
>>>> +	default:
>>>> +		pr_err("selected ECC scheme not supported or not
>> enabled\n");
>>>> +		err = -EINVAL;
>>>> +		goto out_release_mem_region;
>>>> +	}
>>>> -------------------
>>>> However, if you are still seeing this, could you please send me your
>> config?
>>> I compile tested your patches too, and did not see any issues with my
>>> omap2_defconfig.
>>
>> To clarify: I'm getting this error with randconfig on today's linux-next.
>> I think it only happens with MTD_NAND_ECC_BCH enabled, which is not
>> the default in omap2_defconfig.
>>
>> 	Arnd
> Hi Arnd, Artem, Stephen,
>
> I see the issue in linux-next/master tree..
> linux-next/master has only the first [Patch v4 1/4] from the series.
> Other patches [Patch v4 2/4.. 4/4] of this series were dropped,
> as 'Olof Johansson' had some apprehensions about DT bindings.
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/249662
>
> As these patches are inter-dependent, so please drop the whole series
> including the commit below.
> fb1585b  [Patch v4 1/4] mtd: nand: omap2: clean-up BCHx_HW and BCHx_SW
>
> I'm awaiting feedbacks from 'Olof Johansson' or other DT maintainers,
> once approved, I'll resend the whole series.
>
> "[PATCH v4 2/4] ARM: OMAP2+: cleaned-up DT support " had the
> declarations which were required for above build errors.
> ---------------
> include/linux/platform_data/mtd-nand-omap2.h
> enum omap_ecc {
> +	/* 4-bit  ECC calculation by GPMC, Error detection by Software */
> +	OMAP_ECC_BCH4_CODE_HW_DETECTION_SW,
> ...
> +	/* 8-bit  ECC calculation by GPMC, Error detection by Software */
> +	OMAP_ECC_BCH8_CODE_HW_DETECTION_SW
> ---------------
>
But patches should not have inter dependency for compilation. It will affect
the bisect process.

Regards
Mugunthan V N

