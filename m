From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/5] omap2plus: Trivial build break fixes
Date: Wed, 05 Jan 2011 09:20:00 -0800
Message-ID: <87r5crz2rj.fsf@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
	<8762u4423o.fsf@ti.com>
	<6a39d0124306a5ac6b567edca88f0671@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44026 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751725Ab1AERUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 12:20:04 -0500
Received: by mail-yw0-f45.google.com with SMTP id 5so7046345ywl.32
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 09:20:04 -0800 (PST)
In-Reply-To: <6a39d0124306a5ac6b567edca88f0671@mail.gmail.com> (Santosh
	Shilimkar's message of "Wed, 5 Jan 2011 16:28:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

[...]

>> Minor nit in your git-send-email config.
>>
>> Can you add the following to your ~/.gitconfig, or update to newer
>> git
>> where this is now the default:
>>
>> [sendemail]
>> 	chainreplyto = false
>>
>> This will make all patches a reply to PATCH 0 instead of to the
>> previous
>> patch.
>>
> Have tried this in v2 I posted but it didn't appear to be a
> reply for PATCH 0.

You didn't have (or I didn't see) a PATCH 0 in your v2 version.  After
patch 1, all patches are replies to patch 1 (using In-Reply-To: and
References:) resulting in proper threading.

> May be I missed something.

I don't think so, it looks right now.

Kevin


