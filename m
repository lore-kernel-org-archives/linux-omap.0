From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: ehci-omap patches (Was Re: [PATCH 0/5] [RESEND] lm8323 patches)
Date: Thu, 19 Feb 2009 14:43:36 -0800
Message-ID: <5e088bd90902191443s2ab4cc0bkc7ae51ffdef4fd71@mail.gmail.com>
References: <1235046583-29696-1-git-send-email-me@felipebalbi.com>
	 <20090219203251.GG20723@frodo> <20090219210429.GB7414@atomide.com>
	 <20090219211820.GJ20723@frodo> <20090219212927.GE7414@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:41124 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbZBSWni (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 17:43:38 -0500
Received: by mu-out-0910.google.com with SMTP id i10so460413mue.1
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2009 14:43:36 -0800 (PST)
In-Reply-To: <20090219212927.GE7414@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Feb 19, 2009 at 1:29 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Balbi <me@felipebalbi.com> [090219 13:19]:
>> On Thu, Feb 19, 2009 at 01:04:30PM -0800, Tony Lindgren wrote:
>> > * Felipe Balbi <me@felipebalbi.com> [090219 12:58]:
>> > > On Thu, Feb 19, 2009 at 02:29:38PM +0200, Felipe Balbi wrote:
>> > > > Hi Tony,
>> > > >
>> > > > the final version is already going to mainline via linux-input,
>> > > > you might wanna apply these to l-o to avoid conflicts later.
>> > >
>> > > mainline had a few comments to this driver which will come as an extra
>> > > cleanup patch since there's no functionality change, only style changes
>> > > so far.
>> > >
>> > > These should be safe to apply.
>> >
>> > OK, will push today.
>>
>> Cool thanks, now that we're in the "push drivers upstream season", what
>> abou the ehci driver ? Did you get any patches from TI tony ? I asked
>> you to drop some patches from me because they said they would come up
>> with a better solution. If I get a board to test ehci, I'll push that
>> driver upstream as well, it's been too long waiting and TI still didn't
>> give us the patches for ehci, nor ohci.
>
> No patches from TI :( It would be nice to get that driver into the
> out of the linux-omap tree.

EHCI omap driver definitely needs some work - there is machine
specific stuff in there that rightfully belongs in platform data.  I
haven't had time to work on it :-(

Steve
