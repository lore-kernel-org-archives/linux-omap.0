From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [RFC PATCH v2 0/6] TI81XX: Add clock and hwmod data
Date: Wed, 5 Oct 2011 07:28:25 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4FB3EA2@dbde02.ent.ti.com>
References: <1314119594-22647-1-git-send-email-hemantp@ti.com>
 <alpine.DEB.2.00.1110040318260.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42895 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933050Ab1JEB6i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 21:58:38 -0400
In-Reply-To: <alpine.DEB.2.00.1110040318260.4611@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>

Hi Paul,

Paul Walmsley wrote on Tuesday, October 04, 2011 2:54 PM:

> Hi,
> 
> On Tue, 23 Aug 2011, Hemant Pedanekar wrote:
> 
>> This patch set is the v2 of TI816X clock and hwmods patches sent earlier.
>> 
>> The clock data is currently added only for TI816X, while minimal hwmod data
>> common for TI816X and TI814X is added.
>> 
>> This patch set depends on following patches:
>> 	TI81XX: Prepare for addition of TI814X support
>> 	TI814X: Add cpu type macros and detection support
>> 	TI814X: Create board support and enable build for TI8148 EVM
>> 
>> Please note that CHIP_IS_TI816X/CHIP_IS_TI814X are still being used and I
>> will send update once SoC list usage is available.
> 
> I've been spending some time with these patches.  A few aspects don't make
> much sense to me.  For example, looking at the TRMs, the 816x doesn't seem
> to have powerdomains for HDVICP0, 1, or 2, although they are listed in the
> patch.

Can you please check 18.2.1 in TRM from [1].

Above powerdomains are listed there as HDVICP2-0, 1, 2.

>  Also, the clockdomain layout is quite different between 814x and
> 816x, according to the TRMs.  Are the patches more accurate than the TRMs,
> or vice versa?
>
You are correct, 814x has differences in clock, clockdomain and powerdomain
data.

I would say the extent of differences level between 816x and 814x is 
something like (please also see reference links from Arago devl tree):

Clock data: ~90% data is different (main contributors: different
PLLs - FAPLL in 816x vs ADPLL 814x, different parent hierarchy)
[2] & [3]

Clockdomains data: ~60% [4]

Powerdomains data: ~90%  [5]
> Will send over the current reworked patches for TI81XX PRCM accessors,
> powerdomain code & data, and clockdomain code & data.  They are intended
> to apply over the TI814x patches that you sent recently.  I'd like to get
> your opinion(s) on these reworked patches.  Please note, so far they have
> only been compile-tested.
> 
> 
> - Paul

Thanks, I will try those and respond.

   Hemant

[1] http://focus.ti.com/general/docs/litabsmultiplefilelist.tsp?literatureNumber=sprugx8
[2] http://arago-project.org/git/projects/?p=linux-omap3.git;a=blob;f=arch/arm/mach-omap2/clock816x_data.c;h=32ea958afef915f93e0560f87d1bb2115e24ee2c;hb=HEAD
[3] http://arago-project.org/git/projects/?p=linux-omap3.git;a=blob;f=arch/arm/mach-omap2/clock814x_data.c;h=282ffa93398db678843a35766219970655563b46;hb=HEAD
[4] http://arago-project.org/git/projects/?p=linux-omap3.git;a=blob;f=arch/arm/mach-omap2/clockdomains81xx.h;h=217c9b4f85c59cc92e0f36ddd73044136c8e9fff;hb=HEAD
[5] http://arago-project.org/git/projects/?p=linux-omap3.git;a=blob;f=arch/arm/mach-omap2/powerdomains81xx.h;h=ef1299e00c216aea4d12bca2281540efb7eb77f0;hb=HEAD