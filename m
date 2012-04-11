From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Wed, 11 Apr 2012 17:15:03 +0530
Message-ID: <CAP05o4JWjoh-NoDeA3vYaS1yY_SGdm3TZvHA=pkQsP-Xo-kWnQ@mail.gmail.com>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com>
	<4F71D87E.70100@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:57814 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753603Ab2DKLpF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 07:45:05 -0400
Received: by obbwd18 with SMTP id wd18so2119110obb.16
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 04:45:04 -0700 (PDT)
In-Reply-To: <4F71D87E.70100@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, parthab@india.ti.com, govindraj.raja@ti.com, Igor Grinberg <grinberg@compulab.co.il>

On Tue, Mar 27, 2012 at 8:40 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> On 03/19/12 08:42, Keshava Munegowda wrote:
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
> Both EHCI ports worked on cm-t3730 previously and
> no regression is seen with this patch.
>
> Tested-by: Igor Grinberg <grinberg@compulab.co.il>
>
> --
> Regards,
> Igor.

Hi sameo
         Since I am not seeing this patch in linux-next labled 3.4.rc2
on 10th april 2012;
 please let me know your plan to queue this patch for the main line.

Thanks and Regards
Keshava
