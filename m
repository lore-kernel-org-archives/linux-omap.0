From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v3 1/6] mfd: TPS65910: Handle non-existent devices
Date: Fri, 4 Nov 2011 06:22:43 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9018E8F@DBDE01.ent.ti.com>
References: <1320340086-15371-1-git-send-email-kyle.manna@fuel7.com>
 <1320340086-15371-2-git-send-email-kyle.manna@fuel7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39554 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab1KDGXh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 02:23:37 -0400
In-Reply-To: <1320340086-15371-2-git-send-email-kyle.manna@fuel7.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyle Manna <kyle.manna@fuel7.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood, Liam" <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kyle,

On Thu, Nov 03, 2011 at 22:38:01, Kyle Manna wrote:
> +	ret = mfd_add_devices(tps65910->dev, -1, tps65910s,
> +			ARRAY_SIZE(tps65910s), NULL, 0);
> +	if (ret < 0)
> +		goto err2;

Isn't goto err sufficient

Regards
Afzal
