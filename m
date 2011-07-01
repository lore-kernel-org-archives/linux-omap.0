From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Overo: remove duplicate call to
 overo_ads7846_init()
Date: Fri, 1 Jul 2011 00:30:20 -0700
Message-ID: <20110701073020.GE23145@atomide.com>
References: <87r56sbg3b.fsf@ti.com>
 <1308327432-31177-1-git-send-email-zonque@gmail.com>
 <87lix0b2dr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:62454 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755201Ab1GAHaY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 03:30:24 -0400
Content-Disposition: inline
In-Reply-To: <87lix0b2dr.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Daniel Mack <zonque@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@ti.com> [110617 13:54]:
> Daniel Mack <zonque@gmail.com> writes:
> 
> > overo_ads7846_init() is already called from overo_spi_init(), and
> > calling it twice is not only unnecessary but causes a warning as
> > "reg-fixed-voltage.1" is already added to the device tree.
> 
> Excellent, thanks!
> 
> > Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> Tested-by: Kevin Hilman <khilman@ti.com>
> 

Applying into devel-fixes.

Tony
