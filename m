From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Overo serial problems after resume, vs. Beagleboard
Date: Tue, 22 Jun 2010 07:31:00 -0700
Message-ID: <87zkynnnq3.fsf@deeprootsystems.com>
References: <4C1F9B80.9010708@gmail.com> <874ogw1dy2.fsf@deeprootsystems.com>
	<4C207A9C.7070309@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48540 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070Ab0FVObG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 10:31:06 -0400
Received: by pwj8 with SMTP id 8so952483pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 07:31:04 -0700 (PDT)
In-Reply-To: <4C207A9C.7070309@compulab.co.il> (Mike Rapoport's message of "Tue\, 22 Jun 2010 11\:55\:56 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Peter Tseng <tsenpet09@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Han Wang <hw342@cornell.edu>

Mike Rapoport <mike@compulab.co.il> writes:

> Kevin Hilman wrote:
>> Peter Tseng <tsenpet09@gmail.com> writes:
>>
>>> I am seeing some discrepancies between the Overo (I believe I have a
>>> Water) and the Beagleboard (I have a Rev. B5) when resuming after a
>>> suspend to RAM.
>>
>> Not that it is much comfort, but I have the same problem on Overo but
>> don't see it on any other OMAP3 board.
>>
>> I have yet to debug this particular issue further.
>
> I had the same issue on CM-T35 and when I've disabled CONFIG_CPU_IDLE
> in the kernel configuration the issue disappeared. Maybe it'll be of
> some help.

That just masks the problem by not auto-gating the UART clocks.

Kevin

