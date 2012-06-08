From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/11] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Fri, 8 Jun 2012 17:18:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206081717150.17523@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk>  <20120607061309.25532.13430.stgit@dusk> <1339161773.2091.49.camel@sokoban>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53624 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760334Ab2FHXSU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 19:18:20 -0400
In-Reply-To: <1339161773.2091.49.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On Fri, 8 Jun 2012, Tero Kristo wrote:

> There's a bug in this patch, see below.

...

> There should by binary or, not logical here.

Thanks for reporting this, I've added some credit in the patch 
description.  This has been fixed by switching back to using a flag-based 
approach based on some comments from Vaibhav Hiremath.


- Paul
