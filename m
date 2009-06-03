From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: PM: 2 new entries in SDRC table for Qimonda
 HYB18M512160AF-6
Date: Tue, 2 Jun 2009 18:35:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906021834050.31531@utopia.booyaka.com>
References: <1243855807-31226-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39093 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbZFCAfs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 20:35:48 -0400
In-Reply-To: <1243855807-31226-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Rajendra,

On Mon, 1 Jun 2009, Rajendra Nayak wrote:

> This patch adds 2 more entries for new SDRC clock rates
> (166000000 and 83000000) in the sdrc params table for
> Qimonda HYB18M512160AF-6 sdram part.
> Without this CORE dvfs is broken on the 3430SDP as
> omap2_sdrc_get_params() call in the dvfs sequence
> always return 'rate not found'
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Commit ID c82881eac1c6999abd768c548ad196c1973d3a55 on l-o master has 
resolved this.


- Paul
