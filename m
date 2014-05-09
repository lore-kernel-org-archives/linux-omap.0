From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
Date: Fri, 9 May 2014 11:52:59 +0530
Message-ID: <536C7443.4000805@ti.com>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>	<CAGm1_kvHtSLNEfkJ24xZGGzsqAjHDTM1XztnX-QGs4iM5voMUw@mail.gmail.com>	<535F5BA5.6000903@ti.com> <CAAEAJfCG3c++WBgeipF6sCE1-9pHgU80t2Mpz0Y4koU5-uEwSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36456 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbaEIGXo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 02:23:44 -0400
In-Reply-To: <CAAEAJfCG3c++WBgeipF6sCE1-9pHgU80t2Mpz0Y4koU5-uEwSA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?RXplcXVpZWwgR2FyY8OtYQ==?= <ezequiel@vanguardiasur.com.ar>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On 5/8/2014 10:30 PM, Ezequiel Garc=C3=ADa wrote:
> Hi George,
>
> On 29 April 2014 04:58, George Cherian <george.cherian@ti.com> wrote:
>> On 4/29/2014 11:49 AM, Yegor Yefremov wrote:
>>> On Thu, Apr 24, 2014 at 11:11 PM, Ezequiel Garcia
>>> <ezequiel@vanguardiasur.com.ar> wrote:
>>>> The DMA controller is needed for the USB controller to be correctl=
y
>>>> registered. Therefore, if the DMA node is located at the end an
>>>> unecessary
>>>> probe deferral is produced systematically.
>>>>
>>>> This is easily fixed by moving the node at the beggining of the ch=
ild
>>>> list,
>>>> so it's probed first.
>> This will give issues on module removal.
>> Since we use device_for_each_child in remove patch, it will try to r=
emove
>> cppi dma controller, while the channel
>> is still in use by musb node.
>>
> OK, this seems confusing: are you sure module removal works?
No it does not .
>
> Doing this simple test on v3.15-rcN:
>
> $ modprobe musb_dsps
> $ modprobe musb_am335x
> $ modprobe musb_am335x -r
>
> And the kernel blows up :-(
>
> I've been debugging this and I think we simply cannot support removal
> of the musb_am335x
> module.
>
> Had this ever worked before
Nope. I feel the whole problem is because how its modeled in dt.

If you look at the TRM following are the memory maps for the USB module=
s
USB control Module 0x44e10_0620

USBSS             0x4740_0000

USB0               0x4740_1000
USB0_PHY      0x4740_1300
USB0_CORE    0x4740_1400

USB1               0x4740_1800
USB1_PHY      0x4740_1b00
USB1_CORE    0x4740_1c00

CPPI DMA Controller 0x4740_2000
CPPI DMA Scheduler 0x4740_3000
Queue Manager         0x4740_4000

Now in the curent DT we have  the follwoing
USBSS {
     usb_ctrl_mod: {
         0x44e10_0620
     }
     usb0_phy:{
     0x4740_1300
     }
     usb0: {
     0x4740_1000
     0x4740_1400
     }
     usb1_phy: {
     0x4740_1b00
     }
     usb1:{
     0x4740_1800
     0x4740_1c00
     }
     cppi41dma: {
     0x4740_2000
     0x4740_3000
     0x4740_4000
     }
}

Just by remodelling the dt the whole problem can be solved.
I am still not convinced why we should not be doing it?
Because neither ways its not the exact representation of the H/W.

I will send a patch as RFC for the same.


--=20
-George

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
