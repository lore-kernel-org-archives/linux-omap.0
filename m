From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 13/16] omap: mux: Mux Apollon LCD power in board-apollon.c
Date: Thu, 1 Jul 2010 19:41:16 +0900
Message-ID: <AANLkTimbk7NP6VFT0WZAsBKVuY5jMZ3omNwhl7kR7b5A@mail.gmail.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
	<20100630120719.2637.65586.stgit@baageli.muru.com>
	<1277967954.2474.269.camel@tubuntu.research.nokia.com>
	<004d01cb18f5$ff27be80$fd773b80$%park@samsung.com>
	<20100701103359.GI2822@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33337 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab0GAKlT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 06:41:19 -0400
Received: by pwi5 with SMTP id 5so93396pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Jul 2010 03:41:16 -0700 (PDT)
In-Reply-To: <20100701103359.GI2822@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Jul 1, 2010 at 7:33 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Kyungmin Park <kyungmin.park@samsung.com> [100701 11:12]:
>> Hi,
>>
>> This value is set from bootloader, and kernel side only change the mode.
>> Right it runs by luck.
>
> So should we just drop the omap_cfg_reg for now, then add it back
> later with proper gpio_request etc?

I mean the original patch is okay. Now that's find. I'll send a patch
if require.

Thank you,
Kyungmin Park
