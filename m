From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [RFC PATCH v2 5/6] TI81XX: Add minimal hwmod data
Date: Thu, 8 Sep 2011 06:49:39 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4AAB78D@dbde02.ent.ti.com>
References: <1314119627-23088-1-git-send-email-hemantp@ti.com>
 <87ty8zoi15.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52706 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757688Ab1IHBT4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Sep 2011 21:19:56 -0400
In-Reply-To: <87ty8zoi15.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hilman, Kevin wrote on Tuesday, August 30, 2011 6:03 AM:

> Hemant Pedanekar <hemantp@ti.com> writes:
> 
>> This patch adds minimum required hwmod data (e.g., UARTs) for bootup of
>> TI81XX devices (currently common data for TI816X and TI814X is added).
>> 
>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
> 
> I haven't looked at the details yet, but just tried to boot this using
> current mainline and it fails.
> 
> My first guess is that it appears to be related to a missing clkdm for the
> MPU hwmod. 
> 
> Kevin

Thanks for the feedback.

I think that the issue is bacause clk_get() on fck_source is failing as TI816X 
clock data had different clock source names compared to OMAP3 (e.g., osc_sys_ck
instead of sys_ck). I will update this in next version.

Even after this, the kernel would get stuck at "Calibrating delay loop..."
because a few timer register offsets on TI81XX are different than OMAP3. I see
there are some patches floating on ML which add reg_map array (similar to i2c
driver) but seems they have not (yet) been accepted. Any chance that this will
get added to kernel?     

Thanks.

   Hemant