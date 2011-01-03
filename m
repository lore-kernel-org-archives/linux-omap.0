From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/6] Add infrastructure for conditional code and data
 sections
Date: Sun, 2 Jan 2011 20:37:25 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101022033100.29630@utopia.booyaka.com>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com> <1292955604-8809-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42201 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab1ACDh1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Jan 2011 22:37:27 -0500
In-Reply-To: <1292955604-8809-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, aaro.koskinen@nokia.com, Thomas Petazzoni <tpetazzoni@ti.com>, Thomas Petazzoni <t-petazzoni@ti.com>

Hello Thomas

On Tue, 21 Dec 2010, Thomas Petazzoni wrote:

> WARNING: This is only a proof-of-concept, there are many known
> issues. The sole purpose of this patch is to get some feedback on
> whether the idea is useful or not, and whether it's worth cleaning up
> the remaining issues.

As Aaron and Tony commented, I too think this is really good.

I note in your examples that you use "omap2" rather than splitting 2420 
and 2430.  It seems like it would be a good idea to deallocate 2420 data 
structures when booting on 2430, and vice versa.  e.g.,

#define __omap2420_data cond_data_section(omap2420)
#define __omap2430_data cond_data_section(omap2430)

What do you think?


- Paul
