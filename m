From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: clean up some smatch warnings, fix some
 printk(KERN_ERR ...
Date: Tue, 7 Aug 2012 09:00:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1208070859190.23956@utopia.booyaka.com>
References: <20120807103009.8053.69389.stgit@dusk.lan> <20120807103439.8053.65054.stgit@dusk.lan> <20120807104023.GV11011@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45907 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab2HGPAD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 11:00:03 -0400
In-Reply-To: <20120807104023.GV11011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 7 Aug 2012, Tony Lindgren wrote:

> I think these will cause new randconfig warnings without CONFIG_BUG set.

Thanks for the comment.  Did not know BUG() could be disabled.  Will drop 
those changes.


- Paul
