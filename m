From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: [PATCH] Temporary fix to boot OMAP1 based boards
Date: Wed, 24 Sep 2008 14:33:18 +0530
Message-ID: <dfeb90390809240203u47efbf88i58b42b4ee957a186@mail.gmail.com>
References: <dfeb90390809230823l7c37d15au49c5726c7510718c@mail.gmail.com>
	 <20080924.065137.142952786.Hiroshi.DOYU@nokia.com>
	 <dfeb90390809240005xadef43dhb78c8ae214baab64@mail.gmail.com>
	 <20080924071201.GE5222@atomide.com>
	 <20080924075959.GF5222@atomide.com>
	 <alpine.DEB.2.00.0809240202250.15312@utopia.booyaka.com>
	 <20080924080652.GG5222@atomide.com>
	 <alpine.DEB.2.00.0809240207480.15312@utopia.booyaka.com>
	 <20080924083446.GH5222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:36332 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbYIXJDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 05:03:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2609869rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 02:03:18 -0700 (PDT)
In-Reply-To: <20080924083446.GH5222@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@booyaka.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

On Wed, Sep 24, 2008 at 2:04 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Paul Walmsley <paul@booyaka.com> [080924 11:08]:
>> On Wed, 24 Sep 2008, Tony Lindgren wrote:
>>
>> > * Paul Walmsley <paul@booyaka.com> [080924 11:03]:
>> > > On Wed, 24 Sep 2008, Tony Lindgren wrote:
>> > >
>> > > > * Tony Lindgren <tony@atomide.com> [080924 10:12]:
>> > > > > * Arun KS <arunks@mistralsolutions.com> [080924 10:05]:
>> > > > > > On Wed, Sep 24, 2008 at 9:21 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>> > > > > > > Hi,
>> > > > > > >
>> > > > > > > How about introducing a new typedef in order to accommodate the
>> > > > > > > different size of enable_regs without ifdefs?
>> > > > > > >
>> > > > > > > I think that this is apparently the case categorized into (a) in
>> > > > > > > 'CodyingStyle'.
>> > > > > >
>> > > > > > I am not sure which is the right way to do. Is this what you meant?
>> > > > >
>> > > > > No, let's not do this. It should be void __iomem * for sure. Most of
>> > > > > the omap1 clock registers looks just fine for void __iomem *, let's
>> > > > > figure out which registers are broken.
>> > > >
>> > > > I've pushed a fix for this. Turns out I missed some conversions to
>> > > > void __iomem * while merging code from arm-devel branch. Fix also
>> > > > attached.
>> > >
>> > > Those registers should be u16 for OMAP2/3.  OMAP1 needs something similar,
>> > > which will also get rid of those casts to void __iomem * - hacking on
>> > > something now ...
>> >
>> > Argh, sorry. Yeah it's an offset for omap2/3.. Will revert immediately.
>>
>> No problem, it's really my fault - I need to start testing on OMAP1 also.
>
> How about this for a quick fix? It produces now a bunch of warnings
> until omap1 clock uses offsets too.

Tested, it works.

Its good to have this fix till omap1 clock uses offsets.

Arun

>
> Tony
>
>
