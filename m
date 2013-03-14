From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH 5/9] ARM: dts: Add GPMC node for OMAP2, OMAP4 and OMAP5
Date: Thu, 14 Mar 2013 12:57:44 -0300
Message-ID: <CALF0-+U76UpJ35hWpYGkLf5uDxfaZqcB_h-_JJdvapHSTQ0amg@mail.gmail.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
	<1362763654-9660-6-git-send-email-jon-hunter@ti.com>
	<CABxcv==OKX4z8x7ztqDJ5CozNmTQ5UaD43mTLWfQuqUt-y7xcQ@mail.gmail.com>
	<513A5B23.5070302@ti.com>
	<CABxcv=kEi9yKRCx56dt_GRwQ7aKvrRpwCAxO6BwH4_U6jp-=JA@mail.gmail.com>
	<CALF0-+Vp-WAQo3qtmK9jSHnLC0ECg4kUnEUz_PMNtgG1nEcGvQ@mail.gmail.com>
	<513E1ADC.6030208@ti.com>
	<5141F07E.3030501@ti.com>
	<5141F1C3.6090009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:64736 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab3CNP5p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 11:57:45 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so2203419iag.17
        for <linux-omap@vger.kernel.org>; Thu, 14 Mar 2013 08:57:44 -0700 (PDT)
In-Reply-To: <5141F1C3.6090009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 14, 2013 at 12:50 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>> Yes, I full agree with that as well. The size should be purely HW
>> related. So we should not take any assumption about the page size /
>> alignment.
>
> Ok, what is best to use? The size from hwmod structures or the size from
> the documentation?
>

My personal vote is: according to hardware documentation is the right thing,
and it's what we're doing in mvebu.

-- 
    Ezequiel
