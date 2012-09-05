From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v2 1/8] ARM/dts: OMAP2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
Date: Wed, 5 Sep 2012 14:41:11 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAA8779@DBDE01.ent.ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
 <1346247067-9632-2-git-send-email-peter.ujfalusi@ti.com>
 <5044C2DD.5000705@ti.com> <504578B3.3090804@ti.com> <5045D557.30404@ti.com>
 <79CD15C6BA57404B839C016229A409A83EAA7C99@DBDE01.ent.ti.com>
 <50470C1E.7090300@ti.com>
 <79CD15C6BA57404B839C016229A409A83EAA8014@DBDE01.ent.ti.com>
 <5047544B.60105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59826 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756917Ab2IEOl1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 10:41:27 -0400
In-Reply-To: <5047544B.60105@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Sep 05, 2012 at 19:01:55, Cousson, Benoit wrote:
> Hi Vaibhav,
> 
> On 09/05/2012 11:15 AM, Hiremath, Vaibhav wrote:
> > On Wed, Sep 05, 2012 at 13:53:58, Ujfalusi, Peter wrote:
> >> Hi,
> >>
> >> On 09/05/2012 09:11 AM, Hiremath, Vaibhav wrote:
> >>>> Not yet, but we discussed that with Peter and since he does have these
> >>>> patches for DT, he'll be able to test your series with the McBSP changes.
> >>>>
> >>>
> >>> Great.
> >>
> >> With his series and your patch for omap-hwmod audio was probing and working on
> >> OMAP3/4/5 without issues.
> >>
> > Peter,
> > Care to provide your Tested-By??
> > 
> > Benoit,
> > Can we merge this patch now?
> 
> Yes, I'll include it in the pull request along with DTS patches.
> 
> I've just tested it as well on OMAP4 by hacking the DTS for GPIO.
> I'll try to update at least all the OMAP4 IPs as well with the proper
> DTS resources for 3.7.
> 

Thanks Benoit,

There are other patches which are pending,

arm/dts: AM33XX: Convert all hex numbers to lower-case
https://patchwork.kernel.org/patch/1377351/
arm/dts: AM33XX: Specify reg and interrupt property for all nodes
https://patchwork.kernel.org/patch/1377361/


Probably your Ack is required for,

ARM: AM33XX: clock: Add dcan clock aliases for device-tree
https://patchwork.kernel.org/patch/1377061/



RTC:
I am not sure how to deal with RTC DT support, as I understand the list is very unresponsive there.
http://www.mail-archive.com/davinci-linux-open-source@linux.davincidsp.com/msg23253.html



Thanks,
Vaibhav

