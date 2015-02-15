From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Enabling DBGEN signal in GP OMAP3
Date: Sun, 15 Feb 2015 23:30:25 +0200
Message-ID: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:52011 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbbBOVa1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Feb 2015 16:30:27 -0500
Received: by mail-lb0-f177.google.com with SMTP id z11so23981317lbi.8
        for <linux-omap@vger.kernel.org>; Sun, 15 Feb 2015 13:30:25 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

Hi,

Does anyone know if there is a way to make DBGEN signal high on
OMAP3530 and/or DM3730 without using a hardware debugger? My goal is
to make use of hardware watchpoints in Cortex-A8, but that requires
DBGEN to be high.

The TRM states:
"The DBGEM signal on the Cortex-A8 is driven by setting bit 13 at
address 0x5401 D030 in the DAP-APB address space."
However regardless of how hard I try the writes to that register seem
to be ignored. I even tried to do it from IVA/C64x with no success.
(I assume DBGEM is a typo since Cortex-A8 manuals have no mention of
it, and they meant DBGEN there).

It seems others had this problem too, and TI is as helpful as ever:
http://e2e.ti.com/support/dsp/omap_applications_processors/f/447/p/3001=
1/104527

DBGEN is mentioned by Will Deacon's commit
8954bb0da99b76c7ce5edf2f314807cff68b6ea8 , but I guess he mixed NIDEN
with DBGEN there (DBGAUTHSTATUS returns 0x000000ae so NIDEN is indeed
set here, and I have tried old kernel where OMAP3_EMU was still
available).

0x5401D030 is referenced by some OpenOCD scripts, so I guess it's
writeable over jtag, but not by the CPU(s). It's quite a mysterious
otherwise undocumented register, I've noticed it's bit21 is some
status bit related to Cortex-A8's low power states.


Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
