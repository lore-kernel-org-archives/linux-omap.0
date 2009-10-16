From: Peter Barada <peterb@logicpd.com>
Subject: hrtimer_nanosleep() weirdness...
Date: Fri, 16 Oct 2009 15:37:47 -0400
Message-ID: <1255721867.19793.311.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:43345 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751414AbZJPTc4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Oct 2009 15:32:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I'm using an hrtimer in my tsc2004 touch driver to sleep between samples
for 7.5mSec.  Here's the essence of the inner loop that grabs samples:

for (;;) {
	// Get a point, pass it to input_report_abs...
	pen_is_down = tsc2004_get_point(d);

	// If pen is up up, then break out
	if (!pen_is_down || signal_pending(tsk))
	break;

	{
		struct timespec timeout;
		// sleep for 7.5 mSec (giving max 133 touch/sec)
		timeout = ns_to_timespec(75 * 100 * 1000);
		hrtimer_nanosleep(&timeout, NULL, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
	}
}

What's really strange is when I use ts_test to measure sample rate, I
see:
OMAP-Torpedo# export TSLIB_TSDEVICE=/dev/input/event0
OMAP-Torpedo# export TSLIB_CONSOLEDEVICE=none
OMAP-Torpedo# ts_test
717.804687:    176    161    234
717.813446:    176    161    234
717.822265:    176    160    234
717.993255:    178    159    234
718.002014:    179    158    234
718.188537:    180    158    234
719.015441:    181    157    234
719.165100:    181    157    234
719.360412:    182    157    234
719.369079:    182    157    234
719.438537:    182    156    234
719.555725:    182    156    234
719.564392:    182    156    234
719.751037:    180    155    234
719.768432:    179    155    234
719.777099:    178    154    234
719.946350:    174    150    234
720.000976:    175    144    234
720.141662:    184    140    234
720.336975:    189    138    234
720.490722:    195    137    234
720.499420:    198    138    234
720.858123:    198    139    234
720.922912:    198    139    234
721.126922:    198    139    234
721.135620:    198    139    234
721.144317:    198    139    234
721.152984:    198    139    234
721.161682:    198    139    234
721.313537:    198    139    234
721.438537:    198    138      0

Which shows over 3.63 seconds 33 samples, or only 9.08 samples/second,
including a max delay of .827 seconds (719.015441 - 718.188537).  

But if I "ifup eth0" to bring the networking up (and nothing else is
running), I get:

OMAP-Torpedo# ifup eth0
[sleeping 5s]...net eth0: SMSC911x/921x identified at 0xc8858000, IRQ:
289
eth0: link down
eth0: link up, 100Mbps, full-duplex
udhcpc (v1.15.1) started
Sending discover...
Sending select for 192.168.3.151...
Lease of 192.168.3.151 obtained, lease time 86400
deleting routers
route: SIOCDELRT: No such process
adding dns 192.168.3.1
OMAP-Torpedo# ts_test
735.615905:    263    140    234
735.615905:    263    140    234
735.625152:    261    141    234
735.634277:    260    141    234
735.643463:    260    141    234
735.652648:    260    142    234
735.661865:    261    142    234
735.671081:    262    141    234
735.680267:    263    141    234
735.689453:    264    140    234
735.698669:    265    139    234
735.707885:    266    139    234
735.717102:    267    138    234
735.726318:    268    138    234
735.735534:    268    138    234
735.744751:    269    137    234
735.762725:    269    137    234
735.771942:    270    137    234
735.790344:    270    136    234
735.799560:    270    136    234
735.808746:    270    136    234
735.817962:    270    136    234
735.845611:    270    136    234
735.910217:    270    136    234
735.919403:    270    136    234
735.928588:    271    136    234
735.937866:    271    136    234
735.947082:    271    136    234
735.955871:    271    136    234
735.974334:    271    136    234
735.983551:    270    136    234
736.001220:    270    136    234
736.010467:    270    136    234
736.047302:    270    136    234
736.056488:    270    136    234
736.074951:    270    137    234
736.093383:    269    137    234
736.102600:    269    137      0

Or 36 samples in 0.486695  seconds -> ~74 samples per second with an
average/deviation that is much more acceptable.

This is completely reproducible.

Any ideas why firing up the SMSC911x driver would cause
hrtimer_nanosleep() to be much more predictable?

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
