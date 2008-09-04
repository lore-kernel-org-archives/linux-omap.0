From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc5-omap1] rtc-twl4030 cleanup
Date: Thu, 4 Sep 2008 10:48:46 -0700
Message-ID: <200809041048.46177.david-b@pacbell.net>
References: <200809041024.18572.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:43043 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752122AbYIDRst (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 13:48:49 -0400
In-Reply-To: <200809041024.18572.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Thursday 04 September 2008, David Brownell wrote:
> Update IRQs still misbehave (two per > second, not one!),

Someone with docs will need to sort this one out.  The
appended test program will illustrate the problem; it
was sitting around to help sort out bugs in way x86
"HPET Emulation" reports update IRQs.

Output on twl4030 is like:

Read using select(2) on /dev/rtc0:
    1    0.562852  (+0.358789) 0190
   -3 *  0.563770  (+0.359707) 0190
   -2    1.562741  (+0.358678) 0190
   -6 *  1.563712  (+0.359649) 0190
   -5    2.562825  (+0.358762) 0190
   -9 *  2.563737  (+0.359674) 0190
   -8    3.562817  (+0.358754) 0190
  -12 *  3.563722  (+0.359659) 0190
  -11    4.562975  (+0.358912) 0190
  -15 *  4.563923  (+0.359860) 0190
  -14    5.563039  (+0.358976) 0190
  -18 *  5.564048  (+0.359985) 0190
^C

The "*" indicates bogus IRQ reports ... in this case it
looks like each update IRQ is reported TWICE, with the
second one being about one millisec after the first one.
Since this test waits for five consecutive non-bogus
interrupts, it never stops ...

Note that if you abort the test with an interrupt (as
shown above) you'll want the RTC framework patch from

http://groups.google.com/group/rtc-linux/msg/d18d561014a97807

to shut the update IRQs down.  Or, just run "hwclock"
from util-linux-ng (not busybox!).

- Dave

/* gcc -s -Os -Wall -Wstrict-prototypes uie2.c -o uie2 */

#include <stdio.h>
#include <linux/rtc.h>
#include <sys/ioctl.h>
#include <time.h>
#include <sys/time.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>

/*
 * This expects the new RTC class driver framework, working with
 * clocks that will often not be clones of what the PC-AT had.
 * Use the command line to specify another RTC if you need one.
 */
static const char default_rtc[] = "/dev/rtc0";

int main(int argc, char **argv)
{
	int i, fd, retval, irqcount = 0;
	unsigned long data;
	const char *rtc = default_rtc;
	char *exception;
	struct timeval stv, etv;
	struct timezone tz;
	long sec, usec, old_ticks;

	switch (argc) {
	case 2:
		rtc = argv[1];
		/* FALLTHROUGH */
	case 1:
		break;
	default:
		fprintf(stderr, "usage:  uie2 [rtcdev]\n");
		return 1;
	}

	fd = open(rtc, O_RDONLY);

	if (fd == -1) {
		perror(rtc);
		exit(errno);
	}

	/* Turn on update interrupts (one per second) */
//	gettimeofday(&stv, &tz);
	retval = ioctl(fd, RTC_UIE_ON, 0);
	if (retval == -1) {
		if (errno == ENOTTY) {
			fprintf(stderr, "\n...Update IRQs not supported.\n");
		}
		perror("RTC_UIE_ON ioctl");
		exit(errno);
	}

	fprintf(stderr, "\nRead using select(2) on %s:\n", rtc);
	fflush(stderr);
	old_ticks = -1;
	gettimeofday(&stv, &tz);
	for (i = 1; i < 6; i++) {
		struct timeval tv = { 5, 0 };	/* 5 second timeout on select */
		fd_set readfds;
		long new_ticks, diff;

		FD_ZERO(&readfds);
		FD_SET(fd, &readfds);
		/* The select will wait until an RTC interrupt happens. */
		retval = select(fd + 1, &readfds, NULL, NULL, &tv);
		if (retval == -1) {
			perror("select");
			exit(errno);
		}
		/* This read won't block unlike the select-less case above. */
		retval = read(fd, &data, sizeof(unsigned long));
		if (retval == -1) {
			perror("read");
			exit(errno);
		}
		gettimeofday(&etv, &tz);
		sec = etv.tv_sec - stv.tv_sec;
		usec = etv.tv_usec - stv.tv_usec;
		if (usec < 0) {
			usec += 1000000;
			sec -= 1;
		} else if (usec > 1000000) {
			usec -= 1000000;
			sec++;
		}

		/* what we want to watch for is having a "one-per-second"
		 * update report be more imprecise than the 64 Hz default
		 * of the HPET rtc glue should be able to deliver...
		 */
		new_ticks = (sec * 1000000 + usec) / (1000000 / 64);
		diff = abs(new_ticks - old_ticks);
		if ((old_ticks > 0) && ((diff < 63) || (diff > 65))) {
			exception = "*";
			i -= 5;
		} else
			exception = " ";
		fprintf(stderr, " %4d %s  %ld.%06lu  (+0.%06lu) %04lx\n",
			i, exception, sec, usec, etv.tv_usec, data);
		fflush(stderr);
		old_ticks = new_ticks;
		irqcount++;
	}

	/* Turn off update interrupts */
	retval = ioctl(fd, RTC_UIE_OFF, 0);
	if (retval == -1) {
		perror("RTC_UIE_OFF ioctl");
		exit(errno);
	}

	return 0;
}
