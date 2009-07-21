From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC][PATCH 1/4] OMAP4: PMIC: Add support for twl6030 irq
 framework
Date: Tue, 21 Jul 2009 10:45:04 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B595037E@dbde02.ent.ti.com>
References: <1248096992-14610-1-git-send-email-balajitk@ti.com>
 <20090720190706.GE7984@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090720190706.GE7984@gandalf>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org" <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org" <sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org>, "wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org" <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe,
Thanks for the review.

> -----Original Message-----
> From: Felipe Balbi [mailto:me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org] 
> Sent: Tuesday, July 21, 2009 12:37 AM
> To: Krishnamoorthy, Balaji T
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; 
> khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org; david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org; 
> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org; wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org; 
> timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; 
> lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org; broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org; 
> Nayak, Rajendra; Shilimkar, Santosh
> Subject: Re: [RFC][PATCH 1/4] OMAP4: PMIC: Add support for 
> twl6030 irq framework
 
I can summarize all your review comments in two points.

1. Renaming is some thing __you__ think in not necessary.

For this, I have already responded but just to clarify others on
the list, I am just copy pasting your point and our view on this topic. 
************************************************************************
> this is kinda useless, we can consider twl6030 as being sw compatible
> (almost) with twl4030. And twl4030 driver already support plenty of
> other devices, just look at drivers/mfd/twl4030-core.c lines 
> 807 - 814.
> We have twl4003, twl5030, tps65950, tps65930 and tps65920.
> 
> So IMO, renaming the files is unnecessary.
Well tps* are just another catalog names of the twl4* family. So you can
keep adding whatever names there as long it's a same IC.

Perhaps you look in hurry to comment about this. Please look at the
intention of these patches. TWL6030 has PM IC similar to TWL4030 with
bit different interrupt management. Audio IC is a separate one as
compared to combined in case of TWL4030.

If it allows code re-use by renaming files, it should be good. Isn't it ?
************************************************************************
Here is summary of Major difference between Triton(TWL4030) and
Phoenix(TWL6030_ chips are:
    -GPIO, Keypad is not present in Phoenix
    -I2C Chips addresses of modules like RTC, BCI, ADC, USB, PMC Master/Slave 
     have changed.  Base address of these module register is also changed.
    -PIH and SIH, module interrupt status registers will be replaced by PIH 
     (INT_STS_A, INT_STS_B and INT_STS_C) and module interrupt status registers
    -MADC to GPADC in Phoenix, 17 channels supported
     GPADC in Phoenix supports Realtime, Asynchronous SW request.
    -RTC register offsets have changed. Addition/removal of LDO/SMPS Voltage 
     Regulators

2. Usage of compile time macros like "CONFIG_TWL4030" and CONFIG_TWL6030"
should be avoided and you think it would break multi-omap.

If we just go by definition " Multi-OMAP" is for different OMAP IC's. TWL4030
and TWL6030 are external companion IC's to OMAP.
Any ways, these compile time switches can be avoided if we make runtime
provision for these TWL IC's like. 
"is_twl4030(), is_twl6030" etc like "cpu_is_24xx(),cpu_is_44xx()" etc.

Obviously this asks to make the driver register map (which is different in
case of TWL6030 w.r.t TWL4030) to be held in some arrays and select the
appropriate one run-time.  But it's doable if it helps.

The patch series was made under _assumption_ that either TWL4030 or TWL6030 
would be used. I am not sure whether there will boards where both will
co-exist.

Regards
Santosh--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
