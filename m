From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Sun, 1 Jul 2012 23:26:49 -0700
Message-ID: <20120702062649.GN4202@atomide.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
 <20120627145844.GL3483@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
 <20120628123207.GG19842@atomide.com>
 <4FEC89B9.3090404@ti.com>
 <4FECA9DD.8050505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:10420 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab2GBG0w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 02:26:52 -0400
Content-Disposition: inline
In-Reply-To: <4FECA9DD.8050505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [120628 12:05]:
> 
> Tony, have you tried using any of the mtd kernel tests to verify OneNAND
> read/write is working on your n900? For example ...
> 
> # insmod mtd_pagetest.ko dev=<mtd-part-num>
> 
> _NOTE_ that above test erases the OneNAND! ;-)

Ehh not thanks.

Tony
