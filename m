From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 2/2] omap3: pandora: add NAND and wifi support
Date: Mon, 5 Jul 2010 14:54:29 +0300
Message-ID: <AANLkTikp8ss_lFzSV25k72xHvE1vDFQto3Byjw4Oev24@mail.gmail.com>
References: <1278014301-24645-1-git-send-email-notasas@gmail.com>
	<1278014301-24645-3-git-send-email-notasas@gmail.com>
	<20100705100542.GQ15951@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52874 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab0GELya (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 07:54:30 -0400
Received: by gwj21 with SMTP id 21so654168gwj.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Jul 2010 04:54:29 -0700 (PDT)
In-Reply-To: <20100705100542.GQ15951@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Mon, Jul 5, 2010 at 1:05 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Grazvydas Ignotas <notasas@gmail.com> [100701 22:52]:
>> Add platform data for NAND and wifi, also setup all GPIOs
>> needed to use the wifi chip.
>
> I've applied this after tweaking it a bit to apply as the
> SDIO series is getting merged via Andrew. Updated patch
> below.

Thanks, but the card will not probe without the .ocr_mask part. We could either:
- take mmc patches 2 and 3 through linux-omap (they don't really
depend on patch 1) and ask Andrew to drop them
- I could send one-liner fix after the merge window for -rc or next
merge window in the worst case

both are ok with me.
