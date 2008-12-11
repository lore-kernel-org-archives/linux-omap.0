From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 12:38:10 +0200
Message-ID: <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
	 <1228926833.32014.162.camel@localhost.localdomain>
	 <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>
	 <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>
	 <20081211005733.GZ18138@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:64578 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205AbYLKKiK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 05:38:10 -0500
Received: by rv-out-0506.google.com with SMTP id k40so826021rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 02:38:10 -0800 (PST)
In-Reply-To: <20081211005733.GZ18138@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Steve Sakoman <sakoman@gmail.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

> Can you please post whatever patches you need to apply to make it work
> occasionally so others can also look at the issue?

For pandora, making infinite while loops finite doesn't help much,
kernel crashes later on. Steve had this too:
http://marc.info/?l=linux-omap&m=122378604027303&w=2

I did bisect and found that commit
8b1f0bd44fe490ec631230c8c040753a2bda8caa is causing the hang for me.
Reverting this makes EHCI work again on pandora.
http://marc.info/?l=linux-omap&m=122453174024860&w=2
