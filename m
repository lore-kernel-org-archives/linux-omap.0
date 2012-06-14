From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 04/14] ARM: OMAP2+: gpmc: minimal driver support
Date: Thu, 14 Jun 2012 08:42:37 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9996A8@DBDE01.ent.ti.com>
References: <4FD6586A.9060706@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997E2A@DBDE01.ent.ti.com>
 <4FD782F7.9010003@ti.com> <20120613120717.GP12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998E43@DBDE01.ent.ti.com>
 <20120613134032.GW12766@atomide.com> <20120613134408.GY12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998F2F@DBDE01.ent.ti.com>
 <20120614063524.GB12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99952D@DBDE01.ent.ti.com>
 <20120614083957.GC12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51362 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753243Ab2FNImo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 04:42:44 -0400
In-Reply-To: <20120614083957.GC12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Thu, Jun 14, 2012 at 14:09:58, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120613 23:44]:

> > Sorry, I got confused, we need revision to be available while setting
> > time also, so you meant to store it as a variable or read revision
> > at probe as well as during setting time ?
> 
> You can set up GPMC specific flags during init, something like
> OMAP_GPMC_HAS_XYZ, or you can set up function pointers if only
> some features are available on some revisions.

Ok, got it

Regards
Afzal
