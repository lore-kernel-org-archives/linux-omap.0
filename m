From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH] OMAP2xxx EAC: fix build breakage due to recent IO
 changes
Date: Thu, 4 Sep 2008 23:21:34 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809042321110.25143@utopia.booyaka.com>
References: <alpine.DEB.1.00.0809042237470.25143@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34306 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbYIEFVf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 01:21:35 -0400
In-Reply-To: <alpine.DEB.1.00.0809042237470.25143@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Thu, 4 Sep 2008, Paul Walmsley wrote:

> Commit f228a725b975832ac5771ab2fc86d06bd694cdb3 breaks the build for this
> driver; fix by using OMAP2_IO_ADDRESS.

eh, never mind this patch, this is the wrong way to fix it.  Updated patch 
coming shortly.


- Paul
