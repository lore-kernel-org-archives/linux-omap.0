From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] board-omap3-beagle: add DSS2 support
Date: Wed, 14 Apr 2010 12:55:54 +0200
Message-ID: <8D24BD63-B543-4A7C-B2A4-34A3FCE7C0FF@dominion.thruhere.net>
References: <1271063990-12819-1-git-send-email-koen@dominion.thruhere.net> <1271068631.2690.40.camel@tubuntu.research.nokia.com> <h2r6ed0b2681004120415m118f3e7cy2b884cafed1cf737@mail.gmail.com> <A0DD0612-FF66-475A-B1BF-FD408012A510@dominion.thruhere.net> <1271241783.2690.218.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60294 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab0DNKz6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 06:55:58 -0400
Received: by wwb34 with SMTP id 34so712811wwb.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Apr 2010 03:55:57 -0700 (PDT)
In-Reply-To: <1271241783.2690.218.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


Op 14 apr 2010, om 12:43 heeft Tomi Valkeinen het volgende geschreven:

> On Tue, 2010-04-13 at 17:24 +0200, ext Koen Kooi wrote:
>> Op 12 apr 2010, om 13:15 heeft Grazvydas Ignotas het volgende geschreven:
>> 
>>> On Mon, Apr 12, 2010 at 1:37 PM, Tomi Valkeinen
>>> <tomi.valkeinen@nokia.com> wrote:
>>>> 
>>>> On Mon, 2010-04-12 at 11:19 +0200, ext Koen Kooi wrote:
>>>>> This patch adds DSS2 support to the beagleboard boardfile. DVI and TV-out are supported.
>>>>> 
>>>>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>>>> 
>>>> Fiddling with TWL directly in tv enable/disable functions is a bit ugly,
>>>> but I'm not sure if there's a better way for that. Otherwise:
>>> 
>>> It's only toggling VDAC supply, don't we already do that in DSS2 core?
>>> I think beagle_panel_enable_tv and beagle_panel_disable_tv can be
>>> simply removed.
>> 
>> I can send an updated patch with those bits removed if needed. Tomi?
> 
> Yes, all the comments from Grazvydas were valid.

OK, sent.

regards,

Koen