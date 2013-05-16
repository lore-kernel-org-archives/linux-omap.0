From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] ARM: omap2: remove CONFIG_ARCH_OMAP2PLUS_TYPICAL
Date: Thu, 16 May 2013 10:19:49 -0500
Message-ID: <CAL_JsqJgc39YO3-L=-kgJ=wmXhe-dAP5nHngaCLbxfheAEvduA@mail.gmail.com>
References: <1368710950-2306-1-git-send-email-robherring2@gmail.com>
	<20130516151126.GP5600@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:52253 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab3EPPTu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 11:19:50 -0400
Received: by mail-qe0-f52.google.com with SMTP id 1so1969666qec.39
        for <linux-omap@vger.kernel.org>; Thu, 16 May 2013 08:19:49 -0700 (PDT)
In-Reply-To: <20130516151126.GP5600@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, May 16, 2013 at 10:11 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Rob Herring <robherring2@gmail.com> [130516 06:34]:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> CONFIG_ARCH_OMAP2PLUS_TYPICAL is selecting user defined features, not h/w
>> required options. This does not play well with multi-platform kernels and
>> belongs in a defconfig.
>
> Yes we can remove this. But let's update omap2plus_defconfig with these
> options where needed. I can update this patch for that and queue it
> if that works for you.
>

Yes, that's fine. You might also want to enable the h/w related
features to multi_v7_defconfig as well.

Rob
