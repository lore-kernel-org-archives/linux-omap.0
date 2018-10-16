From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: omap5: dwc3 interface status in /sys
Date: Tue, 16 Oct 2018 11:29:53 +0200
Message-ID: <33FDF48F-4B64-4CE4-BC95-43BAB70B6C37@goldelico.com>
References: <5ECC1431-E758-41E6-B751-D336A94433FA@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5ECC1431-E758-41E6-B751-D336A94433FA@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 17.09.2018 um 10:24 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi Felipe,
> I have made otg mode work on the omap5-uevm with help from Roger
> and now I wonder how to read the interface status for GUI display.
>=20
> On omap3/twl4030 systems we can simply read
>=20
> 	/sys/bus/platform/devices/musb-hdrc.0.auto/mode
>=20
> and get reports e.g. "b_peripheral", "a_host", "b_idle" etc. which can =
easily
> be translated into icons for GUI display.
>=20
> We have not found a similar attribute for dwc3 (except part of this =
information
> in
>=20
> 	/sys/kernel/debug/4a030000.dwc3
>=20
> but mounting debugfs for GUI purposes isn't a good idea).
>=20
> So do you think it is possible to provide such information to
>=20
> 	=
/sys/devices/platform/44000000.ocp/4a020000.omap_dwc3/4a030000.dwc3?

any suggestions?

BR and thanks,
Nikolaus=
