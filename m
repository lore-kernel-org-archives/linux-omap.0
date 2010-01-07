From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV4 0/4] OMAP3630 Clock changes
Date: Thu, 7 Jan 2010 14:57:48 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001071456570.6759@utopia.booyaka.com>
References: <1262849801-9955-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53496 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab0AGV5t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 16:57:49 -0500
In-Reply-To: <1262849801-9955-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 7 Jan 2010, Vishwanath BS wrote:

> THis patch series has Clock changes related to OMAP3630. The major Clock releated changes are 
> 1. DPLL4 type has changed to j type. 
> 2. Frequency Selection (FREQSEL) is no longer required for 3630 
> 3. CLKSEL field width is increased for DPLL4 M2, M3, M4, M5 and M6 
> 4. DPLL4 M2 o/p can be either 96MHz or 192 Mhz (to support SGX@192). 

One other thought: consider crediting Eduardo's review comments 
when you repost the patches...


- Paul
