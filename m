From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
Date: Tue, 2 Apr 2013 18:24:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304021821190.27146@utopia.booyaka.com>
References: <alpine.DEB.2.00.1304010519260.28273@utopia.booyaka.com> <CAOmKuSpttQJmrL=Htiz-Zc4voAF7CnG_GQYAO2onKpauwYjtvw@mail.gmail.com> <alpine.DEB.2.00.1304010844100.28273@utopia.booyaka.com> <CAOmKuSrABrPcZ=Yg1+LAHWbh9CdTYR0eUmJ2dd3z91oz0uu21g@mail.gmail.com>
 <alpine.DEB.2.00.1304011008230.28273@utopia.booyaka.com> <CAOmKuSrbDc025Tj9xsqDebJ_KZdp_VnWAOs_OO5UAegV43JcDQ@mail.gmail.com> <CAOmKuSpbaKutLxbNihBRDz+B0Wt0XiPss-PcEHc-efCTvciNFg@mail.gmail.com> <alpine.DEB.2.00.1304011654520.9148@utopia.booyaka.com>
 <CAOmKuSo4onVtk2Ke-i+0_1Ych33KuUYspRy+cySRHf4yWB5XDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAOmKuSo4onVtk2Ke-i+0_1Ych33KuUYspRy+cySRHf4yWB5XDw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Alexey Pelykh <alexey.pelykh@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon, 1 Apr 2013, Alexey Pelykh wrote:

> Paul, can you please try to comment out change related to Rx line
> (granulation one). That's only Rx line related change in the patch.

Yes, looks like simply reverting the commit 1776fd059c40 ("OMAP/serial: 
Fix incorrect Rx FIFO threshold setting, LSR validation on Tx, and Tx FIFO 
IRQ generation") change to OMAP_UART_SCR_RX_TRIG_GRANU1_MASK fixes it.

Care to send a patch doing so ASAP for v3.9-rc fixes?  That would moot the 
revert of the entire commit 1776fd059c40.


- Paul
