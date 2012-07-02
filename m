From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Mon, 2 Jul 2012 09:43:21 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A1BB7@DBDE01.ent.ti.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
 <20120627145844.GL3483@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
 <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com>
 <20120702063651.GO4202@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49401 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932717Ab2GBJnc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 05:43:32 -0400
In-Reply-To: <20120702063651.GO4202@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Mon, Jul 02, 2012 at 12:06:51, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [120628 09:48]:

> > The above change seems to imply that Tony's n900 is dependent on the bootloader settings
> > and not those being set by the kernel. Ideally, we should not need to set the async mode
> > in the onenand before we set the onenand timings in the gpmc (per Afzal's changelog
> > comment). This appears backwards.
> 
> That should not be the case, I'm more likely to believe in Afzal's explanation.

Not sure whether you are fine with fixing up this patch with added diff

Assuming inferences so far is not wrong, right now this patch with the added diff
would be perfectly fine.

Problem would happen when we are at a stage to do gpmc reset using hwmod [seems
miles to go before I sleep {or read gpmc hwmod reset} ;)]. If bootloader left
onenand configured in sync mode, to switch onenand to async mode, first configuring
gpmc to sync mode would be required & for that we need frequency information
from onenand and to get that information from onenand, gpmc has to be configured
for sync mode and to configure gpmc to sync mode ....

Seems like chicken and egg problem.

N900, I believe is board-rx51, could not get proper schematic for onenand
connections, nor do I have the Numonyx datsheet, or the board, hence not
sure whether resetting onenand may resolve the issue. But if you feel that
it is the right solution & it would resolve the issue, and if you can let
me know gpio connected (if any) to onenand reset or else some pointers to
achieving it, I can try making a patch to do onenand reset

Regards
Afzal
