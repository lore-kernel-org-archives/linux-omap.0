From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 16/17] OMAP2,3: DSS2: Use platform device to get
 baseaddr
Date: Mon, 10 Jan 2011 12:53:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101101251130.5731@utopia.booyaka.com>
References: <1294370351-8654-1-git-send-email-sumit.semwal@ti.com> <1294370351-8654-17-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36825 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab1AJTxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 14:53:17 -0500
In-Reply-To: <1294370351-8654-17-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

On Fri, 7 Jan 2011, Sumit Semwal wrote:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> DSS, DISPC, DSI, RFBI, VENC baseaddr can be obtained from platform_get_resource().
> This API in turn picks the right silicon baseaddr from the hwmod database.
> So hardcoding of base addr could be removed.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>

Great to have the hardcoded addresses gone.


- Paul
