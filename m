From: twebb <taliaferro62@gmail.com>
Subject: Re: [PATCH OMAPZOOM] OMAP: DMA: Fix CCR programming for request line > 63
Date: Thu, 8 Jan 2009 09:08:25 -0500
Message-ID: <dbdb2ea60901080608y7ff19f50j6399f07619f05eb9@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02DF30302E@dbde02.ent.ti.com>
	 <FCCFB4CDC6E5564B9182F639FC356087024A0ADF11@dbde02.ent.ti.com>
	 <20090108133119.GH27566@atomide.com>
	 <dbdb2ea60901080540k740b7a9dscd940bcd0c9f6c01@mail.gmail.com>
	 <20090108135233.GL27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:53800 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbZAHOI0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 09:08:26 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4602931wah.21
        for <linux-omap@vger.kernel.org>; Thu, 08 Jan 2009 06:08:25 -0800 (PST)
In-Reply-To: <20090108135233.GL27566@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

>
> Well l-o tree is short for the linux-omap tree. Then I have various
> queues of stuff going into the mainline kernel:
>
> omap-fixes
> omap-upstream
> omap1-upstream
> omap2-upstream
> omap3-upstream
> ...
>
> Out of these queues omap-fixes will be sent out as needed during the
> -rc cycle, while omap*-upstream queues are stuff for the next merge
> window.
>
> These branches show up at the git web interface at the bottom:
>
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary
>
> Not that many patches in these queues right now, btw.
>

That's very helpful.  Would you mind confirming/answering a few more questions?

1.  Generally, are all fixes/changes that go to any of the queues
headed to the mainline always pushed into the l-o tree?  If not, why
not?
2.  How about the reverse - are all l-o fixes/changes eventually
queued to mainline?  Or is there certain l-o functionality that won't
ever go to mainline?
3.  By "merge window" do you mean times that you pull mainline updates
down into l-o tree?

Thanks.
