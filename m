From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v2 1/8] ARM/dts: OMAP2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
Date: Tue, 11 Sep 2012 11:42:58 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAB0E4D@DBDE01.ent.ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
 <1346247067-9632-2-git-send-email-peter.ujfalusi@ti.com>
 <5044C2DD.5000705@ti.com> <504578B3.3090804@ti.com> <5045D557.30404@ti.com>
 <79CD15C6BA57404B839C016229A409A83EAA7C99@DBDE01.ent.ti.com>
 <50470C1E.7090300@ti.com>
 <79CD15C6BA57404B839C016229A409A83EAA8014@DBDE01.ent.ti.com>
 <5047544B.60105@ti.com>
 <79CD15C6BA57404B839C016229A409A83EAA8779@DBDE01.ent.ti.com>
 <5048B63F.5030309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53818 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586Ab2IKLnI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 07:43:08 -0400
In-Reply-To: <5048B63F.5030309@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

+ Andrew,

On Thu, Sep 06, 2012 at 20:12:07, Cousson, Benoit wrote:
> 
> On 09/05/2012 04:41 PM, Hiremath, Vaibhav wrote:
> ...
> > There are other patches which are pending,
> > 
> > arm/dts: AM33XX: Convert all hex numbers to lower-case
> > https://patchwork.kernel.org/patch/1377351/
> > arm/dts: AM33XX: Specify reg and interrupt property for all nodes
> > https://patchwork.kernel.org/patch/1377361/
> 
> OK, so these ones are fine, you should just rebase them because theyu
> are conflicting with patches already inside lo/devel-dt
> 
> > Probably your Ack is required for,
> > 
> > ARM: AM33XX: clock: Add dcan clock aliases for device-tree
> > https://patchwork.kernel.org/patch/1377061/
> 
> Paul already queued this one so it is fine.
> 
> > RTC:
> > I am not sure how to deal with RTC DT support, as I understand the list is very unresponsive there.
> 
> OK, so I did have the same issue for TWL RTC since the maintainer is no
> longer very active. In that case you should go through Andrew Morton.
> 

Andrew,
Can you please merge these omap-rtc patches, there are no review comments so 
far and I believe it should be safe now to merge.

Thanks,
Vaiibhav

> Regards,
> Benoit
> 
> > http://www.mail-archive.com/davinci-linux-open-source@linux.davincidsp.com/msg23253.html
> 
> 

