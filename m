From: Bin Liu <binmlist@gmail.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Tue, 10 Mar 2015 09:35:32 -0500
Message-ID: <CADYTM3aRMboKrYrdoRAkeL1=J_Sfvgf3vDx_AEJa_qKfneQs9A@mail.gmail.com>
References: <20150309205157.GE5140@atomide.com>
	<CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
	<20150309211306.GC22341@saruman.tx.rr.com>
	<CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
	<20150309212014.GE22341@saruman.tx.rr.com>
	<20150309212622.GJ5264@atomide.com>
	<CADYTM3ZW5e5dCQbbaE02o7wxOC26+jo5Ddo+2B4Q6UCAT2pTdQ@mail.gmail.com>
	<20150309214129.GK5264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:42770 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbbCJOfd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2015 10:35:33 -0400
In-Reply-To: <20150309214129.GK5264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>

On Mon, Mar 9, 2015 at 4:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Bin Liu <binmlist@gmail.com> [150309 14:35]:
>> On Mon, Mar 9, 2015 at 4:26 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Felipe Balbi <balbi@ti.com> [150309 14:21]:
>> >> On Mon, Mar 09, 2015 at 04:17:29PM -0500, Bin Liu wrote:
>> >> > On Mon, Mar 9, 2015 at 4:13 PM, Felipe Balbi <balbi@ti.com> wrote:
>> >> > > On Mon, Mar 09, 2015 at 04:11:28PM -0500, Bin Liu wrote:
>> >> > >> Hi,
>> >> > >>
>> >> > >> On Mon, Mar 9, 2015 at 3:51 PM, Tony Lindgren <tony@atomide.com> wrote:
>> >> > >> > Add a minimal driver for dm816x USB. Otherwise we can just use
>> >> > >> > the existing musb_am335x and musb_dsps on dm816x.
>> >> > >>
>> >> > >> dm816x has the almost identical usbss as that in am335x, we should be
>> >> > >> able to adopt musb_am335x and musb_dsps for dm816x, and dm814x too?
>> >> > >
>> >> > > Tony's using the same musb glue layers, this is just a phy driver,
>> >> > > right ?
>> >> >
>> >> > Can the current am335x phy driver be adopted too? I remember it is
>> >> > under drivers/usb/phy/.
>> >>
>> >> Tony will be best to answer, but according to our IRC discussions, it's
>> >> too different. Tony ?
>> >
>> > Well we should check again between dm814x and am335x documentation
>> > against the $subject driver as the dm816x docs were buggy and I may
>> > have gotten a wrong idea initially.
>>
>> Will it make our life a little easier by comparing the usb drivers for
>> dm81xx and am335x in previous TI kernel releases? I cam dig out the
>> source code if that helps.
>
> Yeah that probably helps if you've dealt with dm814x earlier :)

Well, don't expect much from me about dm814x ;), I did not read its
trm nor errata, but only booted the board a few times trying to
compare the MUSB behaviours while debugging issues on am335x.

Ok, the previous TI released 3.2 kernel for am335x is at [1], and
2.6.37 kernel dm81xx is at [2].

Regards,
-Bin.

[1] http://arago-project.org/git/projects/?p=linux-am33x.git;a=shortlog;h=refs/heads/v3.2-staging

[2] http://arago-project.org/git/projects/?p=linux-omap3.git;a=shortlog;h=refs/heads/TI81XXPSP_04.04.00.01


> Just don't look at the dm816x trm, only the errata pdf works for
> dm816x phy.
>
> Note that we still are missing basic support for dm814x in mainline,
> I'm planning to tackle that at some point but I don't know when I'm
> going to get to it..
>
> Regards,
>
> Tony
