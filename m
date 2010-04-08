From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP4 keypad driver
Date: Thu, 08 Apr 2010 08:21:35 -0700
Message-ID: <87zl1e55s0.fsf@deeprootsystems.com>
References: <27F9C60D11D683428E133F85D2BB4A53043CB21399@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47941 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758732Ab0DHPVz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 11:21:55 -0400
Received: by gwb19 with SMTP id 19so1220719gwb.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Apr 2010 08:21:54 -0700 (PDT)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043CB21399@dlee03.ent.ti.com> (Abraham Arce's message of "Wed\, 7 Apr 2010 20\:16\:08 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Arce, Abraham" <x0066660@ti.com> writes:

> Hi,
>
> I need some help to figure out the best way to incorporate omap4 keypad in linux omap.
>
> First approach, I have a patch that creates a new file, omap4-keypad.c with the following implementations:
>
>  - Based on matrix keypac logic
>  - Using hwmod framework
>  - Using threaded irq

This approach sounds good to me.  New drivers should use threaded IRQs
wherever possible.

Kevin

> Second approach, to change existing omap-keypad.c to matrix keypad
>
> Not clear on the path to follow... Thanks for your comments.
>
> Best Regards
> Abraham
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
