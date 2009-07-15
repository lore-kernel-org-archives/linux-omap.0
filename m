From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: PM: off mode
Date: Wed, 15 Jul 2009 12:13:18 +0300
Message-ID: <4A5D9DAE.8020601@nokia.com>
References: <4A5C7391.5050604@nokia.com> <87r5wj9p7q.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40877 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbZGOJOI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 05:14:08 -0400
In-Reply-To: <87r5wj9p7q.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Kevin Hilman wrote:
> Roger Quadros <ext-roger.quadros@nokia.com> writes:
> 
>> Hi Kevin,
>>
>>  Off mode does not seem to work on RX51 on latest PM branch. I get a
>> reboot if I set enable_off_mode and sleep_while_idle and I wait for
>> timeout.
>>
>>  Does it work on other platforms?
>>
> 
> Yes, I tested on SDP, omap3evm, Beagle, Overo and RX51.
> 
> On RX51, I'm using omap3_pm_defconfig with the debug UART changed to
> UART3 and things work fine here.
> 
> I using rootfs from latest fiasco image, and it drops me into an early
> shell because /sbin/preinit fails in various ways. Note that I'm using
> an S2.0 GP board.  Note also that I modified /sbin/preinit to launch
> another getty on ttyS2 so I get a shell since newer kernels ignore the
> ATAGs passed by nolo.
> 
> Below is a console log of my boot so you can see what is going on.
> Because /sbin/preinit enables off-mode and sleep_while_idle, I just
> let it boot and it seems to work.
> 
> Kevin
> 

I am having S2.1 board and it does not work on that. It gets locked up and 
restarts after idle timeout.
But I checked that it works on S2.0 board.

Any clue what could be the problem?

-roger
