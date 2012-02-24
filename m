From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Fri, 24 Feb 2012 17:14:39 +0530
Message-ID: <CAP05o4KRUp_W1yXn29TATMDOwMVbX_pWt6iKrrb=2jkOuWij+A@mail.gmail.com>
References: <1330077975-31694-1-git-send-email-keshava_mgowda@ti.com>
	<20120224101632.GL17178@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:36672 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753204Ab2BXLok (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 06:44:40 -0500
Received: by obcwo16 with SMTP id wo16so4802730obc.27
        for <linux-omap@vger.kernel.org>; Fri, 24 Feb 2012 03:44:39 -0800 (PST)
In-Reply-To: <20120224101632.GL17178@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, parthab@india.ti.com, govindraj.raja@ti.com

On Fri, Feb 24, 2012 at 3:46 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Feb 24, 2012 at 03:36:15PM +0530, Keshava Munegowda wrote:
>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>
>> It is observed that the echi ports of 3430 sdp board
>> are not working due to the random timing of programming
>> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
>> If the PHYs are reset at during usbhs core driver, host ports will
>> not work because EHCI driver is loaded after the resetting PHYs.
>> The PHYs should be in reset state while initializing the EHCI
>> controller.
>> The code which does the GPIO pins associated with the PHYs
>> are programmed to reset is moved from the USB host core driver
>> to EHCI driver.
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> Reviewed-by: Partha Basak <parthab@india.ti.com>
>
> won't this cause issues with EHCI/OHCI interactions ? I mean, what if
> you connect a FS/LS device and port is handed over to OHCI, does OHCI
> have any needs to reset the PHY or something similar ?

No, it will not cause any issues with EHCI-OHCI issues.
But its difficult to comment on this because we don't have port
handoff supported
in hardware.

regards
keshava
