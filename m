From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH] OMAP2+: remove unused UART base addresses from
 omap_globals
Date: Tue, 25 Jan 2011 05:32:05 +0530
Message-ID: <20110125000205.GB6351@manju-desktop>
References: <1295649015-26348-1-git-send-email-khilman@ti.com>
 <20110124064154.GA16582@m-desktop>
 <20110124074520.GB16582@m-desktop>
 <87wrlu6k8l.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35332 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751895Ab1AYACa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 19:02:30 -0500
Received: by mail-gy0-f180.google.com with SMTP id 6so1555039gya.39
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 16:02:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87wrlu6k8l.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 24, 2011 at 01:54:18PM -0800, Kevin Hilman wrote:
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > We need additional changes for removing these macros since omap2+ till
> > omap3 hwmod uart db is not using dma request lines in omap4 way.
> 
> Feel free to send the DMA changes as an additional patch.  This is
> independent of my changes, so can be a separate patch.
No problem. I have cleanup changes for other drivers also so I can merge these
changes.

-Manjunath
[...]
