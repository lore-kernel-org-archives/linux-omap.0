From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP baseline test results for v3.7-rc3
Date: Tue, 6 Nov 2012 06:09:21 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB635C9@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508F59FB.7080400@ti.com>
 <alpine.DEB.2.00.1211050239530.23228@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48067 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab2KFGJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 01:09:28 -0500
In-Reply-To: <alpine.DEB.2.00.1211050239530.23228@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Nov 05, 2012 at 08:11:24, Paul Walmsley wrote:
> Hi
> 
> On Tue, 30 Oct 2012, Vaibhav Hiremath wrote:
> 
> > This is surprising, I have tested v3.7-rc3 branch on AM335xBone platform
> > and its booting up for me without any issues.
> > Jon had submitted another patch which fixes boot issue on Bone.
> > 
> > https://patchwork.kernel.org/patch/1606471/
> 
> v3.7-rc4 failed for me with a detached .dtb in a quick test.  Probably it 
> is due to the original u-boot that was shipped with the MMC card:
> 

Pulling the tree, let me try now and update you shortly...

> U-Boot 2011.09-00009-gcf6e04d (Mar 08 2012 - 17:15:43)
> arm-arago-linux-gnueabi-gcc (GCC) 4.5.3 20110311 (prerelease)
> 
> 
> Which U-boot are you using these days?
> 

I am using mainline denx u-boot.

Thanks,
Vaibhav

> 
> - Paul
> 

