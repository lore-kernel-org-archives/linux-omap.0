From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH] OMAP2: add USB platform data and initialization for Nokia N800 and N810
Date: Wed, 30 Dec 2009 09:14:34 +0200
Message-ID: <87tyv9vspx.fsf@purkki.valot.fi>
References: <200912290152.16357.luke@dashjr.org>
	<200912290246.57663.luke@dashjr.org> <873a2uxip9.fsf@purkki.valot.fi>
	<200912291505.51230.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:56522 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbZL3HOi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 02:14:38 -0500
Received: by ey-out-2122.google.com with SMTP id 25so1657205eya.19
        for <linux-omap@vger.kernel.org>; Tue, 29 Dec 2009 23:14:37 -0800 (PST)
In-Reply-To: <200912291505.51230.luke@dashjr.org> (Luke-Jr's message of "Tue\, 29 Dec 2009 15\:05\:46 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

(dropping lkml)

"Luke-Jr" <luke@dashjr.org> writes:

> I think 4 or 5 files with ~350 lines is more manageable than a
> single 1700- line board file, especially when considering that parts
> depend on multiple configuration options (LCD, which turns out to be
> a 128-line file, depends on 3 config options: N8x0, Blizzard, and
> MIPID).

I tend to disagree. Scattering code to small files doesn't benefit
that much, just makes it harder to find code. IMHO a 2k line file is
perfectly acceptable and usable.

But if you really want smaller files, I'm not going to object. You're
the one doing the all work here :)

-- 
Kalle Valo
