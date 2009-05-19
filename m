From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Does SmartReflex pm patches affect USB suspend resume operations
Date: Tue, 19 May 2009 09:22:21 -0700
Message-ID: <87my996p1e.fsf@deeprootsystems.com>
References: <7B1B64C5-631E-4C63-B1F3-F4429C697614@mac.com>
	<87tz3h6phr.fsf@deeprootsystems.com>
	<519CDA29-3736-4123-A8A7-7BA613AE342C@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:63666 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbZESQWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 12:22:23 -0400
Received: by pxi29 with SMTP id 29so2502843pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 09:22:23 -0700 (PDT)
In-Reply-To: <519CDA29-3736-4123-A8A7-7BA613AE342C@mac.com> (Elvis Dowson's message of "Tue\, 19 May 2009 20\:16\:23 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Elvis Dowson <elvis.dowson@mac.com> writes:

> Hi Kevin,
>
> On May 19, 2009, at 8:12 PM, Kevin Hilman wrote:
>>>
>>
>> You're testing something that others are not: PM branch minus SR
>> patches.
>>
>> I suggest you re-add the SR patches and try the suggestions of others:
>> Roger's patches + fix your board file.
>
> I've just finished the board-overo.c modifications and will try the SR
> patches now.
>
> I try it first without Roger's modifications and see what happens, and
> then apply his modifications.
>
>> That being said, the USB driver is known to be not fully PM aware yet.
>> On my SDP, I've tested MUSB in host mode with mass storage and a USB
>> key and it can suspend/resume just fine.  However, it does not work
>> with off-mode.
>
> What is off-mode?
>

Off-mode is when most of the chip goes off during suspend/idle.  This
requires some driver support which is missing in many of the drivers since
if the chip goes off, the driver needs to save/restore state.

Off-mode is disabled by default on the PM branch, but can be enabled
by doing

   # echo 1 > /sys/power/enable_off_mode

Kevin


