From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH-V2 5/6] ARM: dts: AM33XX: Fix uart numbering to match hardware/TRM
Date: Thu, 28 Mar 2013 08:07:44 +0100
Message-ID: <87mwto3su7.fsf@dell.be.48ers.dk>
References: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
	<1364452963-22083-6-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:42436 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab3C1HHt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 03:07:49 -0400
Received: by mail-ea0-f182.google.com with SMTP id q15so3703433ead.27
        for <linux-omap@vger.kernel.org>; Thu, 28 Mar 2013 00:07:48 -0700 (PDT)
In-Reply-To: <1364452963-22083-6-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Thu, 28 Mar 2013 12:12:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, mporter@ti.com, b-cousson@ti.com

>>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:

 Vaibhav> With DT support, where naming convention is based on base-addr
 Vaibhav> and not id, so we should follow TRM/Spec numbering label.

 Vaibhav> This patch changes UART numbering as per TRM, as uart0-5.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
