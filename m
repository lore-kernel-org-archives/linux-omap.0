From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 03/12] phy: ti-pipe3: cleanup clock handling
Date: Tue, 4 Mar 2014 14:59:49 +0530
Message-ID: <53159D0D.2040009@ti.com>
References: <1393859254-10937-1-git-send-email-rogerq@ti.com> <1393859254-10937-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1393859254-10937-4-git-send-email-rogerq@ti.com>
Sender: linux-ide-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, george.cherian@ti.com, balajitk@ti.com, hdegoede@redhat.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 03 March 2014 08:37 PM, Roger Quadros wrote:
> As this driver is no longer USB specific, use generic clock names.
> - Fix PLL_SD_SHIFT from 9 to 10
> - As optclk and wkupclk may not be always required, don't bail out
> if they aren't available.

I think here too we face the same problem as for PHY. What if a 
particular platform needs a clock but is not available. I don't want 
this to be blocking though.

Thanks
Kishon
