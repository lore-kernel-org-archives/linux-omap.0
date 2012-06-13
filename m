From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 14/14] ARM: OMAP2+: gpmc: writeprotect helper
Date: Wed, 13 Jun 2012 06:10:32 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99884F@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <85c5dc5fa3203cc60a12d4b2350e45da07d7f5fd.1339419492.git.afzal@ti.com>
 <4FD78D93.9080906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57941 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649Ab2FMGKm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 02:10:42 -0400
In-Reply-To: <4FD78D93.9080906@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Wed, Jun 13, 2012 at 00:12:27, Hunter, Jon wrote:

> I am still wondering if we should warn against multiple devices using
> the wait pin. I see that if could be valid to have multiple memory
> devices of the same type using the WP pin spanning multiple CS. However,
> in that case would/should the memory devices be registered as a single
> child? If so then we could still impose a policy of only one child
> device using the WP.

Presently there are no peripherals in mainline turning on writeprotect,
initially intention was to just disable writeprotect at the end of probe
and not provide platforms opportunity to enable writeprotect as none
need it, still a provision has been provided for platform to enable it.

Probably these to be taken care when there is a requirement.

Regards
Afzal
