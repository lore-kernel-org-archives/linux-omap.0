From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: regression: twl4030 audio/clock stopped working in v4.16
Date: Wed, 4 Apr 2018 20:29:49 +0200
Message-ID: <2E644641-82D1-40AB-B878-06066C91AC7A@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Peter,
I just noticed a problem in v4.16 kernels with twl4030 audio and vibra =
driver no longer working.

Tracing it back shows that it already did appear in v4.16-rc1 and wasn't =
fixed up to v4.16.0.
Kernel v4.15.9 (the latest one where I have a binary) works.

The symptoms are:

[    1.557342] twl4030-audio 48070000.i2c:twl@48:audio: Invalid =
audio_mclk
[    1.564788] twl4030-audio: probe of 48070000.i2c:twl@48:audio failed =
with error -22
[    1.839141] TWL4030: HFCLK is not configured

Those are not visible in v4.15.9. And I am not aware of any changes to =
the gta04 device tree.

Do you know about this issue and a fix, before I start to bisect?

BR and thanks,
Nikolaus
