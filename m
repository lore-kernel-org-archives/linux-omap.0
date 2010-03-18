From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv6 2/2][RESEND] ASoC: TWL6040: Add twl6040 codec driver
Date: Thu, 18 Mar 2010 11:28:21 -0700
Message-ID: <87d3z1jxh6.fsf@deeprootsystems.com>
References: <1889FA7136B567478A67D4B0F85B0CCE662AC7F1@dlee06.ent.ti.com>
	<20100318181623.GG6142@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47685 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab0CRS2Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 14:28:24 -0400
Received: by pwi5 with SMTP id 5so784174pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 11:28:24 -0700 (PDT)
In-Reply-To: <20100318181623.GG6142@rakim.wolfsonmicro.main> (Mark Brown's message of "Thu\, 18 Mar 2010 18\:16\:23 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Thu, Mar 18, 2010 at 12:59:49PM -0500, Olaya, Margarita wrote:
>> From: Misael Lopez Cruz <x0052729@ti.com>
>> 
>> Initial version of TWL6040 codec driver.
>> 
>> The TWL6040 codec uses a proprietary PDM-based digital audio interface.
>> Audio paths supported are:
>
> I'm getting exactly the same results trying to apply this.  It looks
> like there's some MUA corruption going on here, 

In addition, checkpatch reports a pile of whitespace problems,
suggesting that all the tabs have been converted by spaces as well,
another sign of Outlook mis-behavior.

[...]

> Looks like MUA trouble.  From the message headers it looks like you
> might be using Outlook or something, I'm not sure what to suggest for
> that - enough folks at TI are submitting patches that something must've
> been worked out for your mail system.

Indeed, You need to get outlook out of the picture for sending patches.

Using git-format-patch + git-send-email directly to your SMTP servers
seems to be working well for others inside TI.

Kevin
