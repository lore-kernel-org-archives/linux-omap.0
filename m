From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing
 calculation
Date: Mon, 3 Sep 2012 05:34:10 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
References: <cover.1345524670.git.afzal@ti.com>
 <bc000ac53bb1b3ae1a951bbcf372caf6336d2a19.1345524670.git.afzal@ti.com>
 <20120824194630.GU11011@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42366 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab2ICFeU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 01:34:20 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Mon, Aug 27, 2012 at 14:04:44, Mohammed, Afzal wrote:
> On Sat, Aug 25, 2012 at 01:16:30, Tony Lindgren wrote:

> > This hangs n800 during the boot.
> 
> Shall I read the above as n800 boot without patch 10/10,
> but with the other patches in this series ?
> 
> As per the board file, n800 has tusb6010 as well as
> OneNAND in sync read & async write mode, was OneNAND
> working without 10/10.
> 
> Do you have any idea, which timing could have gone wrong,
> can you please sent me DEBUG enabled gpmc log with and
> without 10/10.

Can you please sent me GPMC DEBUG enabled logs with and
without this series.

Regards
Afzal
