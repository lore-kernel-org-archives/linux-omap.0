From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2 RFC]OMAP3430: hwmod FW for GPIO
Date: Fri, 12 Feb 2010 15:00:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002121455470.28188@utopia.booyaka.com>
References: <1265981968-14696-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60254 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803Ab0BLWAr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 17:00:47 -0500
In-Reply-To: <1265981968-14696-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com

By the way:

On Fri, 12 Feb 2010, Varadarajan, Charulatha wrote:

> They are boot tested on SDP 3430 and compile tested
> for OMAP 2420 and 2430.

This part is really offensively misleading.  It does not matter whether 
the code has been compile-tested on OMAP24xx if it could never actually 
run on OMAP24xx.


- Paul
