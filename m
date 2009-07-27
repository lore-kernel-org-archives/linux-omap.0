From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 32/32] ARM: OMAP: RX51: set MMC capabilities and
 power-saving flag
Date: Mon, 27 Jul 2009 11:14:48 -0700
Message-ID: <20090727111448.89e79b55.akpm@linux-foundation.org>
References: <20090710124004.1262.10422.sendpatchset@ahunter-tower>
	<20090710124353.1262.22788.sendpatchset@ahunter-tower>
	<20090725235329.GE12665@console-pimps.org>
	<4A6D5E40.7030608@nokia.com>
	<20090727082721.GG12665@console-pimps.org>
	<4A6D6C2E.6060306@nokia.com>
	<20090727091511.GH12665@console-pimps.org>
	<20090727102111.GI12665@console-pimps.org>
	<4A6D8957.7040706@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754041AbZG0SPa@vger.kernel.org>
In-Reply-To: <4A6D8957.7040706@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Matt Fleming <matt@console-pimps.org>, lkml <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 27 Jul 2009 14:02:47 +0300 Adrian Hunter <adrian.hunter@nokia.com> wrote:

> Matt Fleming wrote:
> > On Mon, Jul 27, 2009 at 10:15:11AM +0100, Matt Fleming wrote:
> >> On Mon, Jul 27, 2009 at 11:58:22AM +0300, Adrian Hunter wrote:
> >>> Yes much nicer.  Will you add it to your patch?
> >> Sure, I'll reply with an updated patch to 07/32 of this series.
> >>
> >> Thanks Adrian.
> > 
> > OK, slight problem. If I change omap_hsmmc.c in 07/32 you'll need to
> > respin all your patches from [PATCH 08/32] onwards. Is that OK with you?
> 
> I'd like to know what Andrew wants to do, as these patches are in mm tree.
> 
> In the past I have seen him ask for changes to be patched on top, rather than
> make a new patch.
> 
> Otherwise I am happy to redo the patch set.

Respinning the patchset produces the nicest result, but if it's just a
matter of one modest fixup patch to be applied after the 32-patch
series then I don't think it'll kill anyone.
