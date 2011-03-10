From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 1/2] OMAP3: cpuidle: prevent CORE power domain from going
 to RET or OFF when DSS is on
Date: Thu, 10 Mar 2011 03:17:32 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100315550.15132@utopia.booyaka.com>
References: <20110301220833.32613.54669.stgit@twilight.localdomain> <20110301224918.32613.95176.stgit@twilight.localdomain> <87pqq7pz27.fsf@ti.com> <854C6400F5AA6644BA6FE7953F3E769B0380F12F@008-AM1MPN1-013.mgdnok.nokia.com> <87lj0uj048.fsf@ti.com>
 <854C6400F5AA6644BA6FE7953F3E769B0380FE45@008-AM1MPN1-013.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39670 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab1CJKRd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 05:17:33 -0500
In-Reply-To: <854C6400F5AA6644BA6FE7953F3E769B0380FE45@008-AM1MPN1-013.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tero,

On Mon, 7 Mar 2011, Tero.Kristo@nokia.com wrote:

> What is the current status with those idlest patches anyway?

They aren't completed yet, so they won't make it into 2.6.39.  I hope to 
get them in early in 2.6.40.


- Paul
