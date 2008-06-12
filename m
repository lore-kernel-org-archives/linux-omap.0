From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 0/4] Updates on mcbsp driver (take #2)
Date: Thu, 12 Jun 2008 12:14:08 -0700
Message-ID: <5e088bd90806121214q33f24c51t3dad859fc6b04a74@mail.gmail.com>
References: <1210022587-7756-1-git-send-email-edubezval@gmail.com>
	 <5e088bd90805190726v69f5d7coc9eebb65d915ff7a@mail.gmail.com>
	 <a0580c510805190809l58f507eck62a13f659524b969@mail.gmail.com>
	 <20080520142128.3498f258.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:54548 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758418AbYFLTOJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jun 2008 15:14:09 -0400
Received: by wa-out-1112.google.com with SMTP id j37so3002813waf.23
        for <linux-omap@vger.kernel.org>; Thu, 12 Jun 2008 12:14:09 -0700 (PDT)
In-Reply-To: <20080520142128.3498f258.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Chandra shekhar <x0044955@ti.com>, Eduardo Valentin <eduardo.valentin@indt.org.br>

Jarkko,

I've been using this patch with good results while developing an alsa
soc driver for the 35XX EVM and beagleboard.

Do you have plans to to officially submit this patch (or a more recent
version of it)?

Steve

On Tue, May 20, 2008 at 4:21 AM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> On Mon, 19 May 2008 11:09:43 -0400
> "ext Eduardo Valentin" <edubezval@gmail.com> wrote:
>
>> Hi Steve,
>>
>> This series is basically a simple transformation of currect mcbsp code
>> to a platform
>> driver and a separation of machine specific code.
>>
>> It should work for omap1 and omap2 (what is currently supported). But
>> it should add basic support  for omap3
>> mcbps 1 and 2. Chandra will send his patches on top of this series to
>> add more features for omap3.
>>
> For those who are keen to try ASoC on OMAP3 might want to try attached
> patch on top of Eduardo's set.
>
> I'll prepare better one when there are more ports defined. E.g.
> there is no need to separe omap34xx_dma_regs table since request
> numbers are the same between OMAP2 and OMAP3.
>
>
> Jarkko
>
