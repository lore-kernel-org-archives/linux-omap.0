From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] OMAP DSS updates for 2.6.40
Date: Tue, 24 May 2011 12:37:03 +0300
Message-ID: <1306229823.2194.14.camel@deskari>
References: <1306151004.1871.36.camel@deskari>
	 <20110524063803.GC11986@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:36045 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755333Ab1EXJhJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 05:37:09 -0400
In-Reply-To: <20110524063803.GC11986@linux-sh.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: lo-ml <linux-omap@vger.kernel.org>, lfbdev-ml <linux-fbdev@vger.kernel.org>

On Tue, 2011-05-24 at 15:38 +0900, Paul Mundt wrote:
> On Mon, May 23, 2011 at 02:43:24PM +0300, Tomi Valkeinen wrote:
> > Here are the OMAP Display Subsystem updates for 2.6.40.
> > 
> > Most of the patches are OMAP4 related, either fixing the old code to
> > allow us to implement new OMAP4 features, or implementing those new
> > features. Other bigger changes are ULPS power management feature and
> > moving the DSS header file from arch/arm/plat-omap/include to
> > include/video.
> > 
> Pulled and pushed out, thanks. There were a couple of conflicts, so you
> may want to doublecheck to make sure nothing was inadvertently broken.

I wonder where those conflicts came from...

I think this pull request never made into the 39 rcs:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg48334.html

I should have checked it, but it seems I've missed those. So you had
those patches in fbdev tree, and I had the same patches in my
development tree (which ended up being rebased a bit), and this led to
those conflicts.

But diff between omapdss in my master branch and fbdev master is null,
so the conflicts were resolved correctly.

 Tomi


