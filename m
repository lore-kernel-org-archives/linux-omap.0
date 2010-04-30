From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: ARM suspend to disk?
Date: Fri, 30 Apr 2010 15:06:14 -0700
Message-ID: <87iq78d295.fsf@deeprootsystems.com>
References: <4BD881A7.2020402@gmail.com> <87y6g6w373.fsf@deeprootsystems.com>
	<p2kf96d234e1004301446l255a8cb4h7287e2502934e9fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47794 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759756Ab0D3WGR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 18:06:17 -0400
Received: by pwj9 with SMTP id 9so420154pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 15:06:16 -0700 (PDT)
In-Reply-To: <p2kf96d234e1004301446l255a8cb4h7287e2502934e9fd@mail.gmail.com> (Cliff Brake's message of "Fri\, 30 Apr 2010 17\:46\:59 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: Peter Tseng <tsenpet09@gmail.com>, linux-omap@vger.kernel.org

Cliff Brake <cliff.brake@gmail.com> writes:

> On Thu, Apr 29, 2010 at 1:58 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>
>> What do you expect to gain from suspend-to-disk + snapshot boot that
>> you don't already get from suspend-to-RAM using off-mode?
>>
>> On OMAP, with off-mode enabled, a suspend to RAM puts the entire OMAP
>> into full-chip off, and essentially reboots the ARM when waking up
>> from suspend (or idle) already.
>
> What does the resume process look like in off mode?  Does the resume
> pass through the bootloader?  If so, are the bits that detects resume
> from "off" available in U-boot?

No, it does not pass through the boot loader.  

In general terms, resume from off-mode is the same to "normal" resume (from
retention) except that some additional state has to be restored before
continuing where you left off since the ARM core (as well as most the
OMAP itself) was turned off.

Kevin







