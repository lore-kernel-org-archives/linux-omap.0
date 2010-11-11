From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [PATCH 6/6] omap:clocks44x-add dummy clock for mailbox
Date: Wed, 10 Nov 2010 19:37:15 -0600
Message-ID: <AANLkTimD-dzC_UhJTK7=BZ27cMWRqy49LwOuVJxGz4hx@mail.gmail.com>
References: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com>
	<1289393121-7911-7-git-send-email-h-kanigeri2@ti.com>
	<alpine.DEB.2.00.1011101626570.28301@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62356 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab0KKBhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 20:37:16 -0500
Received: by gyh4 with SMTP id 4so901336gyh.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 17:37:15 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1011101626570.28301@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Paul,

On Wed, Nov 10, 2010 at 5:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Hari
>
> On Wed, 10 Nov 2010, Hari Kanigeri wrote:
>
>> In omap4, there is no explicit configuration register to enable mailbox clocks.
>> Defining dummy clock for mailbox clock module to keep the mailbox driver
>> backward compatible with previous omaps.
>
> If you split this off from the rest of your series, I'll queue it for .38.
>

Thanks. I will send this patch separately.

Best regards,
Hari
