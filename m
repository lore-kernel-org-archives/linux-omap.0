From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] DSS fixes for v3.2-rc2
Date: Tue, 29 Nov 2011 14:51:18 +0000
Message-ID: <201111291451.19081.arnd@arndb.de>
References: <20111123235542.GL31337@atomide.com> <201111241606.54879.arnd@arndb.de> <1322554347.1869.6.camel@deskari>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56061 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab1K2OvY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Nov 2011 09:51:24 -0500
In-Reply-To: <1322554347.1869.6.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tuesday 29 November 2011, Tomi Valkeinen wrote:
> I don't think we need these in 3.1 stable. The omapdss driver in 3.1
> contains hacks to circumvent the HWMOD issues the patches below fix.
> These hacks were removed for 3.2.
> 
> Well, the "ARM: OMAP2PLUS: DSS: Ensure DSS works correctly..." patch
> could be used for 3.1 also, but I fear it depends on HWMOD and DSS
> patches missing from 3.1. I'll check it out.

Ok, thanks for taking a look,

	Arnd
