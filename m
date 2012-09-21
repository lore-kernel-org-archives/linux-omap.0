From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: serial-omap regression?
Date: Fri, 21 Sep 2012 15:10:55 +0530
Message-ID: <505C3627.1060909@ti.com>
References: <87wqzofgms.fsf@deeprootsystems.com> <87obl0fga1.fsf@deeprootsystems.com> <20120921092822.GE15115@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:51019 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932742Ab2IUJlB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Sep 2012 05:41:01 -0400
Received: by oago6 with SMTP id o6so3124837oag.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 02:41:00 -0700 (PDT)
In-Reply-To: <20120921092822.GE15115@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, Sourav Poddar <sourav.poddar@ti.com>

On Friday 21 September 2012 02:58 PM, Felipe Balbi wrote:
> Hi,
>
> On Thu, Sep 20, 2012 at 04:03:50PM -0700, Kevin Hilman wrote:
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>>
>>> Hi Felipe,
>>>
>>> I just noticed today that one of my boards (3530/Overo) was not making
>>> it to the console when using an Debian rootfs (nfsroot) but works fine
>>> with my basic busybox initramfs.  Basically, it hangs somewhere between
>>> finishing the userspace init and launching the login shell.
>>>
>>> git bisect ended up pointing the finger at a patch in the OMAP serial
>>> series[1].  I didn't debug this any further.  Any ideas?
>>>
>> I forgot to add, this was first noticed when testing with
>> arm-soc/for-next which has the serial-omap changes pulled in as a
>> dependency.
> hmmm, Shubhro had written a patch to fix some mistakes on rlsi handler.
> Maybe it fixes this problem ?
>
> Shubhro, can you send your patch ?
Yes I am in teh process of testing it.
Will post in an hour.

>

