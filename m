From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv8 4/5] OMAP: I2C: Remove the reset in the init path
Date: Fri, 16 Dec 2011 14:29:22 +0530
Message-ID: <4EEB086A.2050607@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com> <1323773758-6375-5-git-send-email-shubhrajyoti@ti.com> <alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36803 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750922Ab1LPI72 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 03:59:28 -0500
In-Reply-To: <alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, b-cousson@ti.com, ben-linux@fluff.org

Ben,

On Friday 16 December 2011 02:10 PM, Paul Walmsley wrote:
> Hi
>
> On Tue, 13 Dec 2011, Shubhrajyoti D wrote:
>
>> -  The reset in the driver at init is not needed anymore as the
>>    hwmod framework takes care of reseting it.
>> -  Reset is removed from omap_i2c_init, which was called
>>    not only during probe, but also after time out and error handling.
>>    device_reset were added in those places to effect the reset.
>> -  Earlier the hwmod SYSC settings were over-written in the driver.
>>    Removing the same and letting the hwmod take care of the settings.
>> -  Clean up the SYSS_RESETDONE_MASK macro as it is no longer needed.
>> -  Clean up the SYSCONFIG SYSC bit definition macros.
>> -  Fix the typos in wakeup.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |   83 +++++++++++-----------------------------
>>  1 files changed, 23 insertions(+), 60 deletions(-)
> This patch either needs to be acked by Ben with a note that it's okay for 
> us to merge through the OMAP tree, or needs to be merged by Ben during the 
> 3.4 merge window, after patches 1-3 have reached the mainline tree.
I agree.
Ben do you have any comments .
>
> - Paul

