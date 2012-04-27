From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFT 0/8] ARM: OMAP: remove IP checks from SoC family detection
Date: Fri, 27 Apr 2012 15:25:38 -0700
Message-ID: <87aa1wyfq5.fsf@ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
	<20120427220813.GE19196@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:40401 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753148Ab2D0WZh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 18:25:37 -0400
Received: by pbbro2 with SMTP id ro2so107155pbb.27
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 15:25:36 -0700 (PDT)
In-Reply-To: <20120427220813.GE19196@animalcreek.com> (Mark A. Greer's message
	of "Fri, 27 Apr 2012 15:08:13 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> On Thu, Apr 26, 2012 at 04:29:45PM -0700, Kevin Hilman wrote:
>
> Hi Kevin.
>
>> This is a rebased version of this series which is ready for broader
>> testing.  I'd especially appreciate testing from those of you with
>> AM35x platforms.
>> 
>> Currently, our SoC detection is based on SoC family detection
>> (using die ID) and the presence of specific IP blocks (or feature.)
>> 
>> This series begins the separation of the SoC family detection and
>> specific IP detection by completely removing IP detection from the SoC
>> family detection (cpu_is_*.)
>> 
>> Applies on top of v3.4-rc4, boot tested on AM3517 EVM.
>
> Your series applied and booted without issue until the point that
> pm_idle is called.  At that point it hung because its doing a wfi
> and not getting an interrupt to wake up back up.  That's expected
> behaviour so your patches are good (IMHO) but I need to finish and
> submit a new version of my patches to fix that issue.

For the benefit of others wanting to test this:

You have to use 'nohlt' on the cmdline on AM35x in order to avoid WFI
and the wakeup problems that are still being worked on.

Kevin
