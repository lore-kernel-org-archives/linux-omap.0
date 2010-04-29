From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: ARM suspend to disk?
Date: Thu, 29 Apr 2010 10:58:40 -0700
Message-ID: <87y6g6w373.fsf@deeprootsystems.com>
References: <4BD881A7.2020402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62031 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758698Ab0D3SWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 14:22:23 -0400
Received: by pwj9 with SMTP id 9so314334pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 11:22:22 -0700 (PDT)
In-Reply-To: <4BD881A7.2020402@gmail.com> (Peter Tseng's message of "Wed\, 28 Apr 2010 14\:42\:47 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Tseng <tsenpet09@gmail.com>
Cc: linux-omap@vger.kernel.org

Peter Tseng <tsenpet09@gmail.com> writes:

> I last posted a few weeks ago; I'm Peter Tseng, using the Gumstix Overo
> for a project. I'm interested in power management and a few related
> things. A few of the things I am interested in are suspend to disk and
> snapshot boot.
>
> I found a page on elinux.org with a few notes on the issue for ARM.
> However, it looks to be a bit outdated:
> http://elinux.org/Suspend_To_Disk_For_ARM
>
> I am wondering how applicable anything on this page is to the current
> omap-pm developments. Or, if not, any pointers on how it might be done -
> for example, if I felt like I should do some hacking to try to get this
> working and contribute these back, a general outline of what I might
> have to do)

Not really and answer to your question since I don't know the answer,
but just curious about your goals, since there may be an easier way.

What do you expect to gain from suspend-to-disk + snapshot boot that
you don't already get from suspend-to-RAM using off-mode?

On OMAP, with off-mode enabled, a suspend to RAM puts the entire OMAP
into full-chip off, and essentially reboots the ARM when waking up
from suspend (or idle) already.

Kevin



