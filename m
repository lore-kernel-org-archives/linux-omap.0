From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 13/15] ARM: DTS: AM33XX: Add nodes for OCMCRAM and
 Mailbox
Date: Mon, 5 Nov 2012 17:57:54 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC0337B@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
 <50953E26.40906@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EBFFD0A@DBDE01.ent.ti.com>
 <5097D2D7.3090204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44560 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275Ab2KER6E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 12:58:04 -0500
In-Reply-To: <5097D2D7.3090204@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Mon, Nov 05, 2012 at 20:23:11, Shilimkar, Santosh wrote:
[...]
> >
> On OMAP the OCMC RAM is always clocked and doesn't need any special
> clock enable. CM_L3_2_OCMC_RAM_CLKCTRL module mode field is read only.
> Isn't it same on AMXX ?
> 

On AM33xx, OCMC RAM is in PER domain and the corresponding CLKCLTR module
mode fields are r/w. OCMC RAM needs to be disabled as part of the DeepSleep0
entry to let PER domain transition.

Regards,
Vaibhav 

