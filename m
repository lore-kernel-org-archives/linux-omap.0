From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/12] OMAP4: PRCM: Add SCRM header file
Date: Tue, 14 Dec 2010 18:17:32 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012141816380.15971@utopia.booyaka.com>
References: <20101214063308.21555.76050.stgit@twilight.localdomain> <20101214063447.21555.64470.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53516 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153Ab0LOBRd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 20:17:33 -0500
In-Reply-To: <20101214063447.21555.64470.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Mon, 13 Dec 2010, Paul Walmsley wrote:

> From: Benoit Cousson <b-cousson@ti.com>
> 
> Add the header file with scrm registers absolute address, offset
> and bitfields.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

This patch has been moved to the earlier 'pwrdm_prcm_a_2.6.38' series.  
Also the base address macro name has been changed from OMAP4_SCRM to 
OMAP4_SCRM_BASE.


- Paul
