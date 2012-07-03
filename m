From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Tue, 3 Jul 2012 04:35:37 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A22B7@DBDE01.ent.ti.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
 <20120627145844.GL3483@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
 <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com>
 <20120702063651.GO4202@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A1BB7@DBDE01.ent.ti.com>
 <4FF1DA5F.9000409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55380 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab2GCEfu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jul 2012 00:35:50 -0400
In-Reply-To: <4FF1DA5F.9000409@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Mon, Jul 02, 2012 at 22:59:03, Hunter, Jon wrote:
> On 07/02/2012 04:43 AM, Mohammed, Afzal wrote:

> > Not sure whether you are fine with fixing up this patch with added diff
> > 
> > Assuming inferences so far is not wrong, right now this patch with the added diff
> > would be perfectly fine.
> > 
> > Problem would happen when we are at a stage to do gpmc reset using hwmod [seems
> > miles to go before I sleep {or read gpmc hwmod reset} ;)]. If bootloader left
> > onenand configured in sync mode, to switch onenand to async mode, first configuring
> > gpmc to sync mode would be required & for that we need frequency information
> > from onenand and to get that information from onenand, gpmc has to be configured
> > for sync mode and to configure gpmc to sync mode ....
> 
> You are concerned about hwmod performing a reset of the gpmc during
> boot? We should be able to use the HWMOD_INIT_NO_RESET flag to prevent
> this. Would that work?

Yes that will work in the short term, the reason I am trying to avoid no
reset flag in the long term is to prevent this board support being broken,
please refer Paul's requirement [1] in accepting gpmc hwmod patch

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69041.html

