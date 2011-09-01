From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC/PATCH v2 08/13] dt: omap: i2c: add dt support for i2c1 controller
Date: Thu, 1 Sep 2011 19:34:11 +0200
Message-ID: <4E5FC213.3080407@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com> <1314074021-25186-9-git-send-email-manjugk@ti.com> <20110823154649.GF32698@manju-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40919 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755872Ab1IAReU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 13:34:20 -0400
In-Reply-To: <20110823154649.GF32698@manju-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Manju,

On 8/23/2011 5:46 PM, G, Manjunath Kondaiah wrote:
> Hi Grant,

[...]

> This function calls of_i2c_register_devices which attaches all the required
> parameters reg, irq, archdata etc into i2c adapter. But it will not attach
> platform_data which results empty pdata pointer in i2c child devices.
>
> Is this done purposefully?

I think so, but anyway, we'd rather spend some time on doing a proper DT 
implementation than hacking more the AUXDATA temporary solution.

I've just sent a reworked version of that series with a pure 
dt-no-auxdata-hack approach.

Regards,
Benoit
