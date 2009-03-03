From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH 0/1] Regarding enable_irq_wake() and disable_irq_wake()
	functions
Date: Tue, 3 Mar 2009 11:22:34 +0900
Message-ID: <4d34a0a70903021822k68c2d5d6wd6abffa54e641431@mail.gmail.com>
References: <4d34a0a70903021802q45707e62w5c4ccb14558c731e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:60537 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756073AbZCCCWg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 21:22:36 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3036993wfa.4
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2009 18:22:34 -0800 (PST)
In-Reply-To: <4d34a0a70903021802q45707e62w5c4ccb14558c731e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, David Brownell <david-b@pacbell.net>

On Tue, Mar 3, 2009 at 11:02 AM, Kim Kyuwon <chammoru@gmail.com> wrote:
> Hi,
>

> But this was not the real problem. Current enable_irq_wake and
> disable_irq_wake isn't working correctly since the set_wake field of
> omap_irq_chip is NULL.
>

Of course, thanks to Tony Lindgren's works, GPIO wake-up using
enable_irq_wake() and disable_irq_wake() is nicely working.

> Is these functions for the future implementation in OMAP?
>
> Anyway..., I removed it in the following patch, and I think this work
> can be done in other OMAP device driver which is using
> enable_irq_wake() and something like that.
>
> --
> Q1
>



-- 
Q1
