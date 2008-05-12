From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Error displaying commit 4ca958bea8c1d6 in gitweb
Date: Mon, 12 May 2008 18:31:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02224F66E6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56634 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758130AbYELNBb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2008 09:01:31 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "lvcargnini@gmail.com" <lvcargnini@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

I was trying to look at the history of the following file in gitweb:
        <include/asm-arm/arch-omap/mcbsp.h>

It throws a parsing error seemingly because of characters in the above
commit's Author field.

Any chance we can fix this? (I'm not even sure if we should, but if Luis
doesn't mind, maybe we could change it to something displayable).

Regards,
Anand
