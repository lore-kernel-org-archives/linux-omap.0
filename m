From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 1/4] OMAP2+: PM: omap device: API's for handling
 mstandby mode
Date: Fri, 6 May 2011 14:24:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1105061423570.30136@utopia.booyaka.com>
References: <1301322422-29886-1-git-send-email-manjugk@ti.com> <1301322422-29886-2-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47348 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500Ab1EFUYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 16:24:41 -0400
In-Reply-To: <1301322422-29886-2-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com

On Mon, 28 Mar 2011, G, Manjunath Kondaiah wrote:

> Certain errata in OMAP2+ processors will require forcing
> master standby to "no standby" mode before completing on going
> operation. Without this, the results will be unpredictable.

Thanks, I've queued this one (provisionally) for 2.6.40, assuming we have 
the diffstat budget for it.


- Paul
