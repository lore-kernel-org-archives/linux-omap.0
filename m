From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: ehci-omap patches (Was Re: [PATCH 0/5] [RESEND] lm8323 patches)
Date: Fri, 20 Feb 2009 12:38:09 +0200
Message-ID: <6ed0b2680902200238o7b069a4fv8acb083b9771823e@mail.gmail.com>
References: <1235046583-29696-1-git-send-email-me@felipebalbi.com>
	 <20090219203251.GG20723@frodo> <20090219210429.GB7414@atomide.com>
	 <20090219211820.GJ20723@frodo> <20090219212927.GE7414@atomide.com>
	 <5e088bd90902191443s2ab4cc0bkc7ae51ffdef4fd71@mail.gmail.com>
	 <20090219224636.GH32564@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:51448 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180AbZBTKiL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 05:38:11 -0500
Received: by mu-out-0910.google.com with SMTP id i10so581814mue.1
        for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 02:38:09 -0800 (PST)
In-Reply-To: <20090219224636.GH32564@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Feb 20, 2009 at 12:46 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Thu, Feb 19, 2009 at 02:43:36PM -0800, Steve Sakoman wrote:
>> EHCI omap driver definitely needs some work - there is machine
>> specific stuff in there that rightfully belongs in platform data.  I
>> haven't had time to work on it :-(
>
> For sure, and there's still workaround for clk framework stuff that
> should already move there.
>
> I'll try to start with some cleanups already during this weekend (yeah,
> I've got no life :-p) and post as RFT asap. After the cleanups are ok,
> then I'll start moving platform code out of there and for the clock
> workarounds I'll need help from Paul Walmsley, probably :-)

Great, I'll be watching the list and gladly test them on pandora too.
It would be nice to have those remote wakeup issues [1] sorted out
too.

1: http://marc.info/?l=linux-omap&m=122911571519657&w=2
