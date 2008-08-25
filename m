From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Mon, 25 Aug 2008 15:13:46 -0700
Message-ID: <5e088bd90808251513w608d82abpfc946679ae37f4b6@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	 <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
	 <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
	 <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
	 <20080825213510.GC14939@frodo>
	 <5e088bd90808251450p25bca40bpf810f135ddf91a73@mail.gmail.com>
	 <20080825215258.GF14939@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:37911 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbYHYWNq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 18:13:46 -0400
Received: by wa-out-1112.google.com with SMTP id j37so772510waf.23
        for <linux-omap@vger.kernel.org>; Mon, 25 Aug 2008 15:13:46 -0700 (PDT)
In-Reply-To: <20080825215258.GF14939@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com, Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Hmm, so the crash is actually somewhere else.

Yes, the assert is the first point at which you can detect that things
are going to go badly :-)  The actual crash happens two or three
function calls deeper when the first substream pointer dereference
occurs.

> Could you disable debug
> and get the NULL pointer dereference at the right point ?

Will do, compiling right now.

> I think it'll be easier to track down, maybe.

Maybe -- but the root cause of the crash is the null substream pointer
which was set way up the call chain.

I'll attach the new crash log in a few minutes when the build completes.

Steve
