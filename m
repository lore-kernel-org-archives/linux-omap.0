From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: RE: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Fri, 5 Jun 2009 05:58:18 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D5372B9F@zmy16exm69.ds.mot.com>
References: <87fxeffzno.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail153.messagelabs.com ([216.82.253.51]:26521 "EHLO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbZFDV7A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 17:59:00 -0400
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id n54Lx0l3017720
	for <linux-omap@vger.kernel.org>; Thu, 4 Jun 2009 14:59:00 -0700 (MST)
Received: from il06vts02.mot.com (il06vts02.mot.com [129.188.137.142])
	by il06exr03.mot.com (8.13.1/Vontu) with SMTP id n54Lx0Pv016885
	for <linux-omap@vger.kernel.org>; Thu, 4 Jun 2009 16:59:00 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id n54Lwxwp016875
	for <linux-omap@vger.kernel.org>; Thu, 4 Jun 2009 16:59:00 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <87fxeffzno.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Mike Chan <mikechan@google.com>

 
> What do you think about disabling the level/edge detection when
> disable_irq_wake() is called instead?  This seems more logical
> and expected.
Kevin, if we look at the current code, enable_irq_wake and
disable_irq_wake
Does not even touch any GPIO WAKEEN register, it seems it is intended
To just log the gpio bit and enable its WAKEUP and IOPAD wakeup
when suspend happens. And also, enable_irq_wake/disable_irq_wake
Are designed to be able used when both IRQ is enabled AND disabled,
In another words, enable_irq_wake may be called after irq_disable,
Disable_irq_wake may be called after irq_enable, if we change
Level/edge detect then it may cause either IRQ never happen
After irq_enable, or IRQ staus bit also set after irq_disable. Since
The root reason is the level/edge detect can cause IRQ status, it
Is related with IRQ, not wakeup.

What do you think?
> 
> Kevin
> 
> P.S., are you wanting to use your touchscreen as a wakeup source?
> 
