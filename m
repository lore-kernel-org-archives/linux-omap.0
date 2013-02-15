From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
Date: Fri, 15 Feb 2013 19:20:45 +0530
Message-ID: <511E3D35.4060909@ti.com>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com> <511E323E.3050104@ti.com> <20130215130745.GC16558@arwen.pp.htv.fi> <20130215130842.GD16558@arwen.pp.htv.fi> <511E3B3F.1000609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42114 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935780Ab3BONt1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 08:49:27 -0500
In-Reply-To: <511E3B3F.1000609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a0131647 <sourav.poddar@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

On Friday 15 February 2013 07:12 PM, a0131647 wrote:
> Hi,
> On Friday 15 February 2013 06:38 PM, Felipe Balbi wrote:
>> On Fri, Feb 15, 2013 at 03:07:45PM +0200, Felipe Balbi wrote:
>>> On Fri, Feb 15, 2013 at 06:33:58PM +0530, a0131647 wrote:
>>>> Hi,
>>>> On Friday 15 February 2013 05:36 PM, Santosh Shilimkar wrote:
>>>>> OMAP UART IP needs manual idle modes based on state of the
>>>>> IP. Currently this is handled by the driver with function pointers
>>>>> implemented in platform code.
>>>>>
>>>>> This however breaks in case of device tree because of missing
>>>>> idle handling.
>>>>>
>>>>> The series tries to address the issue
>>>>>
>>>>> Patches has been tested on OMAP4 and OMAP5 devices where the console
>>>>> slugishness was observed without idle mode handling. CPUIDLE and
>>>>> suspend tested ok on these devices.
>>>>>
>>>>> Need help in testing on OMAP2, OMAP3 and AM3XXX devices.
>>>>>
>>>> Tested this series on omap3630 beagle board for:
>>>> 1. Retention in idle and suspend.
>>>> 2. Off mode in idle and suspend.
>>>>
>>>> Tested-by: Sourav Poddar<sourav.poddar@ti.com>
>>> try setting autosuspend_delay to -1
>> Also try DT boot and try to wakeup from echo mem>  /sys/power/state by
>> sending data through UART console.
>>
> Suspend/resume with dt is not functional with the current mainline.
>
With DT, suspend driver itself are not getting registered.
The patch is in Paul's queue [1]

regards,
Santosh

[1] https://patchwork-mail2.kernel.org/patch/2116671/



