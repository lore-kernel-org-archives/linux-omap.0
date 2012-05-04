From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Fri, 4 May 2012 02:06:06 -0700
Message-ID: <CA+Bv8XZOCC6thuB5gNwbNY1CvKoGPLkBejnS6J6y=Gf7jzarKA@mail.gmail.com>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com>
	<CAMrsUdKnL+kSRQXi=X0d1S2fZM5sGpmYqzKnp0TPpjCKVujuaw@mail.gmail.com>
	<CA+Bv8XZeCTV2kr_d7dEAeEthwD0TkNZPiEV5m-iOFjoX7xur9Q@mail.gmail.com>
	<CAMrsUdL18b2Ox3CkzuNjQQW1JT1+-SAso67EkrwE-BTJbavYPA@mail.gmail.com>
	<CA+Bv8XYodOf_TKR6__aP=p8L7ruKhn6imWnOEbN+3UsBWPmoiw@mail.gmail.com>
	<4FA37116.4020608@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39789 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751928Ab2EDJGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 05:06:08 -0400
In-Reply-To: <4FA37116.4020608@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com

On Thu, May 3, 2012 at 11:03 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Hi Russ,
>
> On 05/03/12 22:08, Russ Dill wrote:
>> On Wed, May 2, 2012 at 3:38 AM, Raja, Govindraj <govindraj.raja@ti.com> wrote:
>>> On Wed, May 2, 2012 at 2:17 PM, Russ Dill <Russ.Dill@ti.com> wrote:
>>>> On Mon, Mar 19, 2012 at 6:34 AM, Raja, Govindraj <govindraj.raja@ti.com> wrote:
>>>>> On Mon, Mar 19, 2012 at 12:12 PM, Keshava Munegowda
>>>>> <keshava_mgowda@ti.com> wrote:
>>>>>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>>>>>
>>>>>> It is observed that the echi ports of 3430 sdp board
>>>>>> are not working due to the random timing of programming
>>>>>> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
>>>>>> If the PHYs are reset at during usbhs core driver, host ports will
>>>>>> not work because EHCI driver is loaded after the resetting PHYs.
>>>>>> The PHYs should be in reset state while initializing the EHCI
>>>>>> controller.
>>>>>> The code which does the GPIO pins associated with the PHYs
>>>>>> are programmed to reset is moved from the USB host core driver
>>>>>> to EHCI driver.
>>>>>
>>>>> I tested on beagle xm where gpio nreset is requested from
>>>>> board file.
>>>>> (Basic enumertaion after gpio nreset seems to work fine,
>>>>> Hub and smsc lan chip get detected afetr boot up)
>>>>>
>>>>
>>>> What base did you test this on top of? my xM is failing USB-wise when
>>>> I apply this on v3.3.3 (with the UART mux fix patch) and where it is
>>>> applied within master (3.4-rc4, again, with the UART mux fix patch).
>>>> Additionally, reverting this patch from 3.4-rc5 causes rc5 to work
>>>> properly.
>>>>
>>>
>>> Works for me be on 3.4-rc5 Beagle-XM even without reverting the patch
>>>
>>> Logs as in here [1].
>>>
>>> --
>>> Thanks,
>>> Govindraj.R
>>>
>>> [1]:
>>> http://pastebin.pandaboard.org/index.php/view/20343533
>>
>> I've tracked down the difference. I'm loading my uEnv.txt and uImage
>> in u-boot from the network which means initializing USB. You are
>> loading straight from MMC. If I switch to loading straight from MMC
>> everything works.
>>
>> Can everyone do a 'usb start' in u-boot before booting and re-test?
>> I'm pretty sure this is a regression, but the bug could be a strange
>> u-boot/kernel interaction.
>
> Probably, kernel code does not reinitialize EHCI correctly if it was already enabled?
> Can you try the below sequence:
> usb start
> usb stop
> boot Linux

That doesn't work. Rebooting does work though.
