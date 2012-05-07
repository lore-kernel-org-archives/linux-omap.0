From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
Date: Mon, 7 May 2012 13:59:16 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA175CD@DBDE01.ent.ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com>
 <20120418231837.GT21106@atomide.com>
 <79CD15C6BA57404B839C016229A409A83E9F9C2D@DBDE01.ent.ti.com>
 <20120426184312.GY3739@atomide.com>
 <79CD15C6BA57404B839C016229A409A83E9FF9EA@DBDE01.ent.ti.com>
 <20120426190524.GZ3739@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA008E5@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205020255150.19695@utopia.booyaka.com>
 <4FA7A4D0.80006@ti.com>
 <CAMQu2gxmPAEWYmE+DLHNYii1-wtjkm68mxU89F8EXyGLQP1Tww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48108 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756571Ab2EGN71 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 09:59:27 -0400
In-Reply-To: <CAMQu2gxmPAEWYmE+DLHNYii1-wtjkm68mxU89F8EXyGLQP1Tww@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, May 07, 2012 at 16:14:42, Shilimkar, Santosh wrote:
> On Mon, May 7, 2012 at 4:02 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> > Hi Paul,
> >
> >
> > On 5/2/2012 11:09 AM, Paul Walmsley wrote:
> >>
> >> On Fri, 27 Apr 2012, Hiremath, Vaibhav wrote:
> >>
<snip>
> >> So first we have to decide whether the CONFIG_ARCH_OMAP* options should
> >> have a strong dependency on the MPU type, as they currently do; or whether
> >> they should focus on the way the SoC is integrated.
> >
> >
> > I think as well that these devices should be considered as part of the OMAP4
> > family.
> > The CPU type should not be the parameter that decide the OMAP family, it is
> > just an IP, that can change on some variant, whereas the whole PRCM
> > infrastructure / interconnect is mostly the same.
> >
> I agree. In fact more and more I think of this problem, looks like we
> should get rid
> off ARCH_OMAP* and just is SOC_* going forward.
> 
> Common ARM code already takes care of different CPU version and as Benoit
> mentioned it is just one of the IP in the entire SOC. I saw tony commenting
> in similarly on of the patch set.
> 

I am working on creating patch-sets for am33xx device on the same direction,
that means, am33xx will not fallow, neither ARCH_OMAP3 nor ARCH_OMAP4.
am33xx will be separate device under ARCH_OMAP2PLUS, with "SOC_OMAPAM33XX".

This also means, neither cpu_is_omap34xx() not cpu_is_omap44xx() will be 
true for am33xx. We will have separate cpu_is_am33xx() class for this.

Shortly I will submit patch-series for this. 
Just FYI, I have some cleanup patches,  which actually tries to cleanup some 
of the existing ARCH_OMAPx dependency in code, making addition of devices 
easier under ARCH_OMAP2PLUS.

Thanks,
Vaibhav
