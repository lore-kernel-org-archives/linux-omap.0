From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
Date: Thu, 7 Jun 2018 15:54:01 +0530
Message-ID: <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-5-faiz_abbas@ti.com>
 <20180607073530.GH5738@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607073530.GH5738@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, mark.rutland@arm.com, paul@pwsan.com, t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 07 June 2018 01:05 PM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180606 06:14]:
>> +static int sysc_reset(struct sysc *ddata)
>> +{
>> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
>> +	int val = sysc_read(ddata, offset);
>> +
>> +	val |= (0x1 << ddata->cap->regbits->srst_shift);
>> +	sysc_write(ddata, offset, val);
>> +
>> +	/* Poll on reset status */
>> +	if (ddata->cfg.quirks & SYSC_QUIRK_RESET_STATUS) {
>> +		offset = ddata->offsets[SYSC_SYSSTATUS];
>> +
>> +		return readl_poll_timeout(ddata->module_va + offset, val,
>> +				(val & ddata->cfg.syss_mask) == 0x0,
>> +				100, MAX_MODULE_SOFTRESET_WAIT);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> I wonder if we should also add SYSS_QUIRK_RESET_STATUS in
> addition to SYSC_QUIRK_RESET status to make it easy to
> read the right register?

I assumed SYSC_QUIRK is the prefix to indicate the ti-sysc driver not
the register. Are there layouts in which the reset status bit is in the
sysconfig register rather than the sysstatus register?

Thanks,
Faiz
