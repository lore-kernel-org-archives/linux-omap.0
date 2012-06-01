From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 2/5] arm: omap: remove ocp2scp_usb_phy_ick clock node
Date: Fri, 1 Jun 2012 15:24:24 +0200
Message-ID: <4FC8C288.5060200@ti.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com> <1338375394-16268-3-git-send-email-kishon@ti.com> <CAMQu2gxcP8At5j4UOK3bgX+Q+OunXeTxyXEr6hAhGiwjLs-gJg@mail.gmail.com> <4FC63B8D.3070107@ti.com> <CAAe_U6L6b26J4Q3mB6K0BLtwkaL92SFZSQTMCd=Rv3UBynVCBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35017 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753381Ab2FANYj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 09:24:39 -0400
In-Reply-To: <CAAe_U6L6b26J4Q3mB6K0BLtwkaL92SFZSQTMCd=Rv3UBynVCBA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com

On 6/1/2012 2:52 PM, ABRAHAM, KISHON VIJAY wrote:
> Hi Benoit,
>
> On Wed, May 30, 2012 at 8:53 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> On 5/30/2012 4:51 PM, Shilimkar, Santosh wrote:
>>>
>>> On Wed, May 30, 2012 at 4:26 PM, Kishon Vijay Abraham I<kishon@ti.com>
>>>   wrote:
>>>>
>>>> "ocp2scp_usb_phy_ick" clock node was a fake clock node created
>>>> to control MODULEMODE of ocp2scp. Since the hwmod for ocp2scp is now
>>>> added
>>>> (which can be used to control MODULEMODE) this clock node is removed.
>>>>
>>>> Cc: Benoit Cousson<b-cousson@ti.com>
>>>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>>>> ---
>>>>   arch/arm/mach-omap2/clock44xx_data.c |   11 -----------
>>>
>>>
>>> Have you patched clock44xx_data.c manually or you have a patch for
>>> the clock_data autogen script to generate it ?
>>
>>
>> I have a series that will remove all these clock nodes. I should be able to
>> post that soon.
>>
>> Potentially at that time, Kishon might be able to drop that patch.
>
> Will you be sending a patch for *[RFC PATCH 1/5] arm: omap: hwmod:
> make *phy_48m* as the main_clk of ocp2scp* also or I have to keep that
> as part of my series?

Good point. In fact, I'm fixing both at the same time to avoid any 
bisect issue.

Regards,
Benoit

