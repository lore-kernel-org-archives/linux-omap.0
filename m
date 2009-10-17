From: michael <michael@panicking.kicks-ass.org>
Subject: Re: hrtimer_nanosleep() weirdness...
Date: Sat, 17 Oct 2009 09:53:15 +0200
Message-ID: <4AD977EB.8030004@panicking.kicks-ass.org>
References: <1255721867.19793.311.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ms01.sssup.it ([193.205.80.99]:41783 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752105AbZJQHzw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 17 Oct 2009 03:55:52 -0400
In-Reply-To: <1255721867.19793.311.camel@blitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi,

Peter Barada wrote:
> I'm using an hrtimer in my tsc2004 touch driver to sleep between samples
> for 7.5mSec.  Here's the essence of the inner loop that grabs samples:
> 
> for (;;) {
> 	// Get a point, pass it to input_report_abs...
> 	pen_is_down = tsc2004_get_point(d);
> 
> 	// If pen is up up, then break out
> 	if (!pen_is_down || signal_pending(tsk))
> 	break;
> 
> 	{
> 		struct timespec timeout;
> 		// sleep for 7.5 mSec (giving max 133 touch/sec)
> 		timeout = ns_to_timespec(75 * 100 * 1000);
> 		hrtimer_nanosleep(&timeout, NULL, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
> 	}
> }
> 
> What's really strange is when I use ts_test to measure sample rate, I
> see:
> OMAP-Torpedo# export TSLIB_TSDEVICE=/dev/input/event0
> OMAP-Torpedo# export TSLIB_CONSOLEDEVICE=none
> OMAP-Torpedo# ts_test
> 717.804687:    176    161    234
> 717.813446:    176    161    234
> 717.822265:    176    160    234
> 717.993255:    178    159    234
> 718.002014:    179    158    234
> 718.188537:    180    158    234
> 719.015441:    181    157    234
> 719.165100:    181    157    234
> 719.360412:    182    157    234
> 719.369079:    182    157    234
> 719.438537:    182    156    234
> 719.555725:    182    156    234
> 719.564392:    182    156    234
> 719.751037:    180    155    234
> 719.768432:    179    155    234
> 719.777099:    178    154    234
> 719.946350:    174    150    234
> 720.000976:    175    144    234
> 720.141662:    184    140    234
> 720.336975:    189    138    234
> 720.490722:    195    137    234
> 720.499420:    198    138    234
> 720.858123:    198    139    234
> 720.922912:    198    139    234
> 721.126922:    198    139    234
> 721.135620:    198    139    234
> 721.144317:    198    139    234
> 721.152984:    198    139    234
> 721.161682:    198    139    234
> 721.313537:    198    139    234
> 721.438537:    198    138      0
> 
> Which shows over 3.63 seconds 33 samples, or only 9.08 samples/second,
> including a max delay of .827 seconds (719.015441 - 718.188537).  
> 
> But if I "ifup eth0" to bring the networking up (and nothing else is
> running), I get:

Not sure,
but I think that you have introduced a new interrupt source and you have 
a pickahed of hrtimer in the irq_exit path that run sofirq.

Michael
