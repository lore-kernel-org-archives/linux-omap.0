From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH] OMAP2: add USB platform data and initialization for Nokia N800 and N810
Date: Tue, 29 Dec 2009 21:10:27 -0600
Message-ID: <200912292110.42122.luke@dashjr.org>
References: <200912290152.16357.luke@dashjr.org> <873a2uxip9.fsf@purkki.valot.fi> <200912291505.51230.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752046AbZL3DLF@vger.kernel.org>
In-Reply-To: <200912291505.51230.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 29 December 2009 03:05:46 pm Luke-Jr wrote:
> The last-working N8x0 support (Linux-OMAP 2.6.30-rc8) required 1706 lines
>  of platform data and initialization, split up into 6 files:

Upon trying to debug my non-working keyboard, I learned that the status of 
mainlining is actually worse off than I thought, and my "last 2.6.30-rc8 
working" revision was actually already missing platform data.

It seems logical from looking at the code needed to divide the board into at 
least 5 files (line number estimates based on old code):
	460	board-n8x0-common.c
	175	board-n800.c			(FM radio, touchscreen)
	260	board-n810.c			(keyboard, light sensor, LEDs, touchscreen)
	600	board-n8x0-multimedia.c	(camera, audio, DSP)
	725	board-n8x0-storage.c	(flash, MMC)
	120	board-n8x0-lcd.c

On that topic, is there a reason the newer code is under a unified "N8x0" 
config option instead of the split N800/N810 that was used for the old code, 
or is that simply a symptom of the currently-supported features all being 
common?

Luke
