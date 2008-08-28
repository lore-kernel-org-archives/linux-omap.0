From: "chandra shekhar" <x0044955@ti.com>
Subject: [PATCH 0/2]  McBSP DMA support for  34xx
Date: Thu, 28 Aug 2008 14:03:03 +0530 (IST)
Message-ID: <57686.192.168.10.89.1219912383.squirrel@dbdmail.itg.ti.com>
References: <51613.192.168.10.89.1219911942.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41819 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYH1IdM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 04:33:12 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7S8X6K9027990
	for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 03:33:11 -0500
In-Reply-To: <51613.192.168.10.89.1219911942.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: chandra shekhar <x0044955@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

Here is a patch that adds dma chaining support for McBSP on 34XX.
It has been verified in digital loopback mode. It
Supports DMA chaining mode and one time configuration for entire
transfer to improve performance. instead of mcbsp client configuring all the
register, it allows clients to  configure parameters like clk polarity, clk src
sample rate. It also supports data transfer in 8,16,32 bit mode. ( 16 and 24
bit stereo and mono ).

Regards,
Chandra Shekhar





