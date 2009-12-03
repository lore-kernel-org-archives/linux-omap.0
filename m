From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2] OMAP3: PM: Fix for MPU power domain MEM BANK
 position
Date: Thu, 3 Dec 2009 05:38:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912030538260.13408@utopia.booyaka.com>
References: <1259234087-10030-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57746 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbZLCMic (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 07:38:32 -0500
In-Reply-To: <1259234087-10030-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Thu, 26 Nov 2009, Thara Gopinath wrote:

> MPU power domain bank 0 bits are displayed in position of bank 1
> in PWRSTS and PREPWRSTS registers. So read them from correct
> position
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Thanks Thara, will queue this up.

- Paul
