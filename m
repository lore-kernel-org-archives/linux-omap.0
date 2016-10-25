From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to
 24MHz
Date: Tue, 25 Oct 2016 11:22:46 +0530
Message-ID: <086ab2fa-63ee-c5ab-2715-b2efd78270d7@ti.com>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
 <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Syne <john3909@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@kernel.org>, Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 25 October 2016 02:28 AM, John Syne wrote:
>> > On Oct 23, 2016, at 11:02 PM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
>> > 
>> > Increase ADC reference clock from 3MHz to 24MHz so that the
>> > sampling rates goes up from 100K samples per second to 800K
>> > samples per second on AM335x and AM437x SoC.
>> > 
>> > Also increase opendelay for touchscreen configuration to
>> > equalize the increase in ADC reference clock frequency,
>> > which results in the same amount touch events reported via
>> > evtest on AM335x GP EVM.
>> > 
>> > Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
>> > ---
>> > 
>> > This patch depends on ADC DMA patch series [1]
>> > 
>> > Without DMA support, when ADC ref clock is set at 24MHz, I am
>> > seeing fifo overflow as CPU is not able to pull the ADC samples.
>> > This answers that DMA support is must for ADC to consume the
>> > samples generated at 24MHz with no open, step delay or
>> > averaging with patch [2].
>> > 
>> > Measured the performance with the iio_generic_buffer with the
>> > patch [3] applied
>> > 
>> > [1] - http://www.spinics.net/lists/devicetree/msg145045.html
>> > [2] - http://pastebin.ubuntu.com/23357935/
>> > [3] - http://pastebin.ubuntu.com/23357939/
>> > 
>> > ---
>> > include/linux/mfd/ti_am335x_tscadc.h | 4 ++--
>> > 1 file changed, 2 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
>> > index b9a53e0..96c4207 100644
>> > --- a/include/linux/mfd/ti_am335x_tscadc.h
>> > +++ b/include/linux/mfd/ti_am335x_tscadc.h
>> > @@ -90,7 +90,7 @@
>> > /* Delay register */
>> > #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
>> > #define STEPDELAY_OPEN(val)	((val) << 0)
>> > -#define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
> Wouldn’t this be better to add this to the devicetree?
> 
> 	ti,chan-step-avg = <0x16 0x16 0x16 0x16 0x16 0x16 0x16>;
> 	ti,chan-step-opendelay = <0x500 0x500 0x500 0x500 0x500 0x500 0x500>;
> 	ti,chan-step-sampledelay = <0x0 0x0 0x0 0x0 0x0 0x0 0x0>;

For a touch screen, there is not need to change in these parameter
settings, so my opinion is to keep it as is. Or am I missing something?

Regards
Mugunthan V N
