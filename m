From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH 1/5] ARM: dts: AM33XX: Fix the i2c numbering to match
 hardware/TRM
Date: Wed, 27 Mar 2013 09:28:34 -0400
Message-ID: <20130327132834.GH18335@beef>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
 <686d89bc7b6d4bf1bc1c0524e4b586dd@DLEE51.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:42184 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab3C0N0t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 09:26:49 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so10110314ieb.17
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 06:26:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <686d89bc7b6d4bf1bc1c0524e4b586dd@DLEE51.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Wed, Mar 27, 2013 at 12:59:12PM +0000, Vaibhav Hiremath wrote:
> With DT support, where naming convention is based on base-addr
> and not id, so we should follow TRM/Spec numbering label.
> 
> This patch changes I2C numbering as per TRM, as I2C0, I2C1 and I2C2.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>

Acked-by: Matt Porter <mporter@ti.com>

-Matt
