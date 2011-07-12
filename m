From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride configuration
Date: Tue, 12 Jul 2011 12:03:22 +0200
Message-ID: <CACRpkdbLg0+_2kpi4NizFj0fDWb6QPtkcKirKgoH+83vGD0O0A@mail.gmail.com>
References: <1310310203-12288-1-git-send-email-sundaram@ti.com>
	<CABb+yY1HJOR+QzmM4-ju4cs+8keoyUbMv+SpVoM6BW=DCMzmQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABb+yY1HJOR+QzmM4-ju4cs+8keoyUbMv+SpVoM6BW=DCMzmQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Sundaram Raju <sundaram@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux@arm.linux.org.uk, dan.j.williams@intel.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 12, 2011 at 6:17 AM, Jassi Brar <jassisinghbrar@gmail.com> =
wrote:

> 1) Striding, in one form or other, is supported by other DMACs as wel=
l.
> =A0 The number will only increase in future.
> =A0 Are we to add =A0<VENDOR>_DMA_STRIDE_CONFIG for each case ?

If we are sure about this and striding will work in a similar way on al=
l
then let's have the enum named DMA_STRIDE_CONFIG and move the
passed-in struct to <linux/dmaengine.h) then?

Would that be:

struct dma_stride_config {
    u32 read_bytes;
    u32 skip_bytes;
};

Or something more complex?

> 2) As Dan noted, client drivers are going to have ifdef hackery in
> order to be common
> =A0to other SoCs.

Don't think so, why? This is a runtime config entirely, and I just illu=
strated
in mail to Dan how that can be handled by falling back to a sglist I be=
lieve?

We can *maybe* even put the fallback code into dmaengine, so that an
emulated sglist in place for the DMAengine is done automatically of the
DMA controller does not support striding.

> 3) TI may not have just one DMAC IP used in all the SoCs. So if you w=
ant
> =A0vendor specific defines anyway, please atleast also add DMAC versi=
on to it.
> =A0Something like
>> =A0 =A0 =A0 =A0DMA_SLAVE_CONFIG,
>> =A0 =A0 =A0 =A0FSLDMA_EXTERNAL_START,
>> + =A0 =A0 =A0 TI_DMA_v1_STRIDE_CONFIG,

Yep unless we make it generic DMA_STRIDE_CONFIG simply, this makes
a lot of sense.

Linus Walleij
