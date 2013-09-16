From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] arm: Fix build error with context tracking calls
Date: Mon, 16 Sep 2013 10:11:54 -0700
Message-ID: <CAGa+x84rpdixmi5crMYtbKxWZdcT1u12O6ooA6QQN7hwDnEThA@mail.gmail.com>
References: <20130909105115.GL25647@n2100.arm.linux.org.uk>
	<522DB86A.8010207@roeck-us.net>
	<alpine.LFD.2.03.1309091023440.20709@syhkavp.arg>
	<20130909160348.GB18975@roeck-us.net>
	<20130909203141.GM25647@n2100.arm.linux.org.uk>
	<20130909210203.GC28416@roeck-us.net>
	<alpine.LFD.2.03.1309091714420.20709@syhkavp.arg>
	<87y574g1fi.fsf@linaro.org>
	<20130913170331.GA8453@somewhere>
	<87mwnggwv4.fsf@linaro.org>
	<20130914141921.GB1718@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:42594 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab3IPRLz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Sep 2013 13:11:55 -0400
Received: by mail-wi0-f174.google.com with SMTP id hj3so3753490wib.7
        for <linux-omap@vger.kernel.org>; Mon, 16 Sep 2013 10:11:54 -0700 (PDT)
In-Reply-To: <20130914141921.GB1718@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Anil Kumar <anilk4.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Benoit Cousson <b-cousson@ti.com>

On Sat, Sep 14, 2013 at 7:19 AM, Frederic Weisbecker <fweisbec@gmail.com> wrote:
> On Fri, Sep 13, 2013 at 03:50:07PM -0700, Kevin Hilman wrote:
>> Frederic Weisbecker <fweisbec@gmail.com> writes:
>>
>> > On Tue, Sep 10, 2013 at 08:07:45AM -0700, Kevin Hilman wrote:
>> >> Nicolas Pitre <nicolas.pitre@linaro.org> writes:
>> >>
>> >> > Adding Kevin Hilman to the CC as he might be interested as well.
>> >>
>> >> Thanks, I'd already noticed this but was distracted getting arm-soc
>> >> changes ready for the merge window.  Looking into it now.
>> >
>> > Kevin, can you please try this patch? It built tested fine on ARM
>> > and live tested correctly on x86. There should be no problem but
>> > just in case.
>>
>> Tested-by: Kevin Hilman <khilman@linaro.org>
>>
>> Things are back to working again on ARM.  Thanks for the fix, and for
>> build testing on ARM.
>>
>> As you noticed to test on ARM, we still have to carry that patch to
>> drop that 'depends on 64BIT' in order to build/test this... any more
>> thoughts on what the remaining obstacles there are?
>
> I was mostly fine with your last patchset that enabled that +
> a few stuff to make it working on ARM. There were just a few details
> to polish. But I remember I sent detailed reviews, may be you missed them
> somewhow?

Hmm, looks like I missed those, but see them now.  I'll go back
through those and respin/resend.

Thanks,

Kevin
