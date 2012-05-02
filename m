From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Wed, 2 May 2012 16:08:06 +0530
Message-ID: <CAMrsUdL18b2Ox3CkzuNjQQW1JT1+-SAso67EkrwE-BTJbavYPA@mail.gmail.com>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com>
 <CAMrsUdKnL+kSRQXi=X0d1S2fZM5sGpmYqzKnp0TPpjCKVujuaw@mail.gmail.com> <CA+Bv8XZeCTV2kr_d7dEAeEthwD0TkNZPiEV5m-iOFjoX7xur9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:45703 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753224Ab2EBKi1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 06:38:27 -0400
Received: by obbeh20 with SMTP id eh20so1238358obb.17
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 03:38:26 -0700 (PDT)
In-Reply-To: <CA+Bv8XZeCTV2kr_d7dEAeEthwD0TkNZPiEV5m-iOFjoX7xur9Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com

On Wed, May 2, 2012 at 2:17 PM, Russ Dill <Russ.Dill@ti.com> wrote:
> On Mon, Mar 19, 2012 at 6:34 AM, Raja, Govindraj <govindraj.raja@ti.com> wrote:
>> On Mon, Mar 19, 2012 at 12:12 PM, Keshava Munegowda
>> <keshava_mgowda@ti.com> wrote:
>>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>>
>>> It is observed that the echi ports of 3430 sdp board
>>> are not working due to the random timing of programming
>>> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
>>> If the PHYs are reset at during usbhs core driver, host ports will
>>> not work because EHCI driver is loaded after the resetting PHYs.
>>> The PHYs should be in reset state while initializing the EHCI
>>> controller.
>>> The code which does the GPIO pins associated with the PHYs
>>> are programmed to reset is moved from the USB host core driver
>>> to EHCI driver.
>>
>> I tested on beagle xm where gpio nreset is requested from
>> board file.
>> (Basic enumertaion after gpio nreset seems to work fine,
>> Hub and smsc lan chip get detected afetr boot up)
>>
>
> What base did you test this on top of? my xM is failing USB-wise when
> I apply this on v3.3.3 (with the UART mux fix patch) and where it is
> applied within master (3.4-rc4, again, with the UART mux fix patch).
> Additionally, reverting this patch from 3.4-rc5 causes rc5 to work
> properly.
>

Works for me be on 3.4-rc5 Beagle-XM even without reverting the patch

Logs as in here [1].

--
Thanks,
Govindraj.R

[1]:
http://pastebin.pandaboard.org/index.php/view/20343533
