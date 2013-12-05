From: Olof Johansson <olof@lixom.net>
Subject: [HACK] remotely powering on a OMAP5 uEVM over the debug port
Date: Thu, 5 Dec 2013 09:56:25 -0800
Message-ID: <20131205175625.GA15019@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:60269 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757338Ab3LER6k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 12:58:40 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so26366529pbb.31
        for <linux-omap@vger.kernel.org>; Thu, 05 Dec 2013 09:58:39 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: olof@lixom.net

Here's a tiny hack I came up with to remote-power on an OMAP5 uEVM. I
have mine in an unattended setup where I can cycle power, but it still
needs a power button press to start.

Luckily two GPIO lines on the secondary FTDI channel are routed to the same
buttons, so it can be done via software. It requires your board to have U37
populated though, so make sure you have it (mine did already).

The below little hack uses libmpsse, available at
https://code.google.com/p/libmpsse/.

To use it, give it the path of the FTDI device. I.e. on my system the uEVM is
at 3-1.3.3. Check dmesg and lsusb (it's bus number + path).


Anyway, I figured this could be useful for others as well, so I'm posting just
for that purpose. No warranties, don't come to me if you break your board with
this, etc, etc.



This pulses the power button for 1 second (GPIOH5). If you want to pulse
the reset instead, use GPIOH6.


#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <usb.h>
#include <mpsse.h>

void usage(char *p)
{
	printf("Usage: %s <busnr>-<devpath>\n", p);
}

void fill_busdev(char *usbpath, int *bus, int *dev)
{
	char udir[PATH_MAX+1];
	FILE *fp;

	sprintf(udir, "/sys/bus/usb/devices/%s/busnum", usbpath);
	
	fp = fopen(udir, "r");
	if (!fp) {
		printf("can't open %s to find usb info\n", udir);
		exit(1);
	}
	fscanf(fp, "%d", bus);
	fclose(fp);

	sprintf(udir, "/sys/bus/usb/devices/%s/devnum", usbpath);
	
	fp = fopen(udir, "r");
	if (!fp) {
		printf("can't open %s to find usb info\n", udir);
		exit(1);
	}
	fscanf(fp, "%d", dev);
	fclose(fp);

}
int main(int argc, char **argv)
{
	struct mpsse_context *io = NULL;
	int i = 0;
	int bus, dev;

	if (argc < 1) {
		usage(argv[0]);
		exit(1);
	}

	fill_busdev(argv[1], &bus, &dev);

	while (1) {
		struct usb_device *ud;
		io = OpenIndex(0x0403, 0x6010, GPIO, 0, 0, 2, NULL, NULL, i++);
		if (!io || !io->open) {
			printf("Failed to open device %s\n", argv[1]);
			exit(1);
		}
		ud = usb_device(io->ftdi.usb_dev);
		if (ud->devnum == dev && ud->bus->location == bus) {
			printf("found: %s/%s %d\n", ud->bus->dirname, ud->filename, ud->bus->location);
			break;
		} else {
			printf("skipped: %s/%s %d\n", ud->bus->dirname, ud->filename, ud->bus->location);
		}
		Close(io);
	}

	/* Default is high */
	PinHigh(io, GPIOH5);
	PinHigh(io, GPIOH6);

	sleep(1);
	/* Pulse power */
	PinLow(io, GPIOH5);
	sleep(1);
	PinHigh(io, GPIOH5);

	Close(io);

	exit(0);
}
