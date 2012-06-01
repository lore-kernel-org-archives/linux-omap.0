From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC 00/24] Move OMAP2+ over to use COMMON clock
Date: Fri, 1 Jun 2012 15:37:45 -0500
Message-ID: <4FC92819.7040504@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47831 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751Ab2FAUhy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 16:37:54 -0400
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Rajendra, Paul,

On 06/01/2012 07:07 AM, Rajendra Nayak wrote:
> Hi,
> 
> This RFC series is based of Mikes' latest clk-next. I will
> rebase it once 3.5-rc1 is out and post with more testing thats
> in progress. Meanwhile, the RFC is for me to get some early
> feedback on the patches.
> 
> This series retains the static clock declarations and also
> all data and code in mach-omap folders and does not move
> it as yet to drivers/clk. I know its desierable that we move
> away from static declaration of data and move over to drivers/clk
> but thats not addressed by this series.
> Also the series moves over only OMAP2+ (OMAP2/3/4)
> to use COMMON clk and leaves OMAP1 still using OMAP
> clock framework.

I had wanted to move the file mach-omap2/clkt_sel.c into
plat-omap/clkt_sel.c so that this could be used by omap1. The reason for
doing this is to fix clock configuration for dmtimers, which right now
is complete broken. I have posted a series here [1], however, it appears
that patch #1 to move clkt_sel.c never made it to the mailing list :-(

Looking at this series, all the functions on clkt_sel.c have been
converted to the clock common framework and so this will probably no
longer work for omap1. So there are possibly a couple solutions ...

1. Move omap1 to the common clock framework (I am sure this would be
preferred but a lot more work).
2. Duplicate the appropriate functions from the current clkt_sel.c in an
equivalent file in mach-omap1.

[1] http://marc.info/?l=linux-omap&m=133771799505501&w=2

Cheers
Jon
