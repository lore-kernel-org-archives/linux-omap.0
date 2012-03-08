From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Thu, 8 Mar 2012 20:30:21 +0530
Message-ID: <CAP05o4KDYqcU+TbMouQGsMaLUjZsJ7G+Anp9RcvUKuoFqQab3g@mail.gmail.com>
References: <1330077975-31694-1-git-send-email-keshava_mgowda@ti.com>
	<20120224101632.GL17178@legolas.emea.dhcp.ti.com>
	<CAP05o4KRUp_W1yXn29TATMDOwMVbX_pWt6iKrrb=2jkOuWij+A@mail.gmail.com>
	<CAP05o4J1BYN2WkJToswcp4ofagp2mOuPmwWeMfJRwrfS_xEe0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44563 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753358Ab2CHPA1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 10:00:27 -0500
Received: by obqv19 with SMTP id v19so807337obq.20
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 07:00:21 -0800 (PST)
In-Reply-To: <CAP05o4J1BYN2WkJToswcp4ofagp2mOuPmwWeMfJRwrfS_xEe0Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, parthab@india.ti.com, govindraj.raja@ti.com, balbi@ti.com

On Fri, Mar 2, 2012 at 7:36 PM, Munegowda, Keshava
<keshava_mgowda@ti.com> wrote:
> On Fri, Feb 24, 2012 at 5:14 PM, Munegowda, Keshava
> <keshava_mgowda@ti.com> wrote:
>> On Fri, Feb 24, 2012 at 3:46 PM, Felipe Balbi <balbi@ti.com> wrote:
>>> Hi,
>>>
>>> On Fri, Feb 24, 2012 at 03:36:15PM +0530, Keshava Munegowda wrote:
>>>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>>>
>>>> It is observed that the echi ports of 3430 sdp board
>>>> are not working due to the random timing of programming
>>>> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
>>>> If the PHYs are reset at during usbhs core driver, host ports will
>>>> not work because EHCI driver is loaded after the resetting PHYs.
>>>> The PHYs should be in reset state while initializing the EHCI
>>>> controller.
>>>> The code which does the GPIO pins associated with the PHYs
>>>> are programmed to reset is moved from the USB host core driver
>>>> to EHCI driver.
>>>>
>>>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>>>> Reviewed-by: Partha Basak <parthab@india.ti.com>
>>>
>>> won't this cause issues with EHCI/OHCI interactions ? I mean, what =
if
>>> you connect a FS/LS device and port is handed over to OHCI, does OH=
CI
>>> have any needs to reset the PHY or something similar ?
>>
>> No, it will not cause any issues with EHCI-OHCI issues.
>> But its difficult to comment on this because we don't have port
>> handoff supported
>> in hardware.
>>
>> regards
>> keshava
>
> Hi Samuel
> =A0 =A0 =A0 =A0please let me know if you have any comments on this pa=
tch.
> This is required patch for omap3 ehci enumeration instabilities.
>
> Regards
> Keshava

Hi Samuel
      do you have any comments on this patch?
=46elipe has reviewed this patch and he is agreed for this patch.
there are no comments from your side, requesting to push this change
to mainline.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
