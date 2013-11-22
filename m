From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: Help needed to force USB host mode on AM335x CPU
Date: Fri, 22 Nov 2013 14:28:50 +0000
Message-ID: <528F6A22.2070906@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 217-155-41-104.dsl.in-addr.zen.co.uk ([217.155.41.104]:42693
	"EHLO centos1.newflow.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755339Ab3KVO2v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Nov 2013 09:28:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

We have a custom AM335x board where the USB0_ID pin has been left floating.

By default, this puts the USB controller into peripheral mode, but we need
to force it into host mode.

This can be achieved in s/w by setting some bits in the relevant USB mode
register (see TRM 16.5.2.35).

This mode register's offset is already defined in musb_dsps.c

static const struct dsps_musb_wrapper am33xx_driver_data = {
...
	.mode			= 0xe8,
...
};

I can manually set this register to the correct value in musb_host.c and
the USB all seems to work as expected.

int musb_host_setup(struct musb *musb, int power_budget)
{
	int ret;
	struct usb_hcd *hcd = musb->hcd;

/* Force HOST mode */
unsigned long __iomem *p;
p = ioremap(0x474010e8, 4);
*p = 0x80;	/* IDDIG = 0, IDDIG_MUX = 1 */

	MUSB_HST_MODE(musb);
...
};

Ideally I'd like to add an entry in my dts file to flag for this "force mode"
to be setup, such as:-

usb@47401000 {
	status = "okay";
	dr_mode = "host";
	ti,force-host;		/* force host mode */
};

Can anyone point me in the right direction as to where to put this extra code ?

I see there's a musb_am335x.c file, but that just seems to be a wrapper.

Any help would be greatly apperciated.

Regards
Mark J.
