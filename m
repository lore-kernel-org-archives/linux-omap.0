From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 14/19] ARM: OMAP4: wakeupgen: enable clocks for save_secure_all
Date: Tue, 29 May 2012 13:15:23 -0700
Message-ID: <87pq9mg2w4.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-15-git-send-email-t-kristo@ti.com>
	<871umj4qnl.fsf@ti.com> <1337593097.28274.19.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56340 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754531Ab2E2UPZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 16:15:25 -0400
Received: by dadv2 with SMTP id v2so7345404dad.18
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 13:15:24 -0700 (PDT)
In-Reply-To: <1337593097.28274.19.camel@sokoban> (Tero Kristo's message of
	"Mon, 21 May 2012 12:38:17 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> On Wed, 2012-05-16 at 17:06 -0700, Kevin Hilman wrote:
>> +Benoit
>> 
>> Tero Kristo <t-kristo@ti.com> writes:
>> 
>> > save_secure_all needs l3_main_3_ick and l4_secure_clkdm enabled,
>> > otherwise the secure ROM code will crash.
>> >
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> 
>> I think I mentioned this already (I'm already lost in what I've said for
>> thisseries), but I don't think the secure RAM stuff belongs in the
>> wakeupgen driver.
>
> As mentioned, save_secure_all saves:
> - secure RAM
> - GIC registers
> - some other mysterious stuff
>
> Attempting to do separate saves for secure RAM + GIC hang the device
> during wakeup, in addition to being really inefficient (secure API calls
> are expensive.)

I guess my comment wasn't that this isn't needed, but that it doesn't
seem to belong in the wakeupgen base (which should probably converted
into a real driver.)

Seems better to have this stuff in the secure code, maybe omap-secure.c?

Kevin

