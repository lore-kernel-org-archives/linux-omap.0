From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Tue, 26 Jun 2012 08:29:33 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99F002@DBDE01.ent.ti.com>
References: <cover.1340354985.git.afzal@ti.com>
 <7a14edf83068261d8c07217873d14fe7f73975bc.1340354986.git.afzal@ti.com>
 <4FE88DDE.60601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38810 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757191Ab2FZIaF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 04:30:05 -0400
In-Reply-To: <4FE88DDE.60601@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Mon, Jun 25, 2012 at 21:42:14, Hunter, Jon wrote:
> On 06/22/2012 04:01 AM, Afzal Mohammed wrote:

> > +static int hf, vhf, sync_read, sync_write, latency;
> 
> I am wondering if we can remove hf, vhf, sync_read/write variables
> completely. We already have flags from sync_read/write and so we could
> just use the cfg->flags variable and remove sync_read/write variables.

For default frequency, sync_write can get turned off, so flag may or
may not be same as sync_write

> 
> At the same time, we could create flags for ONENAND_FREQ_HF and
> ONENAND_FREQ_VHF or something like that. It could be nice to store the
> latency in onenand_data too. In other words, keep all the configuration
> in one place.

I have a feeling as though platform data fields should not be altered once
platform device is registered (as platform data being specific to the
board, thinking further, should they be const?, except for a case
where it is created by a common helper function for multiple boards with
varying capabilities of peripheral).

Other than sync_read, all others like hf, vhf, latency, sync_write are
updated during driver callback, so if we are going to put these in
platform private data fields, platform private data fields has to be
updated after platform device is registered.

Regards
Afzal
