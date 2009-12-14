From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: Clock: Fixed dpll3_m2x2 rate calculation
Date: Mon, 14 Dec 2009 14:28:10 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912141427430.12561@utopia.booyaka.com>
References: <> <1256729890-21920-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39649 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756792AbZLNV2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 16:28:12 -0500
In-Reply-To: <1256729890-21920-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

On Wed, 28 Oct 2009, Tero Kristo wrote:

> From: Tero Kristo <tero.kristo@nokia.com>
> 
> Current calculation does not take into account any changes to M2 divisor, and
> thus when we change VDD2 OPP, dpll3_m2x2 rate does not change. Fixed by
> re-routing dpll3_m2x2 parent to dpll3_m2.
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

For the archives: this was merged as 
72f962fc7bc00f5ff4991912b889f87b464f7f1a.


- Paul
