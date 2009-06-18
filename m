From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: [Question] omap3 clock framework for clock set_rate
Date: Fri, 19 Jun 2009 07:46:05 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D53F26AE@zmy16exm69.ds.mot.com>
References: <87zlc5tyq3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail119.messagelabs.com ([216.82.241.195]:51656 "EHLO
	mail119.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbZFRXqh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 19:46:37 -0400
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate2.mot.com (8.14.3/8.14.3) with ESMTP id n5INkbp2028717
	for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 16:46:37 -0700 (MST)
Received: from il27vts02.mot.com (il27vts02.cig.mot.com [10.17.196.86])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id n5INkb5i023730
	for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 18:46:37 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id n5INkaHx023727
	for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 18:46:36 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <87zlc5tyq3.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com

Paul,

In linux-omap clock framework, most clocks have no
set_rate in their definition in clock34xx.h, but defined
DEFAULT_RATE in clksel_rate structures, this
Will only allow some pre-set rates for some clocks and
Can not get a more flexible rates if driver wants to
Change the clock rate usng clk_set_rate.

What is the benefit of this implementation?

We want to understand this before we made the change
In case we missed some imprtant background of
This implementation.

Thanks,
Chunqiu

