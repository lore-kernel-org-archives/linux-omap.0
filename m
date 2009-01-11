From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 0/3] Add support for OMAP35x processors
Date: Sat, 10 Jan 2009 22:30:04 -0800
Message-ID: <5e088bd90901102230r11962ee8u54675b109f60dd0e@mail.gmail.com>
References: <1231513323-27379-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:41322 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZAKGiW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Jan 2009 01:38:22 -0500
Received: by fk-out-0910.google.com with SMTP id 18so5112310fkq.5
        for <linux-omap@vger.kernel.org>; Sat, 10 Jan 2009 22:38:19 -0800 (PST)
In-Reply-To: <1231513323-27379-1-git-send-email-premi@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Fri, Jan 9, 2009 at 7:02 AM, Sanjeev Premi <premi@ti.com> wrote:
> These patches provide support for the OMAP35x processors.
>
> This is essentially a re-submit after series of discusions
> earlier in the list. It had always been getting pushed in
> my to-do list :(
> See: http://marc.info/?l=linux-omap&m=122029900603111&w=2
>
> Based on the comments received, this patch includes following:
>  1) Updates to Kconfig
>  2) Runtime check for OMAP35x
>  3) Updates to omap3_evm_defconfig

Perhaps I'm being a bit clueless, but I'm not sure I see the benefit
of specifying in the kernel config whether the OMAP SOC is a 3503,
3515, 3525, or 3530.

The processor is the same ARM Cortex-A8 in all cases.  Code that may
want to use the graphics accelerator or DSP can easily check for the
presence of each at run time (Control OMAP Status Register @
0x4800244C)

Is there something I am missing?

Steve
