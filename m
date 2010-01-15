From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] OMAP: hwmod: add read/write API for SYSCONFIG
Date: Fri, 15 Jan 2010 10:08:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001151008290.9529@utopia.booyaka.com>
References: <1262993213-19866-1-git-send-email-khilman@deeprootsystems.com> <1262993213-19866-2-git-send-email-khilman@deeprootsystems.com> <1262993213-19866-3-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.1001131822440.4769@utopia.booyaka.com>
 <877hrk5if9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40751 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481Ab0AORIz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 12:08:55 -0500
In-Reply-To: <877hrk5if9.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Thu, 14 Jan 2010, Kevin Hilman wrote:

> Turns out I needed more than just smart-idle enable/disable.  There
> are UART errata that also require force-idle (when DMA is in use.)
> 
> So, instead I added an API for simply setting slave idle mode (patch
> below.)

Thanks Kevin, queued for 2.6.34.


- Paul
