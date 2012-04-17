From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 11/12] ARM: OMAP1: DMTIMER: fix broken timer clock
 source selection
Date: Tue, 17 Apr 2012 15:53:09 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204171552360.29048@utopia.booyaka.com>
References: <20120411003454.27059.37500.stgit@dusk> <20120411003559.27059.1315.stgit@dusk> <20120417214802.GH21106@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32867 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab2DQVxK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Apr 2012 17:53:10 -0400
In-Reply-To: <20120417214802.GH21106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

On Tue, 17 Apr 2012, Tony Lindgren wrote:

> Uhh looks like this was caused by commit 97933d6 (ARM: OMAP1: dmtimer: conversion
> to platform devices) moving code and changing it :(
> 
> I'll pick this to fixes.

Sounds good, will drop this from my series and send a new pull request.


- Paul
