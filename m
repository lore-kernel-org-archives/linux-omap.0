From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 07/14] ARM: OMAP2+: gpmc: time setting (register#)
 helper
Date: Wed, 13 Jun 2012 06:15:38 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998872@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <aafc6bc498e303be0bc86ce1ae395148fdca5c3d.1339419492.git.afzal@ti.com>
 <4FD7909B.4040304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42884 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab2FMGQA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 02:16:00 -0400
In-Reply-To: <4FD7909B.4040304@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Wed, Jun 13, 2012 at 00:25:23, Hunter, Jon wrote:

> When are the timings calculated? Why not just use the existing
> gpmc_cs_set_timings()?
> 
> I guess I am not convinced that we need to have multiple formats to pass
> timings such as clock, period, etc.
> 
> I think that it is sufficient to pass the timings as time (period) as is
> currently done and have the driver convert to clocks based upon the gpmc
> fclk rate.

Please see http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69041.html

Regards
Afzal
