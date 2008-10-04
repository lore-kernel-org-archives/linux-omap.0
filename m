From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/5] ARM: OMAP: Allocate McBSP devices dynamically
Date: Sat, 4 Oct 2008 15:33:16 +0100
Message-ID: <20081004143316.GB16636@flint.arm.linux.org.uk>
References: <1222262955-13599-1-git-send-email-tony@atomide.com> <1222262955-13599-2-git-send-email-tony@atomide.com> <1222262955-13599-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48933 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbYJDOda (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Oct 2008 10:33:30 -0400
Content-Disposition: inline
In-Reply-To: <1222262955-13599-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Chandra Shekhar <x0044955@ti.com>

On Wed, Sep 24, 2008 at 04:29:12PM +0300, Tony Lindgren wrote:
> From: Chandra Shekhar <x0044955@ti.com>
> 
> Based on Chandra's earlier patches in linux-omap tree.
> 
> Note that omap1_mcbsp_check and omap2_mcbsp_check are no longer
> needed as there's now omap_mcbsp_check_valid_id() defined.
> 
> Also some functions can now be marked __init.
> 
> Signed-off-by: Chandra Shekhar <x0044955@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Ok.
