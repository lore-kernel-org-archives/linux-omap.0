From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 3/3] ARM: dts: OMAP3: Use MTD constants for OMAP3 boards
Date: Tue, 11 Jun 2013 19:31:21 +0200
Message-ID: <51B75EE9.9050901@epfl.ch>
References: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch> <1370962138-9631-4-git-send-email-florian.vaussard@epfl.ch> <51B74FEE.1010301@wwwdotorg.org>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:35000 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754001Ab3FKRb0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 13:31:26 -0400
In-Reply-To: <51B74FEE.1010301@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Anil Kumar <anilk4.v@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello,

On 06/11/2013 06:27 PM, Stephen Warren wrote:
> On 06/11/2013 08:48 AM, Florian Vaussard wrote:
>> Use the MTD constants for NAND and OneNAND nodes used in OMAP3
>> DTS.
>
> I don't quite understand the split between patches 2/3 and 3/3; isn't
> the edit to omap3-overo.dtsi (part of) a board file, and hence logically
> part of this patch? I'd be tempted just to squash the two together.
>
> But, this is a nit; not a big deal.
>

Patch 2/3 was adding a new node, whereas patch 3/3 was converting existing
nodes. But your point is perfectly valid.

Regards,

Florian
