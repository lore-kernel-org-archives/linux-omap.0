From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/9] OMAP: HWMOD: DSS patches
Date: Sun, 28 Aug 2011 00:12:54 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108280010070.23968@utopia.booyaka.com>
References: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40787 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab1H1GMz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Aug 2011 02:12:55 -0400
In-Reply-To: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tomi,

thanks for cleaning up the commit messages and reposting these so quickly.

On Tue, 23 Aug 2011, Tomi Valkeinen wrote:

> These are the previously sent HWMOD patches split into smaller pieces and with
> improved commit messages.
> 
> I'm not sure if these are strictly needed to be sent for -rc. The DSS patches
> 9ede365aa6f74428a1f69c21ca1cf21213167576 ("HACK: OMAP: DSS2: clk hack for
> OMAP2/3") and df5d3ed23cf73ee0763a8963003bda9b69d9620f ("OMAP: DSS2: HDMI: fix
> hdmi clock name") already circumvent the problems with wrong clocks, and the
> DSS reset problem on OMAP4 hasn't caused any actual runtime problems as far as
> I know.

Sounds like we should wait until 3.2 for these.  The series has been 
queued for 3.2 in the branch 'hwmod_dss_fixes_3.2' of the 
git://git.pwsan.com/linux-2.6 repository.


- Paul
