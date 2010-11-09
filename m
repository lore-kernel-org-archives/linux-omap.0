From: "Taneja, Archit" <archit@ti.com>
Subject: DSS2 Query: Use of FIFO preload values
Date: Tue, 9 Nov 2010 09:50:24 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034BF2DD10@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36862 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078Ab0KIEUf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 23:20:35 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I was going through the DSS2 code and was unable to find a place
where we set the 11th bit in DISPC_GFX_ATTRIBUTES or the 19th bit
in DISPC_VIDn_ATTRIBUTES.

Setting these bits ensures that the DISPC FIFO's fill up to the
high threshold value specified by us instead of the preload values.

Is this done on purpose or it got missed out?

Thanks,

Archit