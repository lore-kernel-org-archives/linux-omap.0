From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: PM: fix PM regression introduced by recent
 clock cleanup
Date: Wed, 10 Apr 2013 20:09:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304102007030.25123@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302122026530.29149@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46858 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935970Ab3DJUJb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 16:09:31 -0400
In-Reply-To: <alpine.DEB.2.00.1302122026530.29149@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, j-keerthy@ti.com, b-cousson@ti.com

On Tue, 12 Feb 2013, Paul Walmsley wrote:

> First, I missed the retention entry failure in the branch test logs:
> 
> http://www.pwsan.com/omap/testlogs/cleanup_a_3.9/20130126014242/pm/4460pandaes/4460pandaes_log.txt

Just a brief note.  For the past few -rc releases, have switched here to 
using scripts that parse the PM result logs, for PM validation.

The scripts are probably not perfect, but they're less likely to miss the 
cases they're set up to test.


- Paul
