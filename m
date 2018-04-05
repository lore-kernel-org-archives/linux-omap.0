From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: regression: twl4030 audio/clock stopped working in v4.16
Date: Thu, 5 Apr 2018 14:05:10 +0300
Message-ID: <3c615b51-f9f4-7267-cc2d-2a74184058a8@ti.com>
References: <2E644641-82D1-40AB-B878-06066C91AC7A@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2E644641-82D1-40AB-B878-06066C91AC7A@goldelico.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Nikolaus,

can you CC me also, I have almost missed this...

On 2018-04-04 21:29, H. Nikolaus Schaller wrote:
> Hi Peter,
> I just noticed a problem in v4.16 kernels with twl4030 audio and vibra driver no longer working.
> 
> Tracing it back shows that it already did appear in v4.16-rc1 and wasn't fixed up to v4.16.0.
> Kernel v4.15.9 (the latest one where I have a binary) works.

v4.16 works just fine on beagle-xm (including audio), omap2plus_defconfig.

> The symptoms are:
> 
> [    1.557342] twl4030-audio 48070000.i2c:twl@48:audio: Invalid audio_mclk
> [    1.564788] twl4030-audio: probe of 48070000.i2c:twl@48:audio failed with error -22
> [    1.839141] TWL4030: HFCLK is not configured

Hrm, the order looks a bit weird, it should be
TWL4030: HFCLK is not configured
twl4030-audio 48070000.i2c:twl@48:audio: Invalid audio_mclk
twl4030-audio: probe of 48070000.i2c:twl@48:audio failed with error -22

In twl4030_audio_probe() we try to get the HFCLK rate via
twl_get_hfclk_rate(), which is reading it with:
twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &ctrl, R_CFG_BOOT);

> Those are not visible in v4.15.9. And I am not aware of any changes to the gta04 device tree.
> 
> Do you know about this issue and a fix, before I start to bisect?

The CFG_BOOT register of twl4030 is not configured correctly for some
reason?
The TRM of twl4030 states that the SW should program the HFCLK_FREQ
during boot sequence.

If it is not done, MDAC and USB should not work either. And all sorts of
other issues might happen.

So the boot loader is not configuring the HFCLK_FREQ, for me it does as
I have this line in the kernel log:
[    1.472503] Skipping twl internal clock init and using bootloader
value (unknown osc rate)

In DT the twl should have the fck clock to not depend on the bootloader
for the HFCLK_FREQ settings. We do not have that for beagle-xm for sure.

> 
> BR and thanks,
> Nikolaus
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
