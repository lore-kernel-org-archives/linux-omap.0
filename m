From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 1/5] ARM: dts: AM33XX: Fix the i2c numbering to match hardware/TRM
Date: Wed, 27 Mar 2013 14:22:22 +0100
Message-ID: <87k3ot6kq9.fsf@dell.be.48ers.dk>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
	<1364389156-8273-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:52456 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3C0NW1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 09:22:27 -0400
Received: by mail-ee0-f45.google.com with SMTP id b57so4228427eek.4
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 06:22:26 -0700 (PDT)
In-Reply-To: <1364389156-8273-2-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Wed, 27 Mar 2013 18:29:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, mporter@ti.com, devicetree-discuss@lists.ozlabs.org

>>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:

 Vaibhav> With DT support, where naming convention is based on base-addr
 Vaibhav> and not id, so we should follow TRM/Spec numbering label.

 Vaibhav> This patch changes I2C numbering as per TRM, as I2C0, I2C1 and I2C2.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

What about the uart numbers while we're at it?

-- 
Bye, Peter Korsgaard
