From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/7] ARM: OMAP: remove IP checks from SoC family detection
Date: Fri, 06 Jan 2012 10:55:07 -0800
Message-ID: <87aa604q5w.fsf@ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
	<79CD15C6BA57404B839C016229A409A8071991@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42709 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753438Ab2AFSzL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jan 2012 13:55:11 -0500
Received: by mail-gy0-f182.google.com with SMTP id r16so971034ghr.41
        for <linux-omap@vger.kernel.org>; Fri, 06 Jan 2012 10:55:10 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A8071991@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Thu, 5 Jan 2012 11:15:58 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> Currently, our SoC detection is based on SoC family detection
>> (using die ID) and the presence of specific IP blocks (or feature.)
>> 
>> This series begins the separation of the SoC family detection and
>> specific IP detection.
>> 
>> Applies on top of Tony's current master branch and so far, it has only
>> been compile tested using omap2plus_defconfig.
>> 
> I tested it on OMAP3EVM (AM37x) and AM3517EVM as well and it is booting up
> for me.
>
> Feel free to add my acked and/or tested by.

Great, thanks for testing!

Can you also test with the patch 8 that I just sent?   It boot tests
fine on my AM3517 EVM, but didn't do any other tests.

Thanks,

Kevin

