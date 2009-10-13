From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Broken cpuidle on PM branch?
Date: Tue, 13 Oct 2009 09:25:17 -0700
Message-ID: <87r5t7mfbm.fsf@deeprootsystems.com>
References: <20091012192347.GI32041@smtp.gmail.com>
	<20091013133151.GA8028@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:52789 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757588AbZJMQ0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 12:26:31 -0400
Received: by pzk26 with SMTP id 26so9113483pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 09:25:19 -0700 (PDT)
In-Reply-To: <20091013133151.GA8028@esdhcp037198.research.nokia.com> (Eduardo Valentin's message of "Tue\, 13 Oct 2009 16\:31\:51 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eduardo.valentin@nokia.com
Cc: linux-omap@vger.kernel.org

Eduardo Valentin <eduardo.valentin@nokia.com> writes:

> Hello Amit,
>
> On Mon, Oct 12, 2009 at 09:23:47PM +0200, ext Amit Kucheria wrote:
>> Hi,
>> 
>> I am testing twl4030 script optimisations on the current PM branch. But I am
>> seeing the board (RX51) freeze when CPU_IDLE is enabled in the config.
>> 
>> Is it known to work on other boards?
>
> I'm actually seeing this same behavior. But the board actually does not
> freeze. If you keep a key pressed of send a sysrq through serial line
> then you eventually get it back.
>
> It seams to be something related to serial driver and wakeup ?
>

Do you see this problem after doing

  # echo 1 > /debug/pm_debug/sleep_while_idle

?  There is a known problem with the UART inactivity timer that I'm
debugging currently.

Kevin


>> 
>> Regards,
>> Amit
>> -- 
>> -------------------------------------------------------------------------
>> Amit Kucheria,				 Kernel Developer, Verdurent
>> -------------------------------------------------------------------------
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> -- 
> Eduardo Valentin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
