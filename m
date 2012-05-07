From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
Date: Mon, 7 May 2012 12:32:48 +0200
Message-ID: <4FA7A4D0.80006@ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com> <20120418231837.GT21106@atomide.com> <79CD15C6BA57404B839C016229A409A83E9F9C2D@DBDE01.ent.ti.com> <20120426184312.GY3739@atomide.com> <79CD15C6BA57404B839C016229A409A83E9FF9EA@DBDE01.ent.ti.com> <20120426190524.GZ3739@atomide.com> <79CD15C6BA57404B839C016229A409A83EA008E5@DBDE01.ent.ti.com> <alpine.DEB.2.00.1205020255150.19695@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56274 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756116Ab2EGKc4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 06:32:56 -0400
In-Reply-To: <alpine.DEB.2.00.1205020255150.19695@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On 5/2/2012 11:09 AM, Paul Walmsley wrote:
> On Fri, 27 Apr 2012, Hiremath, Vaibhav wrote:
>
>> I will be waiting for your comment and conformation on, which family AM33xx
>> device should fall in? Please refer to the mail-chain -
>>
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67275.html
>
> This decision turns out to be pretty important; it certainly affects the
> AM33xx PRM/CM/clockdomain/powerdomain patches that I've been looking at.
>
> Here is my suggestion, based on our previous practice.  I am not so
> sure that it is the best way, but it seems pretty reasonable"
>
> Using CONFIG_ARCH_OMAP3 for CONFIG_ARCH_OMAPAM33XX doesn't make sense, as
> far as I can tell.  The main area of similarity between the other
> CONFIG_ARCH_OMAP3 and AM33xx is the Cortex-A8.  And even that MPU
> subsystem is quite different between, say, the 3430/3630 and the AM33xx.
> Most of the AM33xx is quite different from the 3430/3630: OMAP4-style PRCM
> interface, OMAP4-style interconnect, etc.  Plus, most of the
> CONFIG_ARCH_OMAP3 code in our codebase is very 3430/3630-specific, like
> the PM code.
>
> This would seem to suggest that we should use CONFIG_ARCH_OMAP4.  But that
> option currently assumes an OMAP4-style MPU subsystem: SMP Cortex-A9,
> PL310, etc.  None of that is true for AM335x.
>
> So first we have to decide whether the CONFIG_ARCH_OMAP* options should
> have a strong dependency on the MPU type, as they currently do; or whether
> they should focus on the way the SoC is integrated.

I think as well that these devices should be considered as part of the 
OMAP4 family.
The CPU type should not be the parameter that decide the OMAP family, it 
is just an IP, that can change on some variant, whereas the whole PRCM 
infrastructure / interconnect is mostly the same.

Regards,
Benoit
