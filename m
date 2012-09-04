From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: remove unused hwmod function prototypes
Date: Tue, 4 Sep 2012 19:24:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209041924280.11516@utopia.booyaka.com>
References: <y> <1346786149-9228-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49761 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757638Ab2IDTYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 15:24:41 -0400
In-Reply-To: <1346786149-9228-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 4 Sep 2012, Igor Grinberg wrote:

> Several hwmod function prototypes appear to not have an implementation
> because the corresponding functions were removed or renamed.
> Those prototypes are unneeded anymore - remove them.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks, queued for 3.7.


- Paul
