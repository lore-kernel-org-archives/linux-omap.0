From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 0/6] ARM: dts: AM33XX: Cleanup and pinctrl binding
 support
Date: Fri, 29 Mar 2013 14:52:02 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC3DDC8@DBDE01.ent.ti.com>
References: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
 <515436FF.9030703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35865 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755023Ab3C2OxU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Mar 2013 10:53:20 -0400
In-Reply-To: <515436FF.9030703@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Porter, Matt" <mporter@ti.com>, "jacmet@sunsite.dk" <jacmet@sunsite.dk>

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Thursday, March 28, 2013 5:57 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree-discuss@lists.ozlabs.org; Porter, Matt; jacmet@sunsite.dk
> Subject: Re: [PATCH-V2 0/6] ARM: dts: AM33XX: Cleanup and pinctrl
> binding support
> 
> Hi Vaibhav,
> 
> The series looks good to me, but unfortunately does not apply cleanly
> on
> top of the latest for_3.10/dts branch.
> 
> Could you rebase it?
> 
Benoit,

You can simply skip below two patches,

[PATCH 1/6] ARM: dts: AM33XX: Fix the i2c numbering to match hardware/TRM
[PATCH 3/6] ARM: dts: AM33XX: Fix gpio numbering to match hardware/TRM


You have already merged Anil Kumar's patch into your branch.

commit 9115b7c03565b5797714b2e819f6a79f040d8782
Author: AnilKumar Ch <anilkumar@ti.com>
Date:   Wed Nov 21 17:22:17 2012 +0530

    ARM: dts: AM33XX: Rename I2C and GPIO nodes



NOTE: I have build and boot tested by skipping above 2 patches.

Thanks,
Vaibhav
