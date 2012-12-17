From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: invalid references to vram.h
Date: Mon, 17 Dec 2012 17:13:08 -0600
Message-ID: <50CFA704.3000201@ti.com>
References: <50CF9957.6030105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49968 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab2LQXNJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 18:13:09 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id qBHND9Sx026797
	for <linux-omap@vger.kernel.org>; Mon, 17 Dec 2012 17:13:09 -0600
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qBHND93t030176
	for <linux-omap@vger.kernel.org>; Mon, 17 Dec 2012 17:13:09 -0600
In-Reply-To: <50CF9957.6030105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Hernandez <ceh@ti.com>
Cc: linux-omap@vger.kernel.org


On 12/17/2012 04:14 PM, Carlos Hernandez wrote:
> Just an fyi... am335x mainline compilation is broken due to invalid
> references to vram.h
> 
> |   CC      arch/arm/mach-omap2/common.o
> | arch/arm/mach-omap2/common.c:19:23: fatal error: plat/vram.h: No such
> file or directory
> 
> Test run against commit fa4c95bfdb85d568ae327d57aa33a4f55bab79c4

I believe a fix is already queued [1].

Jon

[1] http://marc.info/?l=linux-omap&m=135577145305783&w=2
