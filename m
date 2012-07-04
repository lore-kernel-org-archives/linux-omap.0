From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V3 0/5] ARM: OMAP: TLL driver implementation for USB host
 driver
Date: Wed, 4 Jul 2012 01:25:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040123500.6760@utopia.booyaka.com>
References: <1341241305-414-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35926 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932567Ab2GDHZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 03:25:25 -0400
In-Reply-To: <1341241305-414-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com, b-cousson@ti.com, sshtylyov@mvista.com, tony@atomide.com

Hi

On Mon, 2 Jul 2012, Keshava Munegowda wrote:

> The TLL is an has independent hardware mod structure for in OMAP3 and 
> later chips, hence an dedicated platform driver is created.

This sentence doesn't parse.  Try something simpler like "the TLL is an 
separate IP block, independent of the host controller, that basically acts 
as a USB PHY".  Otherwise it's impossible for other people to understand 
what this IP block does.


- Paul
