From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: linux-omap-pm troubles on Gumstix Overo
Date: Thu, 08 Apr 2010 12:11:50 -0700
Message-ID: <8763413gjt.fsf@deeprootsystems.com>
References: <4BBBF808.80000@gmail.com> <87tyrnfe8c.fsf@deeprootsystems.com>
	<87ochuapm9.fsf@deeprootsystems.com> <4BBD1F6A.6060005@gmail.com>
	<87bpdt6f2e.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:64717 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933150Ab0DHTS7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 15:18:59 -0400
Received: by bwz25 with SMTP id 25so2058118bwz.28
        for <linux-omap@vger.kernel.org>; Thu, 08 Apr 2010 12:18:58 -0700 (PDT)
In-Reply-To: <87bpdt6f2e.fsf@deeprootsystems.com> (Kevin Hilman's message of "Thu\, 08 Apr 2010 10\:15\:37 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Tseng <tsenpet09@gmail.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Peter Tseng <tsenpet09@gmail.com> writes:

[...]

>> 4) Suspend to memory (echo mem > /sys/power/state) works now, but when I
>> wake up the board (via a keypress), I am no longer able to type anything
>> at the prompt. Any clue about this one?
>
> Indeed, I was able to reproduce this as well and seems to be a new
> regression in the PM branch.  I see the same on omap3evm and n900 now
> too.
>
> If you enable the UART timeouts + sleep_while_idle, you should avoid
> this problem while I try and figure out what's going on:
>
> echo 5 > /sys/devices/platform/serial8250.0/sleep_timeout 
> echo 5 > /sys/devices/platform/serial8250.1/sleep_timeout 
> echo 5 > /sys/devices/platform/serial8250.2/sleep_timeout 
> echo 1 > /debug/pm_debug/sleep_while_idle  
>

Just pushed a new PM branch with a fix for this problem.

Details in my recent reply to the thread 
'OMAP3: Serial: Improved sleep logic'

Kevin
