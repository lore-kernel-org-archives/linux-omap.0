From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/6] OMAP4: hwmod data: add mmu hwmod for ducati and tesla
Date: Tue, 9 Nov 2010 01:03:15 +0100
Message-ID: <4CD88FC3.9050205@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>	<1289006396-27230-4-git-send-email-omar.ramirez@ti.com>	<4CD5BEFF.40301@ti.com>	<AANLkTim=5bgGo1cnkWJCPF4HmMnQrBhP_sPCK3rRKUPS@mail.gmail.com>	<4CD885DD.7020909@ti.com> <AANLkTi=JhdGqB-mXnvjT_Y4cCOu2i8bwfQyy=FAC1Chh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49801 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650Ab0KIAC7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 19:02:59 -0500
In-Reply-To: <AANLkTi=JhdGqB-mXnvjT_Y4cCOu2i8bwfQyy=FAC1Chh@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11/9/2010 12:48 AM, Ramirez Luna, Omar wrote:
> On Mon, Nov 8, 2010 at 5:21 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>>> I wrote this one from scratch, I didn't see that there were pieces to
>>> handle some stuff since the code is buried in a private tree.
>>
>> Not true at all... It was sent to l-o:
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32854.html
>
> I did review v3 of this patch set, care to point the exact place for
> mmu hwmod on this patch set. It seems [v2 5/7] had mailbox, but I
> don't think v3 made it to the list.

The patch itself may did not reach the list due to his size, that's why 
I added the link to the GIT.

Both dsp and ipu contain the mmu + cache related information.

static struct omap_hwmod omap44xx_dsp_hwmod
static struct omap_hwmod omap44xx_ipu_hwmod

At that time I didn't know how that stuff was supposed to be used by the 
driver. I already changed the structure a little bit based on Hari's 
comment, so if you do need mmu entry only, since that structure seems to 
handle only that, it might makes sense to rename them in order to 
consider them part of the mmu class.
It should be then mmu_dsp and mmu_ipu, because in that case, it will 
represent the mmu class instances for the dsp and the ipu.

I'm perfectly fine to update that part if needed.

Regards,
Benoit

>> And stored in a supposedly private tree, which appears to be public:
>> http://dev.omapzoom.org/?p=swarch/linux-omap-adv.git;a=summary
>
> I took whatever was in:
>
> http://dev.omapzoom.org/?p=integration/kernel-omap4.git;a=shortlog;h=refs/heads/L24.11

>
>> Please do not do any change on that code base, just use the original code
>> and update it if needed.
>
> Will do, as taken from the tree you mention.
>
> Regards,
>
> Omar

