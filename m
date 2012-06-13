From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/11] ARM: OMAP: core/hwmod: first set of fixes for
 3.5-rc
Date: Wed, 13 Jun 2012 17:55:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206131755130.30212@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk> <1339162255.2091.56.camel@sokoban>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60862 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112Ab2FMXzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 19:55:48 -0400
In-Reply-To: <1339162255.2091.56.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

Hi Tero,

On Fri, 8 Jun 2012, Tero Kristo wrote:

> Tested this set on top of v3.5-rc1 with omap3 / omap4 suspend + my omap4
> core retention / dev-off patches. There are a couple of minor issues,
> like the bug in patch 5, and the fact that counter_32k hwmod data is
> broken for omap4. This fix is needed on omap4 to fix the counter_32k, if
> this is not done, device off does not work:

Thanks for the testing and the reminder.  Will send the next version of 
this soon to address more comments from Tony.


- Paul
