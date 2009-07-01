From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle before OFF,
 reduces OFF latency by 20ms
Date: Wed, 1 Jul 2009 09:28:19 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039632B16F@dlee02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305B7837E@dbde02.ent.ti.com>
 <87zlbov64k.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38099 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbZGAO22 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jul 2009 10:28:28 -0400
In-Reply-To: <87zlbov64k.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Derrick, David" <dderrick@ti.com>

> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Wednesday, July 01, 2009 9:19 AM

> David, did you see stability problems when using this patch on top of
> linux-omap PM branch?  Or did you see problems on some internal tree?

Issue was on one internal tree.  Tests need to be re-applied to current trees.

Regards,
Richard W.

