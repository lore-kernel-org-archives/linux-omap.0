From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] OMAP2/3 clock: fix some bugs in
	omap2_clk_wait_ready()
Date: Thu, 26 Jun 2008 16:44:07 +0300
Message-ID: <20080626134407.GK12992@atomide.com>
References: <20080626070305.16555.96759.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57050 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760081AbYFZNoR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 09:44:17 -0400
Content-Disposition: inline
In-Reply-To: <20080626070305.16555.96759.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, gadiyar@ti.com, k.kooi@student.utwente.nl, dirk.behme@googlemail.com, igor.stoppa@nokia.com, r-woodruff2@ti.com, jouni.hogander@nokia.comD

* Paul Walmsley <paul@pwsan.com> [080626 10:12]:
> This patch series fixes some bugs in omap2_clk_wait_ready().  This function
> waits for an OMAP module to become ready after both its functional and
> interface clocks are enabled.  Not all OMAP modules support this process.
> 
> In particular, this series:
> 
> - does some minor code cleanup,
> 
> - waits for DSS to become available on OMAP3430ES2+,
> 
> - waits for SSI to become available on OMAP3430ES2+,
> 
> - and adds a test for the OMAP2 portion of the code to verify that the
>   clocks it tests for are in the CORE powerdomain.
> 
> These patches are possible due to the efforts of several people; credits
> are listed in the individual patch descriptions.
> 
> Boot-tested on 3430SDP ES2 and 2430SDP.  

Pushing this series today.

Tony

> 
> 
> - Paul
> 
> 
> ---
> 
> size:
>    text    data     bss     dec     hex filename
> 3391246  156920  107144 3655310  37c68e vmlinux.3430sdp.orig
> 3391374  156920  107144 3655438  37c70e vmlinux.3430sdp.fixed
> 
>  arch/arm/mach-omap2/clock.c           |   79 ++++++++++++++++++++++++++-------
>  arch/arm/mach-omap2/cm-regbits-34xx.h |    7 ++-
>  2 files changed, 67 insertions(+), 19 deletions(-)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
