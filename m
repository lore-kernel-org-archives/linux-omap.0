From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: dma_alloc_coherent fragmentation
Date: Wed, 18 Mar 2009 19:24:42 +0000
Message-ID: <20090318192442.GB30132@n2100.arm.linux.org.uk>
References: <DFEF307E035C8647B119E6A60DB62D4A01793E6773@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43058 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760596AbZCRTY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 15:24:58 -0400
Content-Disposition: inline
In-Reply-To: <DFEF307E035C8647B119E6A60DB62D4A01793E6773@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kamat, Nishant" <nskamat@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "2ameya@gmail.com" <2ameya@gmail.com>

On Wed, Mar 18, 2009 at 08:03:45AM -0500, Kamat, Nishant wrote:
> Forwarding on behalf of Nishanth Menon:

Make sure you're up to date with fixes to the ioremap code, specifically
24f11ec001920f1cfaeeed8e8b55725d900bbb56.  This is not in 2.6.28,
2.6.29-rc1, 2.6.29-rc2, but is in -rc3 and later.  2.6.29 itself hasn't
been released yet so I don't know what "seems to happen on 2.6.28 and
2.6.29" actually means because its nonsense.

So, please test with 2.6.29-rc3 or later.
