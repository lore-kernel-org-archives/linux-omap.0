From: Kevin Hilman <khilman@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Mon, 30 Apr 2012 15:25:53 -0700
Message-ID: <871un4q2ku.fsf@ti.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com>
	<CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
	<20120403094749.GH17741@mudshark.cambridge.arm.com>
	<CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
	<20120403123444.GL17741@mudshark.cambridge.arm.com>
	<878vicsxef.fsf@ti.com>
	<20120403160706.GP17741@mudshark.cambridge.arm.com>
	<87ehs4pfw4.fsf@ti.com>
	<alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
	<20120404111524.GF32505@mudshark.cambridge.arm.com>
	<20120426180719.GC20186@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46110 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756647Ab2D3W0B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 18:26:01 -0400
Received: by dadz14 with SMTP id z14so16515259dad.17
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 15:25:59 -0700 (PDT)
In-Reply-To: <20120426180719.GC20186@mudshark.cambridge.arm.com> (Will
	Deacon's message of "Thu, 26 Apr 2012 19:07:19 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Will,

Will Deacon <will.deacon@arm.com> writes:

> On Wed, Apr 04, 2012 at 12:15:24PM +0100, Will Deacon wrote:
>> On Wed, Apr 04, 2012 at 12:29:49AM +0100, Paul Walmsley wrote:
>> > 
>> > Part of the problem is that the clockdomain data for the emu_sys 
>> > clockdomain is wrong.  Here's something to try to fix it.  It might just 
>> > be enough to get it to work.
>> 
>> Hmm, doesn't seem to work but I do see the following in dmesg when I try to
>> use perf:
>> 
>>  powerdomain: waited too long for powerdomain emu_pwrdm to complete transition
>> 
>> which is new with your patch.
>
> Sorry to nag, but does anybody have a clue where to go from here? I can
> start digging in the OMAP PM code, but it's all new territory for me.

Unfortunately, digging in the code isn't going to help much.  

We've been trying to get our heads around some undocumented reset
behavior for the various debug IPs in OMAP.

After a little digging and clarification from HW designers, it appears
that if we allow the EMU clockdomain to idle, a full reset of the debug
IPs is done.  That means there are two solutions to this problem:

1) don't ever alow EMU clockdomain to idle.
2) modify CTI driver to re-init for every use.

Obviously (1) is the easiet, and hacks for that have already been
posted, but that has pretty significant impacts on power savings.  (2)
is the right solution to merge upstream, but needs writing. 

For (2), using runtime PM methods in the driver would be the simplest
here since the ->runtime_resume method will be called every time the
device is about to be used.

Kevin
