From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/8] I2C patches for v3.8 merge window
Date: Mon, 22 Oct 2012 17:06:58 +0300
Message-ID: <20121022140658.GA18993@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <20121022133023.GC14033@arwen.pp.htv.fi>
 <CAM=Q2ctS3hxngk5efcvScAdv-2GtH2pHRZoxRhRTiOWmQA-AXw@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36266 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754737Ab2JVOM5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 10:12:57 -0400
Content-Disposition: inline
In-Reply-To: <CAM=Q2ctS3hxngk5efcvScAdv-2GtH2pHRZoxRhRTiOWmQA-AXw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: balbi@ti.com, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, ben-linux@fluff.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

--SkvwRMAIpAhPCcCJ
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 22, 2012 at 07:36:31PM +0530, Shubhrajyoti Datta wrote:
> On Mon, Oct 22, 2012 at 7:00 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Mon, Oct 22, 2012 at 12:46:50PM +0300, Felipe Balbi wrote:
> >> Hi guys,
> >>
> >> here's another series for OMAP I2C driver. There are a few cleanups
> >> and one very nice new feature: we can now report how many bytes
> >> we transferred until NACK.
> >>
> >> Note that the implemementation for OMAP-I2C turned out to be a
> >> little more complex then I expected, mainly because of the way
> >> I2C_CNT register behaves and because of the very buggy register
> >> usage on that driver.
> >>
> >> I have boot tested all patches on beagle xM (3630) and pandaboard
> >> rev A3 (4430), will send boot-logs if anyone wants to see.
>=20
> tested the below branch on omap4430sdp , panda , omap3430sdp.
>=20
> Doing simple i2ctools
> .
>=20
> Tested-by : Shubhrajyoti D <shubhrajyoti@ti.com>
>=20

can you also check if echo mem > /sys/power/state works ? Don't forget
to enable UART wakeups with:

echo enabled > /sys/devices/platform/omap_uart.2/power/wakeup
echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup

before trying to suspend. Another cool test is rtctest (since our RTC is
part of TWL). It worked fine on my two platforms. Attached you will find
the sourcecode for rtctest.

> >> All patches are available at [1] if anyone wants an easy way to
> >> test the patches.
> >>
> >> [1] git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git i2c-tr=
ansferred-bytes-on-NACK
> >
> > forgot to mention, with [1] I could veridy suspend to ram with boards
> > mentioned above.
> >
> > [1] http://marc.info/?l=3Dlinux-arm-kernel&m=3D135090724817604&w=3D2
> >
> >> Felipe Balbi (7):
> >>   i2c: omap: no need to access platform_device
> >>   i2c: omap: reorder exit path of omap_i2c_xfer_msg()
> >>   i2c: omap: fix error checking
> >>   i2c: omap: also complete() when stat becomes zero
> >>   i2c: omap: introduce and use OMAP_I2C_IP_VERSION_3
> >>   i2c: omap: wait for transfer completion before sending STP bit
> >>   i2c: omap: implement handling for 'transferred' bytes
> >>
> >> Shubhrajyoti D (1):
> >>   i2c: add 'transferred' field to struct i2c_msg
> >>
> >>  arch/arm/mach-omap2/i2c.c                  |   3 +-
> >>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   2 +-
> >>  drivers/i2c/busses/i2c-omap.c              | 156 ++++++++++++++++----=
---------
> >>  include/linux/i2c-omap.h                   |   1 +
> >>  include/uapi/linux/i2c.h                   |   1 +
> >>  5 files changed, 89 insertions(+), 74 deletions(-)
> >>
> >> --
> >> 1.8.0.rc0
> >>
> >
> > --
> > balbi

--=20
balbi

--9jxsPFA5p3P2qPhR
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="rtctest.c"

/*
 *      Real Time Clock Driver Test/Example Program
 *
 *      Compile with:
 *		     gcc -s -Wall -Wstrict-prototypes rtctest.c -o rtctest
 *
 *      Copyright (C) 1996, Paul Gortmaker.
 *
 *      Released under the GNU General Public License, version 2,
 *      included herein by reference.
 *
 */

#include <stdio.h>
#include <linux/rtc.h>
#include <sys/ioctl.h>
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
	unsigned long tmp, data;
	struct rtc_time rtc_tm;
	const char *rtc = default_rtc;

	switch (argc) {
	case 2:
		rtc = argv[1];
		/* FALLTHROUGH */
	case 1:
		break;
	default:
		fprintf(stderr, "usage:  rtctest [rtcdev]\n");
		return 1;
	}

	fd = open(rtc, O_RDONLY);

	if (fd ==  -1) {
		perror(rtc);
		exit(errno);
	}

	fprintf(stderr, "\n\t\t\tRTC Driver Test Example.\n\n");

	/* Turn on update interrupts (one per second) */
	retval = ioctl(fd, RTC_UIE_ON, 0);
	if (retval == -1) {
		if (errno == ENOTTY) {
			fprintf(stderr,
				"\n...Update IRQs not supported.\n");
			goto test_READ;
		}
		perror("RTC_UIE_ON ioctl");
		exit(errno);
	}

	fprintf(stderr, "Counting 5 update (1/sec) interrupts from reading %s:",
			rtc);
	fflush(stderr);
	for (i=1; i<6; i++) {
		/* This read will block */
		retval = read(fd, &data, sizeof(unsigned long));
		if (retval == -1) {
			perror("read");
			exit(errno);
		}
		fprintf(stderr, " %d",i);
		fflush(stderr);
		irqcount++;
	}

	fprintf(stderr, "\nAgain, from using select(2) on /dev/rtc:");
	fflush(stderr);
	for (i=1; i<6; i++) {
		struct timeval tv = {5, 0};     /* 5 second timeout on select */
		fd_set readfds;

		FD_ZERO(&readfds);
		FD_SET(fd, &readfds);
		/* The select will wait until an RTC interrupt happens. */
		retval = select(fd+1, &readfds, NULL, NULL, &tv);
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
		fprintf(stderr, " %d",i);
		fflush(stderr);
		irqcount++;
	}

	/* Turn off update interrupts */
	retval = ioctl(fd, RTC_UIE_OFF, 0);
	if (retval == -1) {
		perror("RTC_UIE_OFF ioctl");
		exit(errno);
	}

test_READ:
	/* Read the RTC time/date */
	retval = ioctl(fd, RTC_RD_TIME, &rtc_tm);
	if (retval == -1) {
		perror("RTC_RD_TIME ioctl");
		exit(errno);
	}

	fprintf(stderr, "\n\nCurrent RTC date/time is %d-%d-%d, %02d:%02d:%02d.\n",
		rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.tm_year + 1900,
		rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);

	/* Set the alarm to 5 sec in the future, and check for rollover */
	rtc_tm.tm_sec += 5;
	if (rtc_tm.tm_sec >= 60) {
		rtc_tm.tm_sec %= 60;
		rtc_tm.tm_min++;
	}
	if (rtc_tm.tm_min == 60) {
		rtc_tm.tm_min = 0;
		rtc_tm.tm_hour++;
	}
	if (rtc_tm.tm_hour == 24)
		rtc_tm.tm_hour = 0;

	retval = ioctl(fd, RTC_ALM_SET, &rtc_tm);
	if (retval == -1) {
		if (errno == ENOTTY) {
			fprintf(stderr,
				"\n...Alarm IRQs not supported.\n");
			goto test_PIE;
		}
		perror("RTC_ALM_SET ioctl");
		exit(errno);
	}

	/* Read the current alarm settings */
	retval = ioctl(fd, RTC_ALM_READ, &rtc_tm);
	if (retval == -1) {
		perror("RTC_ALM_READ ioctl");
		exit(errno);
	}

	fprintf(stderr, "Alarm time now set to %02d:%02d:%02d.\n",
		rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);

	/* Enable alarm interrupts */
	retval = ioctl(fd, RTC_AIE_ON, 0);
	if (retval == -1) {
		perror("RTC_AIE_ON ioctl");
		exit(errno);
	}

	fprintf(stderr, "Waiting 5 seconds for alarm...");
	fflush(stderr);
	/* This blocks until the alarm ring causes an interrupt */
	retval = read(fd, &data, sizeof(unsigned long));
	if (retval == -1) {
		perror("read");
		exit(errno);
	}
	irqcount++;
	fprintf(stderr, " okay. Alarm rang.\n");

	/* Disable alarm interrupts */
	retval = ioctl(fd, RTC_AIE_OFF, 0);
	if (retval == -1) {
		perror("RTC_AIE_OFF ioctl");
		exit(errno);
	}

test_PIE:
	/* Read periodic IRQ rate */
	retval = ioctl(fd, RTC_IRQP_READ, &tmp);
	if (retval == -1) {
		/* not all RTCs support periodic IRQs */
		if (errno == ENOTTY) {
			fprintf(stderr, "\nNo periodic IRQ support\n");
			goto done;
		}
		perror("RTC_IRQP_READ ioctl");
		exit(errno);
	}
	fprintf(stderr, "\nPeriodic IRQ rate is %ldHz.\n", tmp);

	fprintf(stderr, "Counting 20 interrupts at:");
	fflush(stderr);

	/* The frequencies 128Hz, 256Hz, ... 8192Hz are only allowed for root. */
	for (tmp=2; tmp<=64; tmp*=2) {

		retval = ioctl(fd, RTC_IRQP_SET, tmp);
		if (retval == -1) {
			/* not all RTCs can change their periodic IRQ rate */
			if (errno == ENOTTY) {
				fprintf(stderr,
					"\n...Periodic IRQ rate is fixed\n");
				goto done;
			}
			perror("RTC_IRQP_SET ioctl");
			exit(errno);
		}

		fprintf(stderr, "\n%ldHz:\t", tmp);
		fflush(stderr);

		/* Enable periodic interrupts */
		retval = ioctl(fd, RTC_PIE_ON, 0);
		if (retval == -1) {
			perror("RTC_PIE_ON ioctl");
			exit(errno);
		}

		for (i=1; i<21; i++) {
			/* This blocks */
			retval = read(fd, &data, sizeof(unsigned long));
			if (retval == -1) {
				perror("read");
				exit(errno);
			}
			fprintf(stderr, " %d",i);
			fflush(stderr);
			irqcount++;
		}

		/* Disable periodic interrupts */
		retval = ioctl(fd, RTC_PIE_OFF, 0);
		if (retval == -1) {
			perror("RTC_PIE_OFF ioctl");
			exit(errno);
		}
	}

done:
	fprintf(stderr, "\n\n\t\t\t *** Test complete ***\n");

	close(fd);

	return 0;
}

--9jxsPFA5p3P2qPhR--

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhVMCAAoJEIaOsuA1yqREDeIP/iqMW3LwcpogT0j7ZTvh+Urn
iqhsbD390R/5lRprXtYOpiZJB7NlvyXWVPdNMIY7qW2ch3EQVixM9HgmuvodakUs
ZhtKW+lgGDywigoqVWMsDHsnVZap8mtlq1hD9c4mdK0/LWcgn1PvRIF0gZOz9fgq
ZdS2/MmNMRwFKz9wtGXc5znqNCfVnUPGNHN4kN37pdMliooObBOEbRYitylXyY6d
LCkZS97cYrbWCVMwF2XUsV1q6fLsbHz4u3XMzc2dZHvxslWvV8mTaREndWh5YowG
fL6t4jiBW5/It2jZeHR5JNR0MTmkrF//QlQD1o5vQyJQw+8xMLH55sxn3WwNji3H
w/DA1VVE8m3l68YPrK61M2nkp+XaFaECxyUt+3jSS/4RkMx2/tirCIoNosqnsdpg
9Stqt2if1qe1nq5Q0qGzedpoM9VSImW4Kh++Pid+NFTh00/xIPc5ZRRWJHjAXyqD
MykDIUxcf9hBboGd5no5MvyeUFvpdeeWo44uZpuzJvtSb5ZOJWAErZp+OZZi8BR4
Kh49AQgpCHBPIZrcaTO9GHtBQCUyXUYiaYUcinoGbGqa7dj4zAaMQbDMShsAb9CF
8we5ajFDXhDjimFp3jX1ET5c6h3H1hNOvqxizGbYXA4cgy7rXIwaxkIeLdb2JATq
hoNsTcgUDPx0K7a3T6gY
=St6a
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
