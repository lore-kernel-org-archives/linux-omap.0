From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH -pm 1/2] SDRC: check for stuck DLL state machine and kick
Date: Tue, 23 Jun 2009 15:11:07 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038E3DA683@dlee02.ent.ti.com>
References: <1245105775-28844-1-git-send-email-khilman@deeprootsystems.com>
 <1245105775-28844-2-git-send-email-khilman@deeprootsystems.com>
 <alpine.DEB.2.00.0906170139170.3382@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE8967162038E2AC611@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0906181505460.4087@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE8967162038E317258@dlee02.ent.ti.com>
 <alpine.DEB.2.00.0906231342350.6545@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58508 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255AbZFWULO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 16:11:14 -0400
In-Reply-To: <alpine.DEB.2.00.0906231342350.6545@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mike Chan <mikechan@google.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, June 23, 2009 3:05 PM

> Looks like the significant difference is the use of CLKCTRL = 0x2 (+
> AUTOCOUNT).  Maybe there is some SDRC bug related to CLKCTRL = 0x2 that
> causes this problem?  Perhaps the problem is partially related to PWDENA =
> 1 and erratum 1.150?  Anyway, will do a test run here with this SDRC_POWER
> register value and see if the problem reproduces.

It is my guess not for PWDENA as it was reported on a system with that not set.  Yes that should not enabled per errata.  Anyway it only does something in OFF type scenarios where you don't use self-refresh. "Typical" use cases don't seem to be using this.

There are a few unlock events which are best for any focused test. Most are supposed to auto-relock but ... I've heard of some validation tests in a few areas maybe they will yield something.

Regards,
Richard W.
