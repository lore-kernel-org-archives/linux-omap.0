From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
Date: Wed, 3 Apr 2013 23:46:49 +0300
Message-ID: <CAOmKuSqVs4i_CMC4Pf=rLrkzh93YietU5p7XwgSC9DvvEyVL1g@mail.gmail.com>
References: <alpine.DEB.2.00.1304010519260.28273@utopia.booyaka.com>
	<CAOmKuSpttQJmrL=Htiz-Zc4voAF7CnG_GQYAO2onKpauwYjtvw@mail.gmail.com>
	<alpine.DEB.2.00.1304010844100.28273@utopia.booyaka.com>
	<CAOmKuSrABrPcZ=Yg1+LAHWbh9CdTYR0eUmJ2dd3z91oz0uu21g@mail.gmail.com>
	<alpine.DEB.2.00.1304011008230.28273@utopia.booyaka.com>
	<CAOmKuSrbDc025Tj9xsqDebJ_KZdp_VnWAOs_OO5UAegV43JcDQ@mail.gmail.com>
	<CAOmKuSpbaKutLxbNihBRDz+B0Wt0XiPss-PcEHc-efCTvciNFg@mail.gmail.com>
	<alpine.DEB.2.00.1304011654520.9148@utopia.booyaka.com>
	<CAOmKuSo4onVtk2Ke-i+0_1Ych33KuUYspRy+cySRHf4yWB5XDw@mail.gmail.com>
	<alpine.DEB.2.00.1304021821190.27146@utopia.booyaka.com>
	<CAOmKuSqd=gNYFutpgDref58pbAbDwDin4mvL_OEooD1XuwKtgQ@mail.gmail.com>
	<alpine.DEB.2.00.1304032018330.16711@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1304032018330.16711@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Hi

On Wed, Apr 3, 2013 at 11:21 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi,
>
> On Wed, 3 Apr 2013, Alexey Pelykh wrote:
>
>> But, since we've found the issue, I suggest that we should look at it
>> closer, especially since at this moment only you can reproduce it. As
>> far as I understand, but I may be wrong,
>> this comment is wrong, since if to specify
>> OMAP_UART_SCR_RX_TRIG_GRANU1_MASK, it effectively sets Rx threshold to
>> 1 character, instead of 16.
>> /* Set receive FIFO threshold to 16 characters and
>>  * transmit FIFO threshold to 16 spaces
>>  */
>
> If you want to continue to experiment with it, I'd be willing to do an
> occasional test boot on 37xx EVM.  It's nice to see community patches...
>

I'm pretty sure that current configuration of UART indeed sets Rx FIFO
threshold to
1 character, as opposite to 16 characters mentioned in comments. Kernel 3.3
is the origin of Rx 1-char-granularity bit setting, but states clearly
that Rx FIFO
is being set to 1 character in non-DMA mode. The comment appears between
3.6 and 3.7 in commit 6721ab7f77f2614ab43e3de2f908b1d7436331df by Felipe Balbi.
3.0-3.2 kernels don't have 1-char-granularity enabled, and Rx FIFO
threshold level
was effectively set to 16 characters, what should be the same as my
patch that turned off
1-char-granularity

Paul, can you confirm (if possible, surely) if 3.0-3.2 kernels had same issue?

Felipe, it would be great to get your comments on this?

>
> - Paul
