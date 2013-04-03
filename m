From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
Date: Wed, 3 Apr 2013 20:21:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304032018330.16711@utopia.booyaka.com>
References: <alpine.DEB.2.00.1304010519260.28273@utopia.booyaka.com> <CAOmKuSpttQJmrL=Htiz-Zc4voAF7CnG_GQYAO2onKpauwYjtvw@mail.gmail.com> <alpine.DEB.2.00.1304010844100.28273@utopia.booyaka.com> <CAOmKuSrABrPcZ=Yg1+LAHWbh9CdTYR0eUmJ2dd3z91oz0uu21g@mail.gmail.com>
 <alpine.DEB.2.00.1304011008230.28273@utopia.booyaka.com> <CAOmKuSrbDc025Tj9xsqDebJ_KZdp_VnWAOs_OO5UAegV43JcDQ@mail.gmail.com> <CAOmKuSpbaKutLxbNihBRDz+B0Wt0XiPss-PcEHc-efCTvciNFg@mail.gmail.com> <alpine.DEB.2.00.1304011654520.9148@utopia.booyaka.com>
 <CAOmKuSo4onVtk2Ke-i+0_1Ych33KuUYspRy+cySRHf4yWB5XDw@mail.gmail.com> <alpine.DEB.2.00.1304021821190.27146@utopia.booyaka.com> <CAOmKuSqd=gNYFutpgDref58pbAbDwDin4mvL_OEooD1XuwKtgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAOmKuSqd=gNYFutpgDref58pbAbDwDin4mvL_OEooD1XuwKtgQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Alexey Pelykh <alexey.pelykh@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, 3 Apr 2013, Alexey Pelykh wrote:

> But, since we've found the issue, I suggest that we should look at it
> closer, especially since at this moment only you can reproduce it. As
> far as I understand, but I may be wrong,
> this comment is wrong, since if to specify
> OMAP_UART_SCR_RX_TRIG_GRANU1_MASK, it effectively sets Rx threshold to
> 1 character, instead of 16.
> /* Set receive FIFO threshold to 16 characters and
>  * transmit FIFO threshold to 16 spaces
>  */

If you want to continue to experiment with it, I'd be willing to do an 
occasional test boot on 37xx EVM.  It's nice to see community patches...


- Paul
