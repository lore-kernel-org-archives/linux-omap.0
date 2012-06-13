From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 04/14] ARM: OMAP2+: gpmc: minimal driver support
Date: Wed, 13 Jun 2012 13:50:40 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998F1E@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <54e643eb1b4dbefcbb52580fa582043bf4f0da3d.1339419492.git.afzal@ti.com>
 <4FD6586A.9060706@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997E2A@DBDE01.ent.ti.com>
 <4FD782F7.9010003@ti.com> <20120613120717.GP12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998E43@DBDE01.ent.ti.com>
 <20120613134032.GW12766@atomide.com> <20120613134408.GY12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56132 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436Ab2FMNu4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 09:50:56 -0400
In-Reply-To: <20120613134408.GY12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Wed, Jun 13, 2012 at 19:14:08, Tony Lindgren wrote:

> Actually why do you even need to store the revision? You can
> just read it from the hardware as needed.

Earlier for wr_access & wr_data_mux_bus, we were checking,
cpu_is_34xx, but I feel it should instead be based on
IP revision as it is the IP revision that decides the
availability of those register bits.

Regards
Afzal
