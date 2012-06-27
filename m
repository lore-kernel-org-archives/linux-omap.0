From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: cpu: Make cpu_class_is_omap2 true for all
 non-omap1 platforms
Date: Wed, 27 Jun 2012 15:27:02 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5BCCA@DBDE01.ent.ti.com>
References: <1339420974-23695-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5096A@DBDE01.ent.ti.com>
 <20120627133950.GJ3483@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA5BAF8@DBDE01.ent.ti.com>
 <20120627135816.GK3483@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52338 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab2F0P1V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 11:27:21 -0400
In-Reply-To: <20120627135816.GK3483@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jun 27, 2012 at 19:28:17, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120627 06:54]:
> > 
> > There are few cleanup patches pending for your review, it would be good if 
> > you provide your review comments.
> 
> Hmm care to post the Subject: lines for those? I may have marked
> something as read accidentally..
> 

I will resubmit the patches again ontop of linux-omap/master, makes more sense.

These patches are,

ARM: OMAP2+: CLEANUP: All OMAP2PLUS uses omap-device.o target so add one entry
ARM: OMAP2+: CLEANUP: Move omap3 dpll ops to dpll3xxx.c
ARM: OMAP2+: CLEANUP: Remove ARCH_OMAPx ifdef from struct dpll_data

Thanks,
Vaibhav	

