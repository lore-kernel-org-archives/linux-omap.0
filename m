From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: omap-pm: omap3_pm_defconfig no longer booting on Overo
Date: Fri, 30 Apr 2010 11:54:29 -0700
Message-ID: <8739yckbyy.fsf@deeprootsystems.com>
References: <4BD93413.6000409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43121 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab0D3Syd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 14:54:33 -0400
Received: by pvg7 with SMTP id 7so323758pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 11:54:32 -0700 (PDT)
In-Reply-To: <4BD93413.6000409@gmail.com> (Peter Tseng's message of "Thu\, 29 Apr 2010 03\:24\:03 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Tseng <tsenpet09@gmail.com>
Cc: linux-omap@vger.kernel.org

Peter Tseng <tsenpet09@gmail.com> writes:

> Since the rc5 tag, omap3_pm_defconfig from the pm branch no longer boots
> on the Gumstix Overo.
> I am certain that a build back in the rc3 days worked. Unfortunately, I
> don't know about rc4, or anything that happenend in the intervening time.
>
> Any clues on how to fix? If necessary, I'll provide what info I can to
> help diagnose the issue if told what to do.

First step is to enable CONFIG_LL_DEBUG and CONFIG_EARLYPRINTK in the
defconfig (I should have these enabled by default in omap3_pm_defconfig)

Then, boot adding 'earlyprintk' to your boot cmdline and post the
resulting bootlog here.

Thanks,

Kevin

