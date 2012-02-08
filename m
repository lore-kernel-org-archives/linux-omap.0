From: Dmitry Antipov <dmitry.antipov@linaro.org>
Subject: Re: Minimum timing resolution in Ubuntu/Linaro on the PandaBoard
 ES
Date: Tue, 07 Feb 2012 21:21:03 -0800
Message-ID: <4F32063F.1020607@linaro.org>
References: <4F31A91B.8080106@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38160 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab2BHFT5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 00:19:57 -0500
Received: by iacb35 with SMTP id b35so337952iac.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Feb 2012 21:19:56 -0800 (PST)
In-Reply-To: <4F31A91B.8080106@umich.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Richardson <chardson@umich.edu>
Cc: John Stultz <john.stultz@linaro.org>, linaro-dev@lists.linaro.org, linux-omap@vger.kernel.org

On 02/07/2012 02:43 PM, Andrew Richardson wrote:

> I'm experiencing what appears to be a minimum clock resolution issue
> in using clock_gettime() on a PandaBoard ES running ubuntu.

Do you have CONFIG_OMAP_32K_TIMER enabled in your kernel?
Look at 'dmesg | grep clock' and check for the following:

...
OMAP clockevent source: GPTIMER1 at 32768 Hz
sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
...

Most probably this is the answer - by default, recent OMAPs are configured
to use less-accurate, but more energy-saving timer (32KHz) in favor of
MPU timer.

Disable CONFIG_OMAP_32K_TIMER to switch to MPU timer, and check
'dmesg | grep clock' to see:

...
OMAP clockevent source: GPTIMER1 at 38400000 Hz
OMAP clocksource: GPTIMER2 at 38400000 Hz
sched_clock: 32 bits at 38MHz, resolution 26ns, wraps every 111848ms
...

BTW, I have no ideas why clock_getres(CLOCK_REALTIME,...) returns {0, 1}
regardless of underlying clock source. I expect {0, 30517} for 32K timer
and {0, 26} for MPU timer.

Dmitry
