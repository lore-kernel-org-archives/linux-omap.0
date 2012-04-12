From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Thu, 12 Apr 2012 07:14:09 -0700
Message-ID: <87aa2hjavi.fsf@ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<4F859C5D.3090400@mlbassoc.com> <87hawqt6vt.fsf@ti.com>
	<4F86B227.90802@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:43857 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933556Ab2DLOOQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 10:14:16 -0400
Received: by dadn15 with SMTP id n15so3099555dad.16
        for <linux-omap@vger.kernel.org>; Thu, 12 Apr 2012 07:14:12 -0700 (PDT)
In-Reply-To: <4F86B227.90802@mlbassoc.com> (Gary Thomas's message of "Thu, 12
	Apr 2012 04:44:55 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Gary Thomas <gary@mlbassoc.com> writes:

> On 2012-04-11 13:17, Kevin Hilman wrote:
>> Gary Thomas<gary@mlbassoc.com>  writes:
>>
>> [...]
>>
>>> I fear I'm seeing similar problems with 3.3.  I have my board (similar
>>> to the BeagleBoard) ported to 3.0 and 3.3.  I'm seeing terrible network
>>> performance on 3.3.  For example, if I use TFTP to download a large file
>>> (~35MB), I get this:
>>>    3.0:  42.5 sec
>>>    3.3: 625.0 sec
>>> That's a factor of 15 worse!
>>
>> This might not be the same problem.  What is the NIC being used, and
>> does it have GPIO interrupts?
>
> My board uses SMSC911x with GPIO interrupt signal.

OK, then your problem is almost certainly solved by my GPIO triggering
fix, and not related to Grazvytas' problem.

>>
>> If it's using GPIO interrupts, then you likely need this patch from
>> mainline (v3.4-rc1)
>
> I tried to just pick up the patch you [sort of] quoted below, but had
> a hard time applying it to my kernel. I've tried to just pick up the
> latest files from the mainline kernel, but so far I've nothing that
> builds

Oh, right.  Sorry about that.  Yeah, that patch actually has
dependencies on other GPIO changes that were queued for v3.4 (and not in
v3.3.)

If you're on v3.3, just pull the branch below[1] which is based on
v3.3-rc2.  Pulling that into a v3.3 should build just fine.

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/fixes/gpio

