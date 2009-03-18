From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: dma_alloc_coherent fragmentation
Date: Wed, 18 Mar 2009 15:08:19 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF643729@dlee02.ent.ti.com>
References: <DFEF307E035C8647B119E6A60DB62D4A01793E6773@dlee02.ent.ti.com>
 <20090318192442.GB30132@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49469 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbZCRUIr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 16:08:47 -0400
In-Reply-To: <20090318192442.GB30132@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Kamat, Nishant" <nskamat@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "2ameya@gmail.com" <2ameya@gmail.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Wednesday, March 18, 2009 9:25 PM
> To: Kamat, Nishant
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; Menon, Nishanth; linux-
> omap@vger.kernel.org; Ramirez Luna, Omar; Kanigeri, Hari; Guzman Lugo,
> Fernando; Kevin Hilman; 2ameya@gmail.com
> Subject: Re: dma_alloc_coherent fragmentation

> Make sure you're up to date with fixes to the ioremap code, specifically
> 24f11ec001920f1cfaeeed8e8b55725d900bbb56.  This is not in 2.6.28,
> 2.6.29-rc1, 2.6.29-rc2, but is in -rc3 and later.  2.6.29 itself hasn't
> been released yet so I don't know what "seems to happen on 2.6.28 and
> 2.6.29" actually means because its nonsense.

Apologies on the confusion.

For this issue, the pertinent tree would be the master branch of [1] linux-omap tree which is synced to 2.6.29-rc8. And yes, the mentioned commit ID is part of the git log.

Relevant test code and report of the crash is in [2]. Additional observation in [3]

Regards,
Nishanth Menon

Ref:
[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git
[2] http://marc.info/?l=linux-omap&m=123719772811746&w=2
[3] http://marc.info/?l=linux-omap&m=123722460022336&w=2
