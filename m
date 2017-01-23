From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 0/8] usb: dwc3: add dual-role support
Date: Mon, 23 Jan 2017 20:31:29 +0900
Message-ID: <5885E991.6050902@samsung.com>
References: <CGME20170123112122epcas4p3af3d2f3434d02967d7c662a9ab9f3e31@epcas4p3.samsung.com>
 <1485170381-32110-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1485170381-32110-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, balbi@kernel.org, Tony Lindgren <tony@atomide.com>
Cc: peter.chen@freescale.com, vivek.gautam@codeaurora.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?B?7J2064+Z7Jqw?= <dwoo08.lee@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On 2017년 01월 23일 20:19, Roger Quadros wrote:
> - Some SoC's (e.g. Qualcomm MSM) do not have the OTG controller block
> but do have both host and peripheral controllers and so can operate
> in dual role mode. Current series does not address this case.
> We can get dual-role to work with such SoCs if core.c can get
> information about ID and VBUS somehow (private interface
> from parent or directly read extcon?).

Also, Exynos SoC doesn't include the physical otg block
to detect the type of external connector(HOST or Peripheral).

So, our team member and me are preparing the patches
to identify the type of external connector with extcon
This approach is not dependent on any specific SoC.

Maybe, we will send the RFC patches within this month.

-- 
Best Regards,
Chanwoo Choi
S/W R&D Center
Samsung Electronics
