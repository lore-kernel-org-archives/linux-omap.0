From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/2] omap: mailbox: hwmod experiment
Date: Mon, 24 May 2010 22:33:47 +0300
Message-ID: <AANLkTimci9dfIUXNpLb32r_Hbk2KegnVZnNKvr-3V2j9@mail.gmail.com>
References: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
	 <AANLkTimiCIA7Bx3mWcFBl6UMWSYMEEufDkAUcidnQ_i_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61838 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab0EXTdt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 15:33:49 -0400
Received: by bwz7 with SMTP id 7so1200493bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 12:33:47 -0700 (PDT)
In-Reply-To: <AANLkTimiCIA7Bx3mWcFBl6UMWSYMEEufDkAUcidnQ_i_@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

On Mon, May 24, 2010 at 8:29 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Sat, May 22, 2010 at 8:25 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> I played a bit with omap_hwmod/omap_device for the mailbox, and this is the
>> result.
>
> Nice move Felipe :)

Thanks :)

> Can you convert this to use the runtime PM layer, instead of directly
> calling omap_device functions via pdata ?

Well, I didn't see anybody using omap_device, so I just assumed from
reading the code.

Recently I saw some patches using this pm_runtime stuff, but it seems
to be for some pm branch... not sure which one.

-- 
Felipe Contreras
