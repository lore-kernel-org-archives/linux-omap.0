From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Mon, 2 Jul 2012 10:04:12 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A1BEC@DBDE01.ent.ti.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
 <20120627145844.GL3483@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
 <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A0D32@DBDE01.ent.ti.com>
 <4FEDB889.5010503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33286 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932836Ab2GBKEg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 06:04:36 -0400
In-Reply-To: <4FEDB889.5010503@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Fri, Jun 29, 2012 at 19:45:37, Hunter, Jon wrote:
> On 06/29/2012 01:15 AM, Mohammed, Afzal wrote:

> > I have a different opinion, even with the existing code, with the default
> > timings for onenand, Numonyx is working in async mode, reason being that
> > frequency is being obtained with read operation executed in async mode
> > (later based on this frequency, code calculates sync timings & then set
> > to sync mode)
> 
> I don't follow "frequency is being obtained with read operation executed
> in async mode". Can you give a code reference?

In the present code, for sync mode, omap2_onenand_set_sync_mode() invokes
omap2_onenand_set_async_mode() initially, to set onenand & gpmc to async mode,
then invokes omap2_onenand_get_freq() to get frequency, here finding out
frequency from onenand is done by reading relevant onenand register
in async mode.

Regards
Afzal
