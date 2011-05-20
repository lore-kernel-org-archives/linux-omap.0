From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH V4] OMAP3+: SR Layer Cleanup
Date: Fri, 20 May 2011 15:49:09 +0200
Message-ID: <4DD67155.1030705@ti.com>
References: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58558 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932291Ab1ETNtR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 09:49:17 -0400
In-Reply-To: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

Hi Shweta,

On 5/13/2011 8:27 AM, Gulati, Shweta wrote:
> To set sr ntarget values  for all volt_domain,
> volt_table is retrieved by doing a look_up of 'vdd_name'
> field from omap_hwmod but voltage domain pointer does not
> belong to omap_hwmod and is not used anywhere else.
> As a part of voltage layer and SR Layer clean up volt
> pointer is removed from omap_hwmod and added in dev
> attributes of SR.
>
> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>
> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
> Acked by: Nishanth Menon<nm@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> ---
>
> V4:
>    Fixed comments like checking for NULL pointers
>    and following conventions in naming the instances
>    recommended by Todd Poynor and Benoit Cousson.

It looks like you missed at least two comments I did on the previous 
version whereas you did agree to fix them.

Thanks,
Benoit
