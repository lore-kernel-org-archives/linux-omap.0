From: Peter Tseng <tsenpet09@gmail.com>
Subject: Re: ARM suspend to disk?
Date: Mon, 03 May 2010 01:09:05 -0400
Message-ID: <4BDE5A71.5060806@gmail.com>
References: <4BD881A7.2020402@gmail.com> <87y6g6w373.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40353 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0ECFIz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 01:08:55 -0400
Received: by vws19 with SMTP id 19so1458834vws.19
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 22:08:54 -0700 (PDT)
In-Reply-To: <87y6g6w373.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On 04/29/2010 01:58 PM, Kevin Hilman wrote:
> Peter Tseng <tsenpet09@gmail.com> writes:
> 
>> I last posted a few weeks ago; I'm Peter Tseng, using the Gumstix Overo
>> for a project. I'm interested in power management and a few related
>> things. A few of the things I am interested in are suspend to disk and
>> snapshot boot.
>>
>> I found a page on elinux.org with a few notes on the issue for ARM.
>> However, it looks to be a bit outdated:
>> http://elinux.org/Suspend_To_Disk_For_ARM
>>
>> I am wondering how applicable anything on this page is to the current
>> omap-pm developments. Or, if not, any pointers on how it might be done -
>> for example, if I felt like I should do some hacking to try to get this
>> working and contribute these back, a general outline of what I might
>> have to do)
> 
> Not really and answer to your question since I don't know the answer,
> but just curious about your goals, since there may be an easier way.
> 
> What do you expect to gain from suspend-to-disk + snapshot boot that
> you don't already get from suspend-to-RAM using off-mode?
> 
> On OMAP, with off-mode enabled, a suspend to RAM puts the entire OMAP
> into full-chip off, and essentially reboots the ARM when waking up
> from suspend (or idle) already.
> 

My goals: I am researching very low power devices - the ideal final goal
is to make devices such as e-book readers that can last for several
months (with regular use) on a single battery charge.

The power management capabilities of the OMAP have been helpful, but it
does appear (unless I am doing something wrong?) that even with off-mode
enabled, a suspend to RAM does still draw a few milliwatts of power.
Granted, this isn't much, but when we multiply that over several months,
it does add up. So I'd like to know if there's a way to reach zero,
hence my earlier questions.

Peter
