From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 0/4] OMAP: PM debug: remove register dump, misc cleanups
Date: Wed, 15 Jun 2011 17:33:19 -0700
Message-ID: <87boxyy5rk.fsf@ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
	<4DF60255.1070409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:37045 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752104Ab1FPAdY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 20:33:24 -0400
Received: by mail-iw0-f171.google.com with SMTP id 8so1163089iwn.16
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 17:33:23 -0700 (PDT)
In-Reply-To: <4DF60255.1070409@ti.com> (Santosh Shilimkar's message of "Mon,
	13 Jun 2011 17:58:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On 5/27/2011 4:32 AM, Kevin Hilman wrote:
>> Inspired by Jean's work to move PM code to modules, I decided it's
>> time to remove a bunch of ugly and difficult to maintain code from PM
>> debug.
>>
>> The main chunk here is removing the register dump features for
>> OMAP2/OMAP3 which are awful to read, and impossible to scale for
>> OMAP4+.  Also, there are now some userspace /dev/mem-based tools (like
>> omapconf) that can handle this type of thing much better, and with a
>> much better interface and display.
>>
>> Series applies to v2.6.39.
>>
> I have tested this series on V3.0-rc2 as part of OMAP4 PM
> series. I think it's ready for merge.

Thanks, adding to my queue for the next merge window (branch: for_3.1/pm-misc)

Kevin
