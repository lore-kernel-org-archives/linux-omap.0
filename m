From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] staging: tidspbridge: fix an erroneous removal of
 parentheses
Date: Thu, 26 Jun 2014 21:09:46 -0400
Message-ID: <20140627010946.GA19029@kroah.com>
References: <1403587467-59876-1-git-send-email-s-anna@ti.com>
 <1403587467-59876-2-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36255 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbaF0ESu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2014 00:18:50 -0400
Content-Disposition: inline
In-Reply-To: <1403587467-59876-2-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Aybuke Ozdemir <aybuke.147@gmail.com>, Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>

On Tue, Jun 24, 2014 at 12:24:25AM -0500, Suman Anna wrote:
> Commit 4a9fdbb (staging: core: tiomap3430.c Fix line over 80 characters.)
> erroneously removed the parentheses around the function pointer leading
> to the following build error (when enabling the build of TI DSP/Bridge
> driver):
> 
> drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_monitor':
> drivers/staging/tidspbridge/core/tiomap3430.c:283:10: error: invalid type argument of unary '*' (have 'u32')
> make[3]: *** [drivers/staging/tidspbridge/core/tiomap3430.o] Error 1
> 
> Fix this build error properly.

This shows that no one really uses this driver :(

Can't we just delete the thing?

I'll go queue this up for 3.16-final, thanks.

greg k-h
