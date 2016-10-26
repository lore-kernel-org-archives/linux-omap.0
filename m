From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock
 to 24MHz
Date: Wed, 26 Oct 2016 09:48:11 +0100
Message-ID: <20161026084811.GI8574@dell>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
 <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com>
 <086ab2fa-63ee-c5ab-2715-b2efd78270d7@ti.com>
 <12725C92-9BB8-4F77-A7B4-F3C3DA9F8B0B@gmail.com>
 <DB09B26E-C5AB-427A-82D5-6FE857E7C218@gmail.com>
 <20161025063847.GD8574@dell>
 <CC15CFB4-60D0-4A63-A3D3-2079CFA31274@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CC15CFB4-60D0-4A63-A3D3-2079CFA31274@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Syne <john3909@gmail.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, linux-iio@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@kernel.org>, Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 25 Oct 2016, John Syne wrote:
> > On Oct 24, 2016, at 11:38 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 24 Oct 2016, John Syne wrote:
> >>> On Oct 24, 2016, at 11:01 PM, John Syne <john3909@gmail.com> wrote:
> >>>> On Oct 24, 2016, at 10:52 PM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
> >>>> 
> >>>> On Tuesday 25 October 2016 02:28 AM, John Syne wrote:
> >>>>>>> On Oct 23, 2016, at 11:02 PM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
> >>>>>>> 
> >>>>>>> Increase ADC reference clock from 3MHz to 24MHz so that the
> >>>>>>> sampling rates goes up from 100K samples per second to 800K
> >>>>>>> samples per second on AM335x and AM437x SoC.
> >>>>>>> 
> >>>>>>> Also increase opendelay for touchscreen configuration to
> >>>>>>> equalize the increase in ADC reference clock frequency,
> >>>>>>> which results in the same amount touch events reported via
> >>>>>>> evtest on AM335x GP EVM.
> >>>>>>> 
> >>>>>>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> >>>>>>> ---
> >>>>>>> 
> >>>>>>> This patch depends on ADC DMA patch series [1]
> >>>>>>> 
> >>>>>>> Without DMA support, when ADC ref clock is set at 24MHz, I am
> >>>>>>> seeing fifo overflow as CPU is not able to pull the ADC samples.
> >>>>>>> This answers that DMA support is must for ADC to consume the
> >>>>>>> samples generated at 24MHz with no open, step delay or
> >>>>>>> averaging with patch [2].
> >>>>>>> 
> >>>>>>> Measured the performance with the iio_generic_buffer with the
> >>>>>>> patch [3] applied
> >>>>>>> 
> >>>>>>> [1] - http://www.spinics.net/lists/devicetree/msg145045.html
> >>>>>>> [2] - http://pastebin.ubuntu.com/23357935/
> >>>>>>> [3] - http://pastebin.ubuntu.com/23357939/
> >>>>>>> 
> >>>>>>> ---
> >>>>>>> include/linux/mfd/ti_am335x_tscadc.h | 4 ++--
> >>>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>> 
> >>>>>>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> >>>>>>> index b9a53e0..96c4207 100644
> >>>>>>> --- a/include/linux/mfd/ti_am335x_tscadc.h
> >>>>>>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> >>>>>>> @@ -90,7 +90,7 @@
> >>>>>>> /* Delay register */
> >>>>>>> #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
> >>>>>>> #define STEPDELAY_OPEN(val)	((val) << 0)
> >>>>>>> -#define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
> >>>>> Wouldn’t this be better to add this to the devicetree?
> >>>>> 
> >>>>> 	ti,chan-step-avg = <0x16 0x16 0x16 0x16 0x16 0x16 0x16>;
> >>>>> 	ti,chan-step-opendelay = <0x500 0x500 0x500 0x500 0x500 0x500 0x500>;
> >>>>> 	ti,chan-step-sampledelay = <0x0 0x0 0x0 0x0 0x0 0x0 0x0>;
> >>>> 
> >>>> For a touch screen, there is not need to change in these parameter
> >>>> settings, so my opinion is to keep it as is. Or am I missing something?
> >>> I was thinking that if you are using this driver as an ADC, you may want the flexibility to make these changes in the DT. I’m doing this by connecting sensors to the ADC inputs. I’m not using this driver for a touchscreen. 
> >> 
> >> Here is a DT overlay were this gets using on the BeagleBoneBlack.  
> >> 
> >> https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-ADC-00A0.dts
> >> 
> >> Besides, these DT features are already implemented in the driver so it is just a matter of adding these entries to the am33xx.dtsi & am4372.dtsi, which you modified in this patch series.
> > 
> > This looks like configuration, no?
> > 
> > DT should be used to describe the hardware.
> You may be right, but how is this different to setting the baud rate on a serial channel or sampling rate on a audio channel? Looking through the DT, there are many configuration settings, so I’m not sure what is the correct way to handle this. Surely it is better to handle this in DT vs hard coding these settings?

I think setting the UART baud rate is also an invalid DT entry.

It's okay to list all of the options in DT, but to actually select
one, that should be done either in userspace or as a kernel option.
Perhaps as a Kconfig selection.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
