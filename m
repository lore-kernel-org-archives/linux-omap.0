From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 2/4] TI816X: Update common OMAP machine specific
 sources
Date: Wed, 9 Feb 2011 17:48:26 -0800
Message-ID: <20110210014826.GH20795@atomide.com>
References: <1297270570-32492-1-git-send-email-hemantp@ti.com>
 <20110210014557.GG20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47772 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab1BJBs4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 20:48:56 -0500
Content-Disposition: inline
In-Reply-To: <20110210014557.GG20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com

* Tony Lindgren <tony@atomide.com> [110209 17:45]:
> 
> We should just have separate struct map_desc omapti816x_io_desc[] then.
> Maybe have a common struct map_desc omap3_io_desc[] and then separate
> omap3xxx_io_desc and omapti816x_io_desc?

Oh and this will work just fine for map_io without having cpu_is_omap
macros working yet because we call set_globals from the board file with
the processor class data.

Tony
