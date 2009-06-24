From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH v2] OMAP3: PM: reset USB OTG module on boot
Date: Wed, 24 Jun 2009 14:27:26 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038E45B3D6@dlee02.ent.ti.com>
References: <1245857533-2419-1-git-send-email-khilman@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F546233D@dbde02.ent.ti.com>
 <87tz251ph2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55481 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312AbZFXT1a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 15:27:30 -0400
In-Reply-To: <87tz251ph2.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman

> > Why is this sys-config reset done only for omap34xx()
> > This should be valid for any old 24xx() as well as new 44xx() omaps
>
> You're correct.  Good catch.
>
> The force-idle "fix" that this is replacing was only being done on
> 34xx due to the smart-idle errata.  However, this reset should be
> done even without any errata.

Minor note, IIRC the different OTG IP used in OMAP2420 did require a similar force at boot time.  That would be a different file if it exists.

Regards,
Richard W.
