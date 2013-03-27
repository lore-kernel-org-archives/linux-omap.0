From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH 2/5] ARM: dts: AM33XX: Add default pinctrl binding for
 I2C device
Date: Wed, 27 Mar 2013 09:29:50 -0400
Message-ID: <20130327132950.GI18335@beef>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
 <a20a6c7b5b5b45328684e5afab385ae5@DFLE51.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:65172 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3C0N2F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 09:28:05 -0400
Received: by mail-ia0-f170.google.com with SMTP id h8so7376353iaa.1
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 06:28:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a20a6c7b5b5b45328684e5afab385ae5@DFLE51.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Wed, Mar 27, 2013 at 12:59:13PM +0000, Vaibhav Hiremath wrote:
> Add pin control binding for I2C device nodes in all
> board specific DT files (as per current usage),
> 
> EVM: Both i2c0 and i2c1
> EVM-SK and Bone: Only i2c0
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>

Acked-by: Matt Porter <mporter@ti.com>

-Matt
