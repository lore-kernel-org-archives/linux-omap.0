From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 00/14] GPMC driver conversion
Date: Fri, 15 Jun 2012 10:56:00 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99A59D@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998065@DBDE01.ent.ti.com>
 <20120613123305.GS12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58126 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756654Ab2FOK4L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 06:56:11 -0400
In-Reply-To: <20120613123305.GS12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Wed, Jun 13, 2012 at 18:03:05, Tony Lindgren wrote:

> Cool, yeah looks like the old interface almost works. I had to undo the
> new additions for tusb6010 DMA to work as below. Then Jon has some good
> comments. I also made few comments to the GPMC using driver changes.

Thanks and sorry for the trouble it caused you

I will post next version based on the comments

> In general, please keep in mind that eventually we want this to be
> a regular device driver that also works as a loadable module.

Yes, that is my intention, at the end of driver conversion, it should
be able to work as a module.

> 
> And we need the device tree bindings for GPMC so we can start dropping
> board-*.c files as the GPMC seems to be last remaining blocker for
> making rarely used legacy boards DT only. So it might be worth
> playing with that so we don't again have to redo some parts.

We would prefer to do it one step at a time, have driver conversion changes
first in, and then work on DT migration. Once these changes are in we have a
base to work on for further DT migration.

Please let me know your opinion

Regards
Afzal
