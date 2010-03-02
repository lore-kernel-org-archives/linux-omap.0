From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: prcm: Use logical OR instead of bitwise OR
Date: Tue, 2 Mar 2010 03:39:43 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1003020339250.31238@utopia.booyaka.com>
References: <1267435059-12865-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40828 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab0CBKjo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 05:39:44 -0500
In-Reply-To: <1267435059-12865-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Abhijit Pagare <abhijitpagare@ti.com>

On Mon, 1 Mar 2010, Rajendra Nayak wrote:

> This patch fixes usage of bitwise OR in if conditions, and instead
> uses logical OR.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Abhijit Pagare <abhijitpagare@ti.com>

Thanks, queued for .34-rcX. 


- Paul
