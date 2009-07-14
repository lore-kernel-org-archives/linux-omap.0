From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Stable PM release for Overo
Date: Tue, 14 Jul 2009 10:28:24 -0700
Message-ID: <87hbxf9nt3.fsf@deeprootsystems.com>
References: <4A5C7391.5050604@nokia.com> <87r5wj9p7q.fsf@deeprootsystems.com>
	<988A3DF4-EE3C-4563-8748-B696795D5615@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:62877 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238AbZGNR21 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 13:28:27 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1053870wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2009 10:28:27 -0700 (PDT)
In-Reply-To: <988A3DF4-EE3C-4563-8748-B696795D5615@mac.com> (Elvis Dowson's message of "Tue\, 14 Jul 2009 21\:16\:06 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap@vger.kernel.org

Elvis Dowson <elvis.dowson@mac.com> writes:

> Hi Kevin,
>
> On Jul 14, 2009, at 8:58 PM, Kevin Hilman wrote:
>
>> Yes, I tested on SDP, omap3evm, Beagle, Overo and RX51.
>
> Would you happen to have a stable PM release that works with the
> Overo, for linux-omap3-2.6.29?  

I've only tested the current PM branch (2.6.30 based) on Overo since I
just recieved hardware, and I have no plans to test/support pm-2.6.29
on new platforms.

In the initial announcment of the new PM branch, I mentioned I tested
on Overo, but that Overo support in linux-omap master needs some
updates and some testing before the PM branch will be very usable.

Kevin

