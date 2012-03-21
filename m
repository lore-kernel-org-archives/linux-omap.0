From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Wed, 21 Mar 2012 12:04:01 +0530
Message-ID: <CAP05o4LNVxU4iggPwP8r6rj9bg2u=U+3OKZ=L0sxtEJq0M1YRQ@mail.gmail.com>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com>
	<20120320155353.GE17818@sortiz-mobl>
	<20120320155541.GF32693@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:52963 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751127Ab2CUGeD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 02:34:03 -0400
Received: by mail-ob0-f176.google.com with SMTP id ef5so538842obb.7
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 23:34:01 -0700 (PDT)
In-Reply-To: <20120320155541.GF32693@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, parthab@india.ti.com, govindraj.raja@ti.com

On Tue, Mar 20, 2012 at 9:25 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Mar 20, 2012 at 04:53:53PM +0100, Samuel Ortiz wrote:
>> Hi Keshava,
>>
>> On Mon, Mar 19, 2012 at 12:12:47PM +0530, Keshava Munegowda wrote:
>> > From: Keshava Munegowda <Keshava_mgowda@ti.com>
>> >
>> > It is observed that the echi ports of 3430 sdp board
>> > are not working due to the random timing of programming
>> > the associated GPIOs of the ULPI PHYs of the EHCI for reset.
>> > If the PHYs are reset at during usbhs core driver, host ports will
>> > not work because EHCI driver is loaded after the resetting PHYs.
>> > The PHYs should be in reset state while initializing the EHCI
>> > controller.
>> > The code which does the GPIO pins associated with the PHYs
>> > are programmed to reset is moved from the USB host core driver
>> > to EHCI driver.
>> >
>> > Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> > Reviewed-by: Partha Basak <parthab@india.ti.com>
>> Felipe, are you ok with that patch ?
>> I'll most likely queue it after this merge window is closed though.
>
> my bad, here's my Ack:
>
> Acked-by: Felipe Balbi <balbi@ti.com>
>
> --
> balbi

thanks , Felipe

regards
keshava
