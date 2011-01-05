From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v3 1/4] TI816X: Update common omap platform files
Date: Wed, 5 Jan 2011 06:52:08 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A57AFF5@dbde02.ent.ti.com>
References: <1294075737-22320-1-git-send-email-hemantp@ti.com>
 <alpine.DEB.2.00.1101031603070.10403@utopia.booyaka.com>
 <20110104015008.GX7771@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B036A57AF93@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1101041046540.9203@utopia.booyaka.com>
 <20110104232547.GP7771@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47656 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab1AEBWQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 20:22:16 -0500
In-Reply-To: <20110104232547.GP7771@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Tony Lindgren wrote on Wednesday, January 05, 2011 4:56 AM:

> * Paul Walmsley <paul@pwsan.com> [110104 09:48]:
>> On Tue, 4 Jan 2011, Pedanekar, Hemant wrote:
>> 
>>> Looking at above, it seems another config option like
>>> CONFIG_SOC_OMAP3XXX is also needed in addition to CONFIG_SOC_OMAPTI816X.
>> 
>> We already have CONFIG_ARCH_OMAP3430, CONFIG_ARCH_OMAP2430, and
>> CONFIG_ARCH_OMAP2420.  I guess at some point those need to be renamed to
>> CONFIG_SOC_*.
> 
> Yes that's what I was thinking too. Keep CONFIG_ARCH_OMAP2, 3, and 4,
> and rename CONFIG_ARCH_OMAP3430 etc to CONFIG_SO_COMAP3430 and so on.
> 
> Regards,
> 
> Tony

So I will add CONFIG_SOC_OMAPTI816X to handle TI816X specific variations.
But I think without addition of corresponding CONFIG_SOC_OMAP3XXX, it would be
difficult to handle 2nd case I mentioned (OMAP3 build for OMAP3xxx as well as
TI816X SoCs). Will it be OK if we consider this 2nd case as invalid/unsupported
for the moment - that is, 2nd case = 4th case (OMAP3 build for TI816X only)?
Same applies for multi-omap case too.

In short, if CONFIG_SOC_OMAPTI816X is selected, the build becomes specific to
TI816X and not OMAP3xxx in all the cases (so keep CONFIG_SOC_OMAPTI816X disabled
by default in multi-omap configuration).

Thanks
-
Hemant

