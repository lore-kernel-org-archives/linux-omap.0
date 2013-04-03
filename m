From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
Date: Wed, 3 Apr 2013 22:04:05 +0300
Message-ID: <CAOmKuSoJ38YKyzuyESfx=jgi3y=EunAUt7RPp2=7pRQosytQYg@mail.gmail.com>
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
	<CAOmKuSp8nPJw7+LKK3ny7ZjEEV-CeDjGg0GD2fDjZiP6HBKGGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAOmKuSp8nPJw7+LKK3ny7ZjEEV-CeDjGg0GD2fDjZiP6HBKGGw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

I've submitted patch that should remove this regression

On Wed, Apr 3, 2013 at 6:55 PM, Alexey Pelykh <alexey.pelykh@gmail.com> wrote:
> Paul,
>
> Should I start a new email chain with that patch or add it here?
>
> On Wed, Apr 3, 2013 at 12:19 AM, Alexey Pelykh <alexey.pelykh@gmail.com> wrote:
>> Hi Paul,
>>
>> No problem, I'll prepare patch in next 24 hours and will send in ASAP.
>>
>> But, since we've found the issue, I suggest that we should look at it
>> closer, especially since at this moment only you can reproduce it. As
>> far as I understand, but I may be wrong,
>> this comment is wrong, since if to specify
>> OMAP_UART_SCR_RX_TRIG_GRANU1_MASK, it effectively sets Rx threshold to
>> 1 character, instead of 16.
>> /* Set receive FIFO threshold to 16 characters and
>>  * transmit FIFO threshold to 16 spaces
>>  */
>>
>> On Tue, Apr 2, 2013 at 9:24 PM, Paul Walmsley <paul@pwsan.com> wrote:
>>> On Mon, 1 Apr 2013, Alexey Pelykh wrote:
>>>
>>>> Paul, can you please try to comment out change related to Rx line
>>>> (granulation one). That's only Rx line related change in the patch.
>>>
>>> Yes, looks like simply reverting the commit 1776fd059c40 ("OMAP/serial:
>>> Fix incorrect Rx FIFO threshold setting, LSR validation on Tx, and Tx FIFO
>>> IRQ generation") change to OMAP_UART_SCR_RX_TRIG_GRANU1_MASK fixes it.
>>>
>>> Care to send a patch doing so ASAP for v3.9-rc fixes?  That would moot the
>>> revert of the entire commit 1776fd059c40.
>>>
>>>
>>> - Paul
