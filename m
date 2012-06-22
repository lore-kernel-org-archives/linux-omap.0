From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/11] mfd: omap-usb: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 13:04:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206221302470.10198@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1340372890-10091-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41844 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762542Ab2FVTET (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 15:04:19 -0400
In-Reply-To: <1340372890-10091-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>, keshava_mgowda@ti.com

On Fri, 22 Jun 2012, Rajendra Nayak wrote:

> In preparation of OMAP moving to Common Clk Framework (CCF) add clk_prepare()
> and clk_unprepare() for the various usb host clocks.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>

Looks like this one will be at least partially obsoleted by this series:

ARM: OMAP: TLL driver implementation for USB host driver
http://marc.info/?l=linux-omap&m=134019432606399&w=2

and the runtime PM conversion in that series needs to be done anyway.


- Paul
