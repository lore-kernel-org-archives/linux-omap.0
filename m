From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] omap3: zoom2/3: make MMC slot work again
Date: Fri, 4 Dec 2009 15:37:30 -0600
Message-ID: <20091204213730.GA26790@lixom.net>
References: <1258551550-25301-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:59550 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757233AbZLDVfH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Dec 2009 16:35:07 -0500
Content-Disposition: inline
In-Reply-To: <1258551550-25301-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Wed, Nov 18, 2009 at 07:09:10PM +0530, Anand Gadiyar wrote:
> omap3: zoom2/3: make MMC slot work again
> 
> Commit 12f8dfb56 accidentally broke MMC on zoom2/3.
> The .vmmc1 field of zoom_twldata was deleted. Restoring it
> allows the MMC slot to work again

Hmm. This was posted 2 weeks ago and not applied yet. Tony?

It regresses zoom2/3.

Patchwork link: http://patchwork.kernel.org/patch/61013/


-Olof

