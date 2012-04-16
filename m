From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 2/3] ARM: OMAP2+: dmtimer: cleanup iclk usage
Date: Mon, 16 Apr 2012 13:27:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204161326420.29048@utopia.booyaka.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com> <1334579125-15566-3-git-send-email-tarun.kanti@ti.com> <79CD15C6BA57404B839C016229A409A83E9EE79A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46869 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab2DPT1l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 15:27:41 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9EE79A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Mon, 16 Apr 2012, Hiremath, Vaibhav wrote:

> Doesn't this impact OMAP3x family?
> The interface clocks will be enabled in omap_hwmod_enable(), 
> only if you set OCPIF_SWSUP_IDLE flag.

In the autoidle case, the interface clock should be enabled by the call to 
omap_hwmod_setup_one() earlier in the same function.



- Paul
