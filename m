From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Overo serial problems after resume, vs. Beagleboard
Date: Tue, 10 Aug 2010 16:57:29 -0700
Message-ID: <AANLkTi=5a93=HTCxA11mZT6PKR7XkGVOiNGAT_7KNQJO@mail.gmail.com>
References: <4C1F9B80.9010708@gmail.com>
	<874ogw1dy2.fsf@deeprootsystems.com>
	<4C207A9C.7070309@compulab.co.il>
	<87zkynnnq3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60569 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894Ab0HJX5a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 19:57:30 -0400
Received: by gyg10 with SMTP id 10so3925963gyg.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 16:57:30 -0700 (PDT)
In-Reply-To: <87zkynnnq3.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Peter Tseng <tsenpet09@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Han Wang <hw342@cornell.edu>

On Tue, Jun 22, 2010 at 7:31 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Mike Rapoport <mike@compulab.co.il> writes:
>
>> Kevin Hilman wrote:
>>> Peter Tseng <tsenpet09@gmail.com> writes:
>>>
>>>> I am seeing some discrepancies between the Overo (I believe I have a
>>>> Water) and the Beagleboard (I have a Rev. B5) when resuming after a
>>>> suspend to RAM.
>>>
>>> Not that it is much comfort, but I have the same problem on Overo but
>>> don't see it on any other OMAP3 board.
>>>
>>> I have yet to debug this particular issue further.
>>
>> I had the same issue on CM-T35 and when I've disabled CONFIG_CPU_IDLE
>> in the kernel configuration the issue disappeared. Maybe it'll be of
>> some help.
>
> That just masks the problem by not auto-gating the UART clocks.

OK, I think I finally figured out this problem.  A similar thing was
reported on the n900 recently and got me to thinking that it must be
something fishy going on with the PER powerdomain since both n900 and
Overo are using a UART2 console, and UART2 is in PER.

Anyways, I just posted a patch[1] that should fix this. I'd appreciate
if anyone else with an Overo could confirm that things are back to
working as expected with CONFIG_CPU_IDLE.

Thanks,

Kevin

[1] https://patchwork.kernel.org/patch/118709/
