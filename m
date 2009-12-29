From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH] OMAP2: add USB platform data and initialization for Nokia N800 and N810
Date: Tue, 29 Dec 2009 15:05:46 -0600
Message-ID: <200912291505.51230.luke@dashjr.org>
References: <200912290152.16357.luke@dashjr.org> <200912290246.57663.luke@dashjr.org> <873a2uxip9.fsf@purkki.valot.fi>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752118AbZL2VGK@vger.kernel.org>
In-Reply-To: <873a2uxip9.fsf@purkki.valot.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 29 December 2009 02:55:46 am Kalle Valo wrote:
> Having lots of small files is difficult IMHO.

The last-working N8x0 support (Linux-OMAP 2.6.30-rc8) required 1706 lines of 
platform data and initialization, split up into 6 files:
	590	N800 + i2c + FM + keyboard + light sensor + LED + LCD + temp + SPI + WiFi
		 + touchscreen + OneNAND
	47	N810
	175	USB
	362	MMC
	156	DSP
	376	camera

The largest OMAP2 single-board file is merely 689 lines (3430sdp).
N900/RX-51, totalling 863 lines itself, is split over 2 files.

I think 4 or 5 files with ~350 lines is more manageable than a single 1700-
line board file, especially when considering that parts depend on multiple 
configuration options (LCD, which turns out to be a 128-line file, depends on 
3 config options: N8x0, Blizzard, and MIPID).

Thoughts?

Luke
