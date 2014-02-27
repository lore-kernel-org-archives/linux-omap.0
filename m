From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/3] mfd: twl6040: Updates for i2s speed and fix for chip
 deadlock
Date: Thu, 27 Feb 2014 16:11:21 +0100
Message-ID: <530F5599.2060100@epfl.ch>
References: <1393509410-1640-1-git-send-email-peter.ujfalusi@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:33478 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbaB0PL2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Feb 2014 10:11:28 -0500
In-Reply-To: <1393509410-1640-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

Hi Peter,

On 02/27/2014 02:56 PM, Peter Ujfalusi wrote:
> Hi,
> 
> While looking into a report by Florian Vaussard [1] I have noticed couple of most
> likely unrelated issues:
> - all boards using twl6040 configures the i2c bus to 400KHz while twl6040 is set
>   to 100KHz as default.
> - if I set the audpwron GPIO high [2] in the bootloader the i2c communication towards
>   twl6040 will be broken
> 
> The solution or these are:
> set the twl6040 to i2c fast mode with regmap patch
> Clear the INTID register right after we request the audpwron GPIO and set it to
> low.
> 
> Generated on top of:
> git://git.linaro.org/people/lee.jones/mfd.git for-mfd-next
> 
> Tested on PandaBoard, PandaBoardES, OMAP4-blaze (SDP)
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg310725.html
> [2] Command in u-boot to enable the audpwron on PandaBoards: gpio set 127
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   mfd: twl6040: Select i2c fast mode as default with regmap patch
>   mfd: twl6040: Move register patching earlier in probe
>   mfd: twl6040: Clear the interrupt ID register before requesting IRQ

Patch 3 is making my system to boot normally.

Now, it is hard to devise if this is the root cause of the problem that
I was experiencing, since adding a sleep at the exact same place was
fixing my issue. Your twl6040_reg_read() could have the same effect,
without solving directly the issue.

Anyway, I tested your series on DuoVero.

Tested-by: Florian Vaussard <florian.vaussard@epfl.ch>

Regards,
Florian
