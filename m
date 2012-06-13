From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 06/14] ARM: OMAP2+: gpmc: CS configuration helper
Date: Wed, 13 Jun 2012 05:35:00 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998800@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <9dd458171d6a68ea4f97a4ba19dbacc0d6b5ba35.1339419492.git.afzal@ti.com>
 <4FD66666.8060002@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997F1F@DBDE01.ent.ti.com>
 <4FD78519.2080409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50683 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109Ab2FMFfO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 01:35:14 -0400
In-Reply-To: <4FD78519.2080409@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, Jun 12, 2012 at 23:36:17, Hunter, Jon wrote:

> Well it is unclear what the code flow is for using this helper as this
> change simply adds the helper. If someone other function is writing to
> the CONFIG1 register before this function, then you may wish to
> highlight the programming sequence in the changelog or at least describe
> why this function performs a read-modify-write and not just a write.

Logic followed here: CS configuration helper needs to worry only about
bits that are relevant for CS configuration and don't alter any other
bits/registers.

Same is applicable for time setting helper.

Regards
Afzal
