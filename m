From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 00/10] I2C updates
Date: Tue, 14 Feb 2012 14:41:32 +0530
Message-ID: <4F3A2544.2000407@ti.com>
References: <1328882405-15284-1-git-send-email-shubhrajyoti@ti.com> <1BAFE6F6C881BF42822005164F1491C3317B26A0@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:46911 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756468Ab2BNJLk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 04:11:40 -0500
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C3317B26A0@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tuesday 14 February 2012 11:42 AM, Hebbar, Gururaja wrote:
> Hi,
>
> I am interested in testing these patches on AM335x.

Thanks for your interest in testin.
>  Do you have a tree with these
> patches applied so that I can pull.

tree        : git://gitorious.org/linus-tree/linus-tree.git
branch    : i2c_misc_fixes

let me know if that works for you
> On Fri, Feb 10, 2012 at 19:29:55, Datta, Shubhrajyoti wrote:
>> This patch series colates the various i2c updates into
>> a series.  Since it is collection of various patches
>> the version info is not retained, however most of them undergone
>> multiple versions.
>>
>> This is rebased to linus head commit 63082402968f4b73f10b28a8ac1f3da821aeb82d
>>
>> The patch series does the following 
>>
>> - Warn fixes if CONFIG_PM_RUNTIME is not selected.
>> - I2C register restore only if context if the context is lost
>> - Bus busy recovery mechanism.
>> - the reset is not done in init.
>>
>> Tested on omap4sdp and omap3sdp. 
>>
>>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>>
>> Jon Hunter (1):
>>   I2C: OMAP: Correct I2C revision for OMAP3
>>
>> Shubhrajyoti D (8):
>>   I2C : OMAP : make omap_i2c_unidle/idle functions depend on
>>     CONFIG_PM_RUNTIME
>>   OMAP : I2C : Remove reset at init
>>   OMAP: I2C: I2C register restore only if context is lost
>>   OMAP: I2C: Fix the interrupt clearing in OMAP4
>>   OMAP: I2C: Fix the mismatch of pm_runtime enable and disable
>>   OMAP: I2C: Optimise the remove code
>>   OMAP: I2C: Fix the error handling
>>   I2C: OMAP: Don't check if wait_for_completion_timeout() returns less
>>     than zero
>>
>> Vikram Pandita (1):
>>   I2C: OMAP: Recover from Bus Busy condition
>>
>>  drivers/i2c/busses/i2c-omap.c |  173 ++++++++++++++++++++++++-----------------
>>  1 files changed, 101 insertions(+), 72 deletions(-)
>
>
> Regards, 
> Gururaja

