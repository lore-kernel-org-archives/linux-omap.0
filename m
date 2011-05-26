From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
Date: Thu, 26 May 2011 16:12:32 +0200
Message-ID: <4DDE5FD0.9050309@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com> <1306247094-25372-3-git-send-email-tarun.kanti@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D177FCC@dbde02.ent.ti.com> <4DDE2745.3030307@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D178110@dbde02.ent.ti.com> <4DDE435C.8060506@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D17815E@dbde02.ent.ti.com> <4DDE4BB0.7010809@ti.com> <AB90A028-5926-4DBB-BAD9-7C0EF6E0FD05@mhlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41360 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932308Ab1EZOMm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 10:12:42 -0400
In-Reply-To: <AB90A028-5926-4DBB-BAD9-7C0EF6E0FD05@mhlabs.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "B.J. Buchalter" <bj@mhlabs.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>, Paul Walmsley <paul@pwsan.com>

On 5/26/2011 3:38 PM, B.J. Buchalter wrote:
> Why not do the following:
>
>         #define OMAP_GPIO_REV_0	0
>         #define OMAP_GPIO_REV_1	1
>         #define OMAP_GPIO_REV_2	2
>         #define OMAP_GPIO_REV_3	3
> /*
> 	OMAP_GPIO_REV_0:	OMAP2420
> 	OMAP_GPIO_REV_1:	OMAP2430
> 	OMAP_GPIO_REV_2:	OMAP3, DMxxx
> 	OMAP_GPIO_REV_3:	OMAP4, OMAP5, DM816x
> */
>
>    +	switch (oh->class->rev) {     ## This is auto-generated.
>    +	case 0:				## But this is our code.
>
>        I am recommending this to read as:
>
>    +	switch (oh->class->rev) {     ## This is auto-generated.
>    +	case OMAP_GPIO_REV_0:		## More readable.
>
> That approach solves both issues -- Revision ->  Chip mapping in comment, no magic numbers in the code, and no implied restriction of the rev number to a specific SoC. Using the defines makes it easier to search the code for a specific revision, since you would no longer get false positives for all the other '0' and '1' constants that appear in the code. It also makes it indexible by tools like LXR.

This is indeed what was done for I2C recently.
The point is that this kind of define does not bring a lot of semantic. 
But on the other hand it will definitively help the search aspect.

Thanks,
Benoit
