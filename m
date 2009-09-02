From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH][RFC] OMAP3: PM: Adding OSWR support
Date: Wed, 2 Sep 2009 18:33:42 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039A899451@dlee02.ent.ti.com>
References: <1251391962-11217-1-git-send-email-thara@ti.com>
 <20090828160636.GK25828@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F9A455D7@dbde02.ent.ti.com>
 <4A9DE3AA.2080502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60702 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261AbZIBXdr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Sep 2009 19:33:47 -0400
In-Reply-To: <4A9DE3AA.2080502@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Hunter, Jon

> Not to split hairs, but the OMAP3430 Technical Reference Manual states
> that OSwR means Open Switch Retention. So no "with". This W always
> bother me too!

No bother with W, its part of switch.

Underlying spec's have always defined it as following:

        OSWR stands for Open SWitch Retention
        CSWR stands for Closed SWitch Retention

Regards,
Richard W.
