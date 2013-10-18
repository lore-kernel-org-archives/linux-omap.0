From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP1: Fix a bunch of GPIO related section warnings after initdata got corrected
Date: Fri, 18 Oct 2013 10:54:59 -0700
Message-ID: <87vc0uv4zw.fsf@linaro.org>
References: <20131018160358.GL15154@atomide.com>
	<20131018161017.GO15154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:61260 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409Ab3JRRzD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 13:55:03 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so4891911pab.39
        for <linux-omap@vger.kernel.org>; Fri, 18 Oct 2013 10:55:02 -0700 (PDT)
In-Reply-To: <20131018161017.GO15154@atomide.com> (Tony Lindgren's message of
	"Fri, 18 Oct 2013 09:10:18 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Tony Lindgren <tony@atomide.com> writes:

> * Tony Lindgren <tony@atomide.com> [131018 09:04]:
>> From: Tony Lindgren <tony@atomide.com>
>> Date: Fri, 18 Oct 2013 08:54:16 -0700
>> Subject: [PATCH] ARM: OMAP1: Fix a bunch of GPIO related section warnings after initdata got corrected
>
> Oops, sorry duplicate header. Below is a clean version that
> should apply with git am --scissors.
>  
>> Arnd, Kevin, Olof, want to apply this directly on top of the fixes
>> I sent earlier?

Yup, I've applied this version to fixes-non-critical on top of your
other series. 

Thanks for the quick fix, and nice to see at least someone besides me
and Olof are looking at the automated build/boot output. :)

Kevin
