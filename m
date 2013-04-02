From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: Serial driver sysc cleanup for 3.10
Date: Tue, 2 Apr 2013 11:52:03 +0530
Message-ID: <515A790B.60301@ti.com>
References: <1363768601-17862-1-git-send-email-santosh.shilimkar@ti.com> <20130401170148.GJ10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53840 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759572Ab3DBGUK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Apr 2013 02:20:10 -0400
In-Reply-To: <20130401170148.GJ10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

On Monday 01 April 2013 10:31 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130320 01:39]:
>> Tony,
>>
>> Here is the pull request for OMAP serial driver sysconfig cleanup. The series
>> removes all the hackery of sysconfig from UART driver and let runtime backend
>> handle it. Without this series serial console is almost un-usable on OMAP5.
>> One of the patch touches driver/serial but I got an ack from Greg KH to get
>> it queued via OMAP tree.
>>
>>
>> The following changes since commit a937536b868b8369b98967929045f1df54234323:
>>
>>   Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap_serial_sysc_cleanup
>>
>> for you to fetch changes up to 0f78c88b107a25561d0830c7fb695134ac7e8892:
>>
>>   ARM: OMAP2+: hwmod: Remove sysc slave idle and auto idle apis (2013-03-19 12:07:49 +0530)
> 
> Looks like Paul had some comments and has applied some of these,
> so ignoring this one for now.
> 
Paul is picked one patch for now. Hope we can quickly sort out this for
merge window.

Regards,
Santosh

