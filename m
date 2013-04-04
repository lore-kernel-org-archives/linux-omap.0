From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
Date: Thu, 4 Apr 2013 13:54:55 +0300
Message-ID: <CANOLnONgRtaBK8OpszJBsU=D+kSoQzQgb0ALQGMtwW67JEfP8g@mail.gmail.com>
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
	<alpine.DEB.2.00.1304030933510.12727@utopia.booyaka.com>
	<CAOmKuSr1NohJBZ_sU43b=6oNtk+P1mL=AOA6ZW6c1dLQBkw6Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAOmKuSr1NohJBZ_sU43b=6oNtk+P1mL=AOA6ZW6c1dLQBkw6Ng@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Alexey Pelykh <alexey.pelykh@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 4, 2013 at 12:06 AM, Alexey Pelykh <alexey.pelykh@gmail.com=
> wrote:
>
> Is it possible to check behavior on 3.0-3.2 kernels?

We use 3.2 on pandora as production kernel and it doesn't have this
issue that 3.9 had. 3.2 serial PM code is vastly different from what's
in later ones though.

>
> On Wed, Apr 3, 2013 at 11:57 PM, Paul Walmsley <paul@pwsan.com> wrote=
:
>> Hi Alexey,
>>
>> On Wed, 3 Apr 2013, Alexey Pelykh wrote:
>>
>>> But, since we've found the issue, I suggest that we should look at =
it
>>> closer, especially since at this moment only you can reproduce it.
>>
>> Well probably no one else is testing it :-)
>>
>>> As far as I understand, but I may be wrong, this comment is wrong, =
since
>>> if to specify OMAP_UART_SCR_RX_TRIG_GRANU1_MASK, it effectively set=
s Rx
>>> threshold to 1 character, instead of 16. /* Set receive FIFO thresh=
old
>>> to 16 characters and
>>>  * transmit FIFO threshold to 16 spaces
>>>  */
>>
>> Again it certainly would not surprise me... that UART IP block seems=
 to be
>> poorly understood :-(  Bizarre, I know.
>>
>> - Paul

--
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
