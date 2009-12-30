From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH] OMAP2: add USB platform data and initialization for Nokia N800 and N810
Date: Wed, 30 Dec 2009 09:17:11 +0200
Message-ID: <87pr5xvslk.fsf@purkki.valot.fi>
References: <200912290152.16357.luke@dashjr.org>
	<873a2uxip9.fsf@purkki.valot.fi> <200912291505.51230.luke@dashjr.org>
	<200912292110.42122.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751763AbZL3HRQ@vger.kernel.org>
In-Reply-To: <200912292110.42122.luke@dashjr.org> (Luke-Jr's message of "Tue\, 29 Dec 2009 21\:10\:27 -0600")
Sender: linux-kernel-owner@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

"Luke-Jr" <luke@dashjr.org> writes:

> On that topic, is there a reason the newer code is under a unified "N8x0" 
> config option instead of the split N800/N810 that was used for the old code, 
> or is that simply a symptom of the currently-supported features all being 
> common?

IIRC, I just used one common n8x0 file because the n810 board file was
very small and I didn't see any benefit from having it separately.

-- 
Kalle Valo
