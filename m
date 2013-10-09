From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: pdata-quirks: add legacy display init
 for IGEPv2 board
Date: Wed, 9 Oct 2013 07:52:30 -0700
Message-ID: <20131009145230.GX8313@atomide.com>
References: <1380941496-26899-1-git-send-email-javier.martinez@collabora.co.uk>
 <20131008211108.GQ8313@atomide.com>
 <5254F15B.5050207@ti.com>
 <5255077A.4010702@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30922 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755255Ab3JIOwh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 10:52:37 -0400
Content-Disposition: inline
In-Reply-To: <5255077A.4010702@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131009 00:45]:
> On 10/09/2013 08:02 AM, Tomi Valkeinen wrote:
> > Hi Tony,
> > 
> > On 09/10/13 00:11, Tony Lindgren wrote:
> >> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131004 20:00]:
> >>> IGEPv2 board has both an DVI and TFP410 video interfaces but
> >>> DSS support for DeviceTree has not yet landed in mainline so
> >>> is necessary to init the displays using legacy platform code.
> >> 
> >> Thanks, applying into omap-for-v3.13/quirk.
> > 
> > Can you remove the patch from your branch? It had bug, and I had some
> > questions related to it.
> 
> I noticed about the bug (a duplicated pdata_quirks) just after sending the patch
> so I fixed on a v2 [1].

OK dropping it as I did not push it out yet. Will apply the version
with Tomi's ack.

Regards,

Tony
 
 
> [1]: http://www.spinics.net/lists/linux-omap/msg98257.html
