From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v9 4/4] OMAP: McBSP: Use cache when modifying individual
 register bits
Date: Mon, 18 Jan 2010 13:13:43 +0200
Message-ID: <20100118131343.7d763f8c.jhnikula@gmail.com>
References: <201001141658.32034.jkrzyszt@tis.icnet.pl>
	<201001151111.28462.peter.ujfalusi@nokia.com>
	<4B509B1F.2000302@tis.icnet.pl>
	<201001181005.12307.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41758 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768Ab0ARLMY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 06:12:24 -0500
Received: by ewy19 with SMTP id 19so391718ewy.21
        for <linux-omap@vger.kernel.org>; Mon, 18 Jan 2010 03:12:22 -0800 (PST)
In-Reply-To: <201001181005.12307.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 18 Jan 2010 10:05:12 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > What about introducing this simplification in a separate followup patch,
> > quoting your rationale in its changelog? I can try to prepare one if you
> > agree.
> 
> I think it is OK to have a followup patch addressing these.
> Just mention in a comment, that you are writing the cached value back to the 
> register, which does not have these status flags set, thus clearing the reason 
> in McBSP.
> 
> Jarkko: What do you think?
> 
I agree, follow-up patch sound cleaner and safer than modifying the
patch 4.

-- 
Jarkko
