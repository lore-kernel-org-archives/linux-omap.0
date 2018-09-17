From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: omap5: dwc3 interface status in /sys
Date: Mon, 17 Sep 2018 10:24:16 +0200
Message-ID: <5ECC1431-E758-41E6-B751-D336A94433FA@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Roger Quadros <rogerq@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,
I have made otg mode work on the omap5-uevm with help from Roger
and now I wonder how to read the interface status for GUI display.

On omap3/twl4030 systems we can simply read

	/sys/bus/platform/devices/musb-hdrc.0.auto/mode

and get reports e.g. "b_peripheral", "a_host", "b_idle" etc. which can =
easily
be translated into icons for GUI display.

We have not found a similar attribute for dwc3 (except part of this =
information
in

	/sys/kernel/debug/4a030000.dwc3

but mounting debugfs for GUI purposes isn't a good idea).

So do you think it is possible to provide such information to

	=
/sys/devices/platform/44000000.ocp/4a020000.omap_dwc3/4a030000.dwc3?

BR,
Nikolaus
