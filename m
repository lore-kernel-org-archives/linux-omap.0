From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] ARM: OMAP2+: hwmod: Hook-up am33xx support in omap_hwmod
 framework
Date: Wed, 4 Jul 2012 03:29:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040329120.6760@utopia.booyaka.com>
References: <1340898256-22884-1-git-send-email-hvaibhav@ti.com> <79CD15C6BA57404B839C016229A409A83EA624A5@DBDE01.ent.ti.com> <alpine.DEB.2.00.1207040311400.6760@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA6334A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51167 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2GDJ3p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 05:29:45 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA6334A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

On Wed, 4 Jul 2012, Hiremath, Vaibhav wrote:

> Yes it does, and was expecting it to go along with Kevin's series.

The AM33xx patch isn't a cleanup -- it adds new functionality -- so it 
doesn't belong as part of a cleanup series.


- Paul
