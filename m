From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Query: EHCI clock management approach
Date: Thu, 8 Oct 2009 06:51:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A332A93@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49940 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755279AbZJHBWk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 21:22:40 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi all,

I'd like to post a patch in a couple of days to refactor the EHCI clock
management code. This would be useful to do aggressive clock
management in the idle path.

A current implementation I have is to simply factor out the clock_enable/disable
calls out. Does it make sense to move this out to mach-omap2/* and provide
the function pointer through platform data? Does the driver need to be aware
of the clocks that it needs, or is it sufficient for it to just call a platform-specific
function that turns on/off all the clocks needed by the driver?

The reason I ask is, in a future OMAP, we may need to enable a different set of
clocks, but we should be able to re-use the rest of the code directly.


- Anand
