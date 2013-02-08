From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
Date: Fri, 8 Feb 2013 04:18:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302080417370.8539@utopia.booyaka.com>
References: <1359966525-7603-1-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.00.1302080248550.8539@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46902 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756979Ab3BHESj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Feb 2013 23:18:39 -0500
In-Reply-To: <alpine.DEB.2.00.1302080248550.8539@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 8 Feb 2013, Paul Walmsley wrote:

> I had to update your patch to apply it on top of the other clock cleanups
> that are already going in for 3.9.  Also the 'omap_clocks_register_links()'
> function name was changed.  Please let me know if you have any comments.

N.B., just noticed there were some checkpatch problems (other that
80-column issues) and a few extraneous blank lines in that modified
patch.  Those have been corrected.

- Paul
