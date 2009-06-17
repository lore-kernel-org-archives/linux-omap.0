From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle before OFF,
 reduces OFF latency by 20ms
Date: Wed, 17 Jun 2009 02:33:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906170230300.3382@utopia.booyaka.com>
References: <1245153154-1876-1-git-send-email-rnayak@ti.com> <87k53c5kez.fsf@deeprootsystems.com> <92CDD168D1E81F4F9D3839DC45903FC6536982D4@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37735 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391AbZFQIdJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 04:33:09 -0400
In-Reply-To: <92CDD168D1E81F4F9D3839DC45903FC6536982D4@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Derrick, David" <dderrick@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>

Hello David,

On Tue, 16 Jun 2009, Derrick, David wrote:

> Note that we have seen some instability with this change so use with caution.

Could you please expand on this?  Presumably we should not merge this if 
it will cause instability, no?


- Paul
