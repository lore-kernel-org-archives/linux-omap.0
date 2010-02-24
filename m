From: Philip Balister <philip@balister.org>
Subject: DMA example
Date: Wed, 24 Feb 2010 11:34:07 -0800
Message-ID: <4B857F2F.7000201@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:2212 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757736Ab0BXTeM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 14:34:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I am trying to setup a dma operation to copy memory from GPMC address 
space into RAM. The only examples using the omap-dma api use hardware 
triggers.

When I start a transfer, I end up with a DMA transaction error when I 
start the transfer.

Does anyone have a good example of a software transfer? Currently, I am 
tracing the omap dma api to see how things map into the registers ....

Philip
