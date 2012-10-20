From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/5] ARM: OMAP2+: powerdomain/PRM: move the low-level
 powerdomain functions into PRM
Date: Sat, 20 Oct 2012 17:50:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210201747550.27264@utopia.booyaka.com>
References: <20121015224455.18306.89030.stgit@dusk.lan> <20121015230542.18306.88940.stgit@dusk.lan> <507FAAD7.6030209@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53724 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460Ab2JTRuU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 13:50:20 -0400
In-Reply-To: <507FAAD7.6030209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, russ.dill@ti.com, santosh.shilimkar@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>


Hi Rajendra, Russ, Santosh,

thanks for your Reviewed-bys and acks and comments.  Have folded them into 
the series here.  Russ, the file headers have been updated per your 
comments.  Also while there, the copyrights from the 
{clock,power}domainxxxx.c files were copied in, along with Rajendra's 
authorship line.


- Paul
