From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: hwmod: Adding flag to prevent caching of sysconfig
 register.
Date: Tue, 5 Jan 2010 17:32:23 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001051730230.21295@utopia.booyaka.com>
References: <1260098674-27143-1-git-send-email-thara@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E171@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46659 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab0AFAcY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 19:32:24 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E171@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 23 Dec 2009, Gopinath, Thara wrote:

> Hi Paul,Kevin.. Does this patch look ok?

Hello Thara,

looking over this patch.  Nice job on the descriptive patch comment; 
it explains the problem well.  What do you think about a slightly 
different approach -- that is, to add a hook to the hwmod code to 
invalidate the cache if the module's powerdomain has lost context?


- Paul
