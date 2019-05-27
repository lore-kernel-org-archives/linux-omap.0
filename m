From: Thomas Huth <thuth@redhat.com>
Subject: Re: [Qemu-devel] Running linux on qemu omap
Date: Mon, 27 May 2019 08:30:34 +0200
Message-ID: <05bd307b-c8c5-4b12-be45-2d7933876aac@redhat.com>
References: <20190520190533.GA28160@Red>
 <20190521232323.GD3621@darkstar.musicnaut.iki.fi>
 <20190522093341.GA32154@Red>
 <20190522181904.GE3621@darkstar.musicnaut.iki.fi>
 <8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
 <c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
 <20190523183623.GB5234@darkstar.musicnaut.iki.fi>
 <CAFEAcA8C0WN5FwaW2kfWiRm1T8wML_fWXDKqRXP-Lv_P7ysy8A@mail.gmail.com>
 <20190524150018.GA3156@t60.musicnaut.iki.fi>
 <20190524185922.GA4597@t60.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190524185922.GA4597@t60.musicnaut.iki.fi>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Corentin Labbe <clabbe.montjoie@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 24/05/2019 20.59, Aaro Koskinen wrote:
> Hi,
> 
> On Fri, May 24, 2019 at 06:00:18PM +0300, Aaro Koskinen wrote:
>> Please don't delete OMAP boards quite yet :) In the mainline kernel
>> they are not orphaned, they frequently get tested using actual hardware,
>> and QEMU would help in additional testing. I'll try to get N8x0 boot to
>> work with the minimal kernel I use on real HW.
> 
> So it was only a matter of attaching the serial console at the QEMU side
> (a hackish patch at the end of the mail).

Does not look too much hackish to me. Could you please send it as a
proper patch to the list (with patch description and Signed-off-by line)?

 Thomas


> 
> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> index 906b7ca22d43..52ff83ec5147 100644
> --- a/hw/arm/nseries.c
> +++ b/hw/arm/nseries.c
> @@ -792,6 +792,7 @@ static void n8x0_uart_setup(struct n800_s *s)
>      qdev_connect_gpio_out(s->mpu->gpio, N8X0_BT_WKUP_GPIO,
>                      csrhci_pins_get(radio)[csrhci_pin_wakeup]);
>  
> +    omap_uart_attach(s->mpu->uart[2], serial_hd(0));
>      omap_uart_attach(s->mpu->uart[BT_UART], radio);
>  }
>  
> 
