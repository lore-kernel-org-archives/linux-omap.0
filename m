From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 0/12] dmtimer adaptation to platform_driver
Date: Mon, 13 Dec 2010 23:45:55 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012132344350.15971@utopia.booyaka.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38276 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab0LNGp4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 01:45:56 -0500
In-Reply-To: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 7 Dec 2010, Tarun Kanti DebBarma wrote:

> Tested on following platforms:
> OMAP4430, OMAP3430, OMAP3630, OMAP2430
> OMAP2420 -- Image with omap2plus_defconfig in too large to download on N800.

Just build a minimal N800 config for testing.  It's really quite easy.  
Use 'make menuconfig' and then you can remove lots of unnecessary stuff.


- Paul
