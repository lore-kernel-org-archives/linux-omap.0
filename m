From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: 2.6.37-omap1 tag?
Date: Wed, 12 Jan 2011 19:03:17 +0100
Message-ID: <CA2B2459-D659-4CA9-9D1C-09C65A37DDE6@dominion.thruhere.net>
References: <0C40218E-D65B-4DAE-ABBB-0CB1A02A0E5E@dominion.thruhere.net> <0a8f7e11ed463078411f7692ea233a92@mail.gmail.com> <20110111163454.GS4957@atomide.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45915 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab1ALSDV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 13:03:21 -0500
Received: by ewy5 with SMTP id 5so432928ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Jan 2011 10:03:20 -0800 (PST)
In-Reply-To: <20110111163454.GS4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, l-o List <linux-omap@vger.kernel.org>


Op 11 jan 2011, om 17:34 heeft Tony Lindgren het volgende geschreven:

> * Anand Gadiyar <gadiyar@ti.com> [110111 03:04]:
>> Koen Kooi wrote:
>>> Are there any plans to do a 2.6.37-omap1 tag?
>> 
>> Given that linux-omap is now closely tracking mainline, is
>> this still needed?
> 
> Those tags are no longer needed, the mainline kernel is now the
> stable kernel and should be used as the base for any distros
> or products.

It turns out that l-o head (.37-rc8 currently) and Linus' .37 differ a lot, so after spending an evening fruitlessly trying to rebase my patches on top of Linus' .37 I decided to go the other way and just do 'git format-patch v2.6.37-rc8..v2.6.37', apply those on top of l-o rc8 and then rebase my patchset on top of that. That was 5 minutes of work.

regards,

Koen