From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] ARM: OMAP3: clock: cleanup AM35xx clock flags
Date: Wed, 2 May 2012 02:24:53 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205020223470.19695@utopia.booyaka.com>
References: <1335828604-18795-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50343 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab2EBIYy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 04:24:54 -0400
In-Reply-To: <1335828604-18795-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 30 Apr 2012, Kevin Hilman wrote:

> Remove all AM35xx specifics from the clock tree and tree and treat all
> AM35xx devices the same.

Thanks, queued for 3.5, and authorship fixed on the third patch as we 
discussed.


- Paul
