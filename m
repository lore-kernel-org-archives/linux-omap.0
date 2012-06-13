From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 05/14] ARM: OMAP2+: gpmc: resource creation helpers
Date: Wed, 13 Jun 2012 05:29:31 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9987E3@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <3b124fd254f5700187a2ec5a423271a7296e0510.1339419492.git.afzal@ti.com>
 <4FD65BA5.4020205@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997EE1@DBDE01.ent.ti.com>
 <4FD7841D.1000202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55992 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab2FMF3k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 01:29:40 -0400
In-Reply-To: <4FD7841D.1000202@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, Jun 12, 2012 at 23:32:05, Hunter, Jon wrote:

> Well looking at the function it seems that you either return an error
> code or 1. So if you are never going to return anything other than 1 on
> success it may as well be 0.

Irq & memory resource creation functions returns number of resources,
if memory function only is modified, that will cause loss of uniformity
w.r.t irq function, even though both does similar things.

Regards
Afzal
