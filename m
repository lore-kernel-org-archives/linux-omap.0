From: "Jeff Graham" <Jeff.Graham@brukeroptics.com>
Subject: comm with FTDI usb chip from davinci dm3730 with linux and Arm
Date: Fri, 3 Dec 2010 14:46:21 -0500
Message-ID: <F752F64AD8BC1D42B49B877FEE3CD3490118207B@USTED.BOPTUS.OPTIK.LAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.bruker.com ([173.13.75.234]:18395 "EHLO mx1.bruker.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000Ab0LCUBF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 15:01:05 -0500
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello List,

I am working with my Texas Instruments DM3730 EVM board running its def=
ault Linux kernel 2.6.32 and default Linux distro Arago 2010.05. The cp=
u info is:

Processor       : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 998.84
=46eatures        : swp half thumb fastmult vfp edsp neon vfpv3=20
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0xc08
CPU revision    : 2

Hardware        : OMAP3 EVM
Revision        : 0020
Serial          : 0000000000000000


I need to communicate via USB master to an FTDI Ft245R device that can =
be found here:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 http://www.ftdichip.com/Products/ICs/=
=46T245R.htm

=46or cross-compiling I have the free CodeSourcery G++ Lite 2009q1-203 =
version 4.3.3.


The TI EVM kit has libusb-0.1 already installed. What I *think* I need =
is to just build the package called libftdi that can be found here:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 http://www.intra2net.com/en/developer=
/libftdi/index.php


So my questions are:

1) Has the already-installed libusb-0.1 been tested or used by anyone s=
uccessfully?

2) Has anyone tried anything similar to what I need, most likely using =
some other FTDI chip or with libftdi ?

3) Do you know if the default EVM kernel (2.6.32) and Linux will even c=
ompile libftdi or if it works?

4) I know how to build kernels, so if someone could point me to some ke=
rnel source or patches then I could configure a working kernel.


Thanks!

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
