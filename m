From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH v2 0/3] Add Generic USB VBUS/ID detection via GPIO using
 extcon
Date: Wed, 28 Aug 2013 23:05:48 +0530
Message-ID: <521E34F4.3060402@ti.com>
References: <1377698352-27689-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377698352-27689-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>
Cc: balbi@ti.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, grant.likely@linaro.org, rob@landley.net, ian.campbell@citrix.com, swarren@wwwdotorg.org, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, bcousson@baylibre.com, davidb@codeaurora.org, arnd@arndb.de, swarren@nvidia.com, popcornmix@gmail.com
List-Id: linux-omap@vger.kernel.org

On 8/28/2013 7:29 PM, George Cherian wrote:
> Hi,
>
> These patches add generic support for USB VBUS/ID pin detection using extcon framework.
> The USB ID pin on DRA7xx is connected via the gpio expander pcf8575.
> The interrupt line of the same is connected to the gpio 11 of bank 6.
> The following driver relies on  the  gpio interrupt to notify the actual
> ID pin values by which the dwc3 driver determines the HOST/Peripheral roles.
Please ignore this patch set I just noticed that patch #1 is malformed.
Sending v3 in a while.

Regards,
-George
