From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 1/2] ARM: OMAP4: cminst: Add boot time __init function for cminst
Date: Wed, 15 Feb 2012 08:40:37 +0100
Message-ID: <87mx8ktuh6.fsf@macbook.be.48ers.dk>
References: <1329233348-23356-1-git-send-email-hvaibhav@ti.com>
	<1329233348-23356-2-git-send-email-hvaibhav@ti.com>
	<87bop1unln.fsf@macbook.be.48ers.dk>
	<79CD15C6BA57404B839C016229A409A8317CF3B2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:62896 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893Ab2BOHkn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 02:40:43 -0500
Received: by werb13 with SMTP id b13so421433wer.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 23:40:42 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317CF3B2@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Wed, 15 Feb 2012 06:27:53 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

>>>>> "Vaibhav" == Hiremath, Vaibhav <hvaibhav@ti.com> writes:

Hi,

 Vaibhav> -	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 Vaibhav> +	BUG_ON(part >= max_cm_partitions ||
 Vaibhav> part == OMAP4430_INVALID_PRCM_PARTITION ||
 >> 
 >> How about dropping the OMAP4430_ prefix here as it's no longer 4430 specific?
 >> 
 Vaibhav> Peter,

 Vaibhav> You could be right here, from this patch perspective, this
 Vaibhav> change doesn't make sense.

 Vaibhav> But at the first place I am quite not sure, why this has been
 Vaibhav> named as OMAP4430_? Vs some macros are named as OMAP4_.

 Vaibhav> So first we need to understand why it has been named this way,
 Vaibhav> may be "Paul Walmsley" can comment on this. He is original
 Vaibhav> author of this file.

As I read it, it doesn't have anything to do with any specific hardware,
it's just to catch bugs when people forget to initialize the structure
field:

arch/arm/mach-omap2/prcm44xx.h:
/*
 * OMAP4 PRCM partition IDs
 *
 * The numbers and order are arbitrary, but 0 is reserved for the
 * 'invalid' partition in case someone forgets to add a
 * .prcm_partition field.
 */
#define OMAP4430_INVALID_PRCM_PARTITION         0

-- 
Bye, Peter Korsgaard
