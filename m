From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Mon, 16 Feb 2015 19:43:24 +0100
Message-ID: <CAALWOA86U3+FTauR+RhGc=sr5TQcdM-UnPsZp+hTWB+Y3Q=eYg@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:53835 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbbBPSnp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2015 13:43:45 -0500
Received: by mail-wg0-f47.google.com with SMTP id x12so17351769wgg.6
        for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2015 10:43:44 -0800 (PST)
In-Reply-To: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

I don't have an OMAP3 to play with, but I wouldn't be surprised if a
debug-enable bit also needs to be set in an ICEPick control register.
On omap4-generation targets with ICEPick-D (e.g. dm81xx and am335x)
the DBGEN signal is in fact fully controlled via ICEPick.

This really sucks since without it you can't use debug monitor
functionality such as hardware breakpoints and watchpoints, or have an
aux core (e.g. a cortex-m3) perform halting debug on the main core.
I've actually considered asking for a hardware patch on our board to
allow it to self-jtag via gpio just to enable that stupid bit
(basically everything else is memory-mapped).

(As a random note, on the am335x the JTAG pins have pinconf registers,
in that case it may suffice to externally pull/drive all pins up and
then toggle the RXEN bit in software, given that even the (warm) reset
pin responds to such manipulation.)
