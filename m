From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v6 07/10] ARM: OMAP2+: gpmc: generic timing calculation
Date: Mon, 27 Aug 2012 11:46:02 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9BA684@DBDE01.ent.ti.com>
References: <cover.1345524670.git.afzal@ti.com>
 <83b963e4ebcc1009a26a8c6419c785ac6d742c0b.1345524670.git.afzal@ti.com>
 <50359C64.40603@ti.com> <20120824195446.GV11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37588 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab2H0LqM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Aug 2012 07:46:12 -0400
In-Reply-To: <20120824195446.GV11011@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Sat, Aug 25, 2012 at 01:24:47, Tony Lindgren wrote:

> Yes agreed. Also as some values make sense only in cycles, converting them
> back and forth to time is wrong. So at least some values should have an
> option to specify them in cycles directly, and then ignore any time based
> values.

Which values in struct gpmc_device_timings are you referring to ?

Values that need to have an option to specify in cycles has been provided
such an option, while not updating time based field value, you can
achieve what you mentioned above. But if you want that to be handled in
in generic routine, I will do so.

Regards
Afzal
