From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/4] OMAP2xxx clock/CPUFreq: fix compilation errors;
 clean up
Date: Tue, 5 Jan 2010 11:22:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001051121140.2083@utopia.booyaka.com>
References: <20100105173347.15485.42853.stgit@localhost.localdomain> <20100105180659.GD12378@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42189 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148Ab0AESWO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 13:22:14 -0500
In-Reply-To: <20100105180659.GD12378@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, 5 Jan 2010, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [100105 09:35]:
> > Hello,
> > 
> > This series fixes several compilation errors for OMAP2xxx chips when
> > CONFIG_CPU_FREQ is set.  These were reported and partially fixed
> > by Felipe Balbi <felipe.balbi@nokia.com>.
> > 
> > Considerable work is still needed to fully support dynamic frequency
> > changes on OMAP2xxx-series chips.  Readers interested in such a
> > project are encouraged to review the Maemo Diablo RX-34 and RX-44
> > kernel source at:
> > 
> >     http://repository.maemo.org/pool/diablo/free/k/kernel-source-diablo/
> > 
> > Boot-tested on N800 with n8x0_defconfig with CONFIG_CPU_FREQ; compile-tested
> > for 2430SDP.
> > 
> > This second version also incorporates some comments from Felipe.
> 
> These look good to me, can you please send them one more time with
> LAKML Cc'd for a quick review there?

Yes, I plan to send them there along with some other queued fixes for 
another .33-rc fixes series.


- Paul
