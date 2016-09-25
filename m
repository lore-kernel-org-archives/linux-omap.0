From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] Add DMA support for ti_am335x_adc driver
Date: Sun, 25 Sep 2016 10:41:23 +0100
Message-ID: <22588f2d-d0de-7911-35ed-92094f7dd28d@kernel.org>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160921161134.6951-1-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 21/09/16 17:11, Mugunthan V N wrote:
> The ADC has a 64 work depth fifo length which holds the ADC data
> till the CPU reads. So when a user program needs a large ADC data
> to operate on, then it has to do multiple reads to get its
> buffer. Currently if the application asks for 4 samples per
> channel with all 8 channels are enabled, kernel can provide only
> 3 samples per channel when all 8 channels are enabled (logs at
> [1]). So with DMA support user can request for large number of
> samples at a time (logs at [2]).
> 
> Tested the patch on AM437x-gp-evm and AM335x Boneblack with the
> patch [3] to enable ADC and pushed a branch for testing [4]
> 
> [1] - http://pastebin.ubuntu.com/23211490/
> [2] - http://pastebin.ubuntu.com/23211492/
> [3] - http://pastebin.ubuntu.com/23211494/
> [4] - git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git iio-dma
Just curious.  How fast is the ADC sampling at in these?  Never that
obvious for this driver!

I'm also curious as to whether you started to hit the limits of the
kfifo based interface.  Might be worth considering adding alternative
support for the dma buffers interface which is obviously much lower
overhead.

Good to have this work prior to that as the kfifo stuff is somewhat
easier to use.

Jonathan
> 
> Mugunthan V N (4):
>   mfd: ti_am335x_tscadc: store physical address
>   drivers: iio: ti_am335x_adc: add dma support
>   ARM: dts: am33xx: add DMA properties for tscadc
>   ARM: dts: am4372: add DMA properties for tscadc
> 
>  arch/arm/boot/dts/am33xx.dtsi        |   2 +
>  arch/arm/boot/dts/am4372.dtsi        |   2 +
>  drivers/iio/adc/ti_am335x_adc.c      | 160 ++++++++++++++++++++++++++++++++++-
>  drivers/mfd/ti_am335x_tscadc.c       |   1 +
>  include/linux/mfd/ti_am335x_tscadc.h |   8 ++
>  5 files changed, 170 insertions(+), 3 deletions(-)
> 
