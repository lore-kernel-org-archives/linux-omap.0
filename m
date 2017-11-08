From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] rtc: omap: Support scratch registers
Date: Wed, 8 Nov 2017 07:27:38 +0100
Message-ID: <20171108062738.cml7qaek324rvc4e@piout.net>
References: <20171031162731.27019-1-alexandre.belloni@free-electrons.com>
 <600fd106-9f79-0f5a-a2fd-e6b067785c17@ti.com>
 <4741d4c7-d6f7-ecdb-1eed-1293175f38d9@ti.com>
 <9a383f74-e049-885b-4705-93968f4c75d4@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9a383f74-e049-885b-4705-93968f4c75d4@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, Linux OMAP List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 08/11/2017 at 11:30:45 +0530, Keerthy wrote:
> >>> +static int omap_rtc_scratch_read(void *priv, unsigned int offset, void *_val,
> >>> +				 size_t bytes)
> >>> +{
> >>> +	struct omap_rtc	*rtc = priv;
> >>> +	u32 *val = _val;
> >>> +	int i;
> >>> +
> >>> +	for (i = 0; i < bytes / 4; i++)
> >>> +		val[i] = rtc_readl(rtc,
> >>> +				   OMAP_RTC_SCRATCH0_REG + offset + (i * 4));
> 
> Can the offset be the Scratch register number instead of bytes offset?
> More intuitive to me.
> 
> So that one can request using offset as 0, 1, 2 instead of 0, 4, 8?
> 

Well, the offset is coming from the nvmem core, itself getting it from
the Linux file API (and it is in bytes). However, you have the guarantee
that it will be aligned on a word, see:
http://elixir.free-electrons.com/linux/latest/source/drivers/nvmem/core.c#L88

> The above can be:
> rtc_readl(rtc, OMAP_RTC_SCRATCH0_REG + (offset + i) * 4), val[i]);
> 
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
