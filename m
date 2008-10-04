From: twebb <taliaferro62@gmail.com>
Subject: Re: [PATCH 0/0] Add minimal omap34xx support
Date: Sat, 4 Oct 2008 08:42:18 -0400
Message-ID: <dbdb2ea60810040542n377bafc9sabec371c294e4151@mail.gmail.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com>
	 <dbdb2ea60810030852h67b898a8p13b716f2e6c746e6@mail.gmail.com>
	 <20081004070534.GB30190@muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:45599 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbYJDMmV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Oct 2008 08:42:21 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1024689wah.21
        for <linux-omap@vger.kernel.org>; Sat, 04 Oct 2008 05:42:19 -0700 (PDT)
In-Reply-To: <20081004070534.GB30190@muru.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, david-b@pacbell.net

>
> Yeah there is active development going on in linux-omap mailing list
> for the EVMs too. And Mistral's older 5912OSK is probably the best
> supported omap board in the mainline kernel.
>
> Basically adding new boards is just a question of adding the board-*.c
> file, and .config for the drivers to include. Some board of course
> have custom devices too.
>
> Anyways, we'll add more boards to the mainline kernel later on, but
> first we have to get the the minimal omap3 support working with
> mainline kernel.
>

I'm not really looking for OMAP35x EVM support in mainline, but in l-o
git.  And it seems like that's where it's not often mentioned/tested
against - but beagle, zoom, overo are.  In looking for 35x support, is
it wrong to focus on l-o git instead of mainline?  Won't support
always be in l-o first?

Thanks,
twebb
