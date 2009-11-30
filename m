From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV2 0/4] OMAP3: Clock changes for OMAP3630
Date: Mon, 30 Nov 2009 02:31:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911300230140.17083@utopia.booyaka.com>
References: <1259211517-12713-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53455 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbZK3Jbm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 04:31:42 -0500
In-Reply-To: <1259211517-12713-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Vishwanath,

On Thu, 26 Nov 2009, Vishwanath BS wrote:

> This patch set introduces clock changes for OMAP3630. Major changes in 
> OMAP3630 w.r.t clock are 1. Introduction of j type dpll4 2. CLKSEL filed 
> width is increased by 1 bit for DPLL4M3, M4, M5 and M6 3. SGX can be run 
> at 192Mhz

You might also want to mention that there are several other new clock 
changes on 3630 that will need to be implemented after this series...

- Paul
