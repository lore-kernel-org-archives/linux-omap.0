From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] [RFC] OMAP4: clock: shrink clock data utilizing preprocessor.
Date: Fri, 13 May 2011 15:16:10 +0200
Message-ID: <87aaeq3fmt.fsf@ti.com>
References: <1305247077-15927-1-git-send-email-vzapolskiy@gmail.com>
	<20110513113013.GP31483@atomide.com>
	<BANLkTinNVbViwjAcrOqfR+-ZJ+i1DF9Hdw@mail.gmail.com>
	<4DCD2260.4090806@ti.com> <20110513130441.GH5323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45440 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758843Ab1EMNQP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 09:16:15 -0400
Received: by mail-fx0-f50.google.com with SMTP id 16so2286964fxm.23
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 06:16:13 -0700 (PDT)
In-Reply-To: <20110513130441.GH5323@atomide.com> (Tony Lindgren's message of
	"Fri, 13 May 2011 16:04:43 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Vladimir Zapolskiy <vzapolskiy@gmail.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Tony Lindgren <tony@atomide.com> writes:

> * Cousson, Benoit <b-cousson@ti.com> [110513 15:18]:
>> >>>Signed-off-by: Vladimir Zapolskiy<vzapolskiy@gmail.com>
>> >>
>> >Unfortunately I don't have an automated tool, but that would be great
>> >to have such a script. For this time I've checked the correctness of the
>> >change comparing the preprocessed output.
>> 
>> In fact these files are already generated automatically, as written
>> in the header file. So changing the output format should
>> straightforward. At least for OMAP4... OMAP2 and OMAP3 were done
>> manually some time ago.
>
> Sounds like the important thing to consider here is how these macros
> should be set up considering the upcoming generic clock framework
> and device tree changes.
>
> So let's wait a few days for comments from Benoit and Paul on the
> format for the macros so we don't need to redo them again later.
> Of course there might be other things to consider too..

... like readability.

After seeing the patch (thanks Benoit), I think this is bad tradeoff
between readability and lines-of-code.

Personally, I don't think we should be trading readability for diffstat
goodness.  I have a strong dislike for these multi-line macros, but
it's up to Paul/Benoit to decide how this should look.

Kevin


