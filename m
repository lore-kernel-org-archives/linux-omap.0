From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Wed, 27 Jun 2012 06:53:57 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99F8B7@DBDE01.ent.ti.com>
References: <cover.1340354985.git.afzal@ti.com>
 <7a14edf83068261d8c07217873d14fe7f73975bc.1340354986.git.afzal@ti.com>
 <4FE88DDE.60601@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99F002@DBDE01.ent.ti.com>
 <4FE9C98B.2020003@ti.com> <4FE9CDA8.40208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51887 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180Ab2F0GyE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 02:54:04 -0400
In-Reply-To: <4FE9CDA8.40208@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, Jun 26, 2012 at 20:26:40, Hunter, Jon wrote:
> On 06/26/2012 09:39 AM, Jon Hunter wrote:

> > a single global variable called onenand_flags for storing the current
> > state of sync_read, sync_write, vhf and hf. At least this would be only
> > one global instead of 4. Not a big deal.

V5 has been posted with above changes

> Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Thanks
Afzal
