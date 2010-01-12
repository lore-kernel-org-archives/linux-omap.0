From: "Hemanth V" <hemanthv@ti.com>
Subject: Error while using OMAP_DMA_SYNC_FRAME
Date: Tue, 12 Jan 2010 14:47:37 +0530 (IST)
Message-ID: <3733.10.24.255.18.1263287857.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41098 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab0ALJRi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 04:17:38 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0C9Hc3K031052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 03:17:38 -0600
Received: from dbdmail.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o0C9HZH1029827
	for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 03:17:37 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,

 I have been trying to use Frame sync for DMA on l-o tree, which is basically
useful when peripherals have built-in fifo and DMA synchronization happens for
the configured number on elements.

I am seeing the error "DMA synchronization event drop occurred with device".
Anyone else seen this error or have any inputs.

Thanks
Hemanth

