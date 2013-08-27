From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Tue, 27 Aug 2013 13:23:43 -0700
Message-ID: <87vc2qyjao.fsf@linaro.org>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<5211E3F6.6090108@ti.com> <52125A39.3010008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:55754 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab3H0UXr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Aug 2013 16:23:47 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so5288679pab.24
        for <linux-omap@vger.kernel.org>; Tue, 27 Aug 2013 13:23:46 -0700 (PDT)
In-Reply-To: <52125A39.3010008@ti.com> (Dave Gerlach's message of "Mon, 19 Aug
	2013 12:47:37 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Gururaja Hebbar <gururaja.hebbar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Hi Dave,

Dave Gerlach <d-gerlach@ti.com> writes:

> On 08/19/2013 04:23 AM, Gururaja Hebbar wrote:
>> On 8/6/2013 11:19 PM, Dave Gerlach wrote:
>>> Hi,
>>>
>>> This is the third version of the patch series for adding basic suspend-resume
>>> support for AM33XX, previously submitted by Vaibhav Bedia. This patchset
>>> is based on 3.11-rc4 and depends on a forthcoming patchset from Suman Anna
>>> that adds mailbox support for the wkup_m3. The patches at [1], [2], and [3] are
>>> required for the pm code to properly suspend and resume.
>>>
>>> The PM code uses the firmware interface and expects the userspace to load
>>> the WKUP_M3 binary before the suspend-resume functionality is made available.
>>> The binary file (and the source-code for WKUP_M3) can be obtained from the
>>> 'next2' branch at [4]. The WKUP_M3 binary can either be loaded post bootup
>>> via the sysfs entry './sys/devices/ocp.2/wkup_m3.4/firmware' or it can be
>>> included in the kernel image as part of the build process.
>>>
>>> Suspend to mem is tested on am335x-bone and am335x-evm.
>>>
>>> More details on AM335x suspend-resume are provided within the commit logs
>>> for each patch.
>>
>> can you share the working repo which has all these patches applied?
>>
>> Thanks & Regards
>> Gururaja
>>
>
> The working repo for this version of the patch series can be found here:
>
> git://github.com/dgerlach/linux-pm.git am335x-3.11rc4-suspend-resume

I tried this branch on my beaglebone black, and it's not fully resuming.
Suspend seems to be working (power draw goes from ~1W to ~130mW) and
pressing a key on the UART seems to be waking up the SoC (power draw
goes to ~600mW) but I don't ever get the console back.

Is there a specific version of the firmware I should be using?

Kevin
