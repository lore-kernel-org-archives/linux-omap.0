From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH] OMAP2: add USB platform data and initialization for Nokia N800 and N810
Date: Wed, 30 Dec 2009 03:02:23 -0600
Message-ID: <200912300302.29725.luke@dashjr.org>
References: <200912290152.16357.luke@dashjr.org> <200912292110.42122.luke@dashjr.org> <87pr5xvslk.fsf@purkki.valot.fi>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752506AbZL3JDG@vger.kernel.org>
In-Reply-To: <87pr5xvslk.fsf@purkki.valot.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 30 December 2009 01:17:11 am Kalle Valo wrote:
> "Luke-Jr" <luke@dashjr.org> writes:
> > On that topic, is there a reason the newer code is under a unified "N8x0"
> > config option instead of the split N800/N810 that was used for the old
> > code, or is that simply a symptom of the currently-supported features all
> > being common?
> 
> IIRC, I just used one common n8x0 file because the n810 board file was
> very small and I didn't see any benefit from having it separately.

Yeah, that's because someone put all the N810 code in the N800 file ;)

Will probably at least split out the differences, if there's no other reason, 
then. Since I'm doing this stuff only for my own personal interest, I'll 
probably not bother to do much with N800 support unless someone feels like 
sending me one when I finish N810 (definitely not touching N800 before then).

Luke
