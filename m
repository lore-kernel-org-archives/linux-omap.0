From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Please fix lcd_sx1.c
Date: Sun, 23 Nov 2008 16:57:48 +0000
Message-ID: <20081123165748.GC17438@flint.arm.linux.org.uk>
References: <20081123164618.GA17438@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59380 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYKWQ54 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Nov 2008 11:57:56 -0500
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1L4IHP-0007zr-NW
	for linux-omap@vger.kernel.org; Sun, 23 Nov 2008 16:57:52 +0000
Content-Disposition: inline
In-Reply-To: <20081123164618.GA17438@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Nov 23, 2008 at 04:46:18PM +0000, Russell King - ARM Linux wrote:
> To me, it looks like this driver was tossed over into mainline without
> any thought - it has never been in a buildable state.  Please fix or
> remove this driver from mainline.

Actually, it was buildable, until this commit:

commit b4b58f5834a023dab67201db9a626bef07bb200c
Author: Chandra Shekhar <x0044955@ti.com>
Date:   Wed Oct 8 10:01:39 2008 +0300

    ARM: OMAP: Allocate McBSP devices dynamically
    
    Based on Chandra's earlier patches in linux-omap tree.
    
    Note that omap1_mcbsp_check and omap2_mcbsp_check are no longer
    needed as there's now omap_mcbsp_check_valid_id() defined.
    
    Also some functions can now be marked __init.
    
    Signed-off-by: Chandra Shekhar <x0044955@ti.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

which means it's a regression and therefore needs fixing before 2.6.28.
