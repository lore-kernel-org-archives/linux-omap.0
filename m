From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH RESEND v2 1/2] arm/dts: Add AM33XX basic pinctrl support
Date: Mon, 13 Aug 2012 04:33:59 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA10824@DBDE01.ent.ti.com>
References: <1343144719-26352-1-git-send-email-anilkumar@ti.com>
 <1343144719-26352-2-git-send-email-anilkumar@ti.com>
 <50125B1C.8000209@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA06E4B@DBDE01.ent.ti.com>
 <50225618.9070501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36732 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab2HMEeS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Aug 2012 00:34:18 -0400
In-Reply-To: <50225618.9070501@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

Peter,

On Wed, Aug 08, 2012 at 17:35:44, Ujfalusi, Peter wrote:
> On 07/31/2012 04:37 PM, AnilKumar, Chimata wrote:
> >> I'm just curious about the size here: how it ended up as 0x0338?
> >> While looking at the TRM of AM335x I can come up with 0x0238 (0x44e10800 -
> >> 0x44e10a38), but I don't see any sings of the remaining 0x0100 to be
> >> documented at least.
> > 
> > No, pinmux registers are available till 0x44E10B38, look at AM335x latest TRM
> > or pinmux utility (we cannot find the exact offsets but pins we can find after
> > 0x0A38, conf_ddr_resetn) at http://www.ti.com/tool/pinmuxtool
> 
> I have looked at the latest TRM (Rev F, SPRUH73F -  public TRM) and there is
> not mention of registers between 0x0a34 and 0x0e00.
> I can not even find any reference of conf_ddr_resetn register either in the TRM.
> I can not check with the pinmuxtool since it is crashing with wine under Linux.
> There could be registers after 0x0a34, but they are not publicly documented...
> 

Thanks for pointing this, I was referring older version (Rev C) of TRM which have
the details which is not present in latest TRM. These pins are dedicated ones so
pinmuxing is not required. I will submit new version.

Thanks
AnilKumar
