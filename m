From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch and cpufreq
Date: Mon, 12 Jan 2009 20:33:57 -0800
Message-ID: <878wpfn7t6.fsf@deeprootsystems.com>
References: <F8E71D7D-92CC-4E6D-92F0-21BD8E9C432D@student.utwente.nl>
	<D1986163-A086-4798-A1D7-0A5E93984C21@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:15806 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688AbZAMEeB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 23:34:01 -0500
Received: by yw-out-2324.google.com with SMTP id 9so3570542ywe.1
        for <linux-omap@vger.kernel.org>; Mon, 12 Jan 2009 20:34:00 -0800 (PST)
In-Reply-To: <D1986163-A086-4798-A1D7-0A5E93984C21@student.utwente.nl> (Koen Kooi's message of "Mon\, 12 Jan 2009 08\:16\:10 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

Koen Kooi <k.kooi@student.utwente.nl> writes:

> Op 11 jan 2009, om 19:53 heeft Koen Kooi het volgende geschreven:
>
>> Hi,
>>
>> I was trying to get cpufreq going on beagleboard
>> (http://cgit.openembedded.net/cgit.cgi?url=openembedded/blob/&id=f56b27781d810dcca0a9946cfd2524c36b7a49c0&path=packages/linux/linux-omap-pm/beagle-cpufreq.diff
>> ) and I ran into a few issues;
>>
>> * pm-prev branch: SD card doesn't initialize, and my rootfs is in SD
>
> SD *does* initialize, but 'rootwait' doesn't work, booting from a
> ubifs volume in nand works and udev automounts my SD card. Cpufreq
> isn't working, so I still need advice on that :)

pm-next isn't supposed to work. ;) It is work in progress.  Once it's
ready it will become 'pm'.

Re: SD/MMC problem I see the same problem in linux-omap HEAD where
rootwait doesn't seem to work, so at least the 'rootwait' problem
think is not PM branch related.

Re: CPUfreq on Beagle.  I haven't done any testing of CPUfreq on
beagle.  AFAICT, the OPP definitions are not being defined for Beagle.
That would explain no availabe operating points.

These are board specific settings.  You could start by looking at the
*_rate_table definitions in board-3430sdp.c.

Kevin

