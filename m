From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v2 0/2] DSS2:Allow FB to build without VRFB
Date: Fri, 14 May 2010 15:56:38 +0300
Message-ID: <1273841798.2814.80.camel@tubuntu.research.nokia.com>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com>
	 <1273821814.2814.63.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703042887DB@dbde02.ent.ti.com>
	 <AA4B1310-2BA5-411E-A7EA-AAE03F41CCF3@student.utwente.nl>
	 <4BED2CD9.9000303@ti.com>
	 <5FC7083E-FFD9-4297-AC5D-522FBCBF11F0@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41806 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575Ab0ENM4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 08:56:47 -0400
In-Reply-To: <5FC7083E-FFD9-4297-AC5D-522FBCBF11F0@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Koen Kooi <koen@dominion.thruhere.net>
Cc: Nishanth Menon <nm@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Fri, 2010-05-14 at 13:18 +0200, ext Koen Kooi wrote:
> Op 14 mei 2010, om 12:58 heeft Nishanth Menon het volgende geschreven:

> > But why use bootargs?
> 
> Because (for some unknown reason) you can't toggle vrfb at runtime. If you realize you need rotation you need to reboot. I guess it's because the memory layout for vrfb is completely different, but again, I'm not a kernel hacker :)
> 

You can. There's rotate_type in the framebuffer sysfs directory. But I
think you need to release memories etc before that, and reallocate after
changing the rotation type.

 Tomi


