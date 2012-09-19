From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH RESEND 3/5] ARM: OMAP2+: AM33XX: Add clock entries to
 omap_clk data
Date: Wed, 19 Sep 2012 21:27:24 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA34214@DBDE01.ent.ti.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
 <1348089570-16161-4-git-send-email-anilkumar@ti.com>
 <alpine.DEB.2.00.1209192124090.5264@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab2ISV1d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:27:33 -0400
In-Reply-To: <alpine.DEB.2.00.1209192124090.5264@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Sep 20, 2012 at 02:54:31, Paul Walmsley wrote:
> Hi
> 
> On Thu, 20 Sep 2012, AnilKumar Ch wrote:
> 
> > Add AM335x cpu0 clock entry to the corresponding clock data
> > file. This is useful in getting the correct mpu clock pointer
> > to change the cpu frequency in cpufreq driver.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> Looks like this one is unrelated to the DTS changes, so I'll queue it 
> separately here for 3.7.
> 

Thanks Paul

Thanks
AnilKumar
