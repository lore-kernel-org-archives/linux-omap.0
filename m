From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Sat, 25 Jun 2011 10:16:35 +0200
Message-ID: <86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net>
References: <1308932625-17632-1-git-send-email-premi@ti.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60106 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab1FYIQk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jun 2011 04:16:40 -0400
Received: by wyg8 with SMTP id 8so250092wyg.19
        for <linux-omap@vger.kernel.org>; Sat, 25 Jun 2011 01:16:38 -0700 (PDT)
In-Reply-To: <1308932625-17632-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>


Op 24 jun 2011, om 18:23 heeft Sanjeev Premi het volgende geschreven:

> The current selection of the GPTIMER on was result of
> a hardware issue in early versions of the Beagleboards
> (Ax and B1 thru B4). [1] [2]
> 
> Its been long since the hardware issue has been fixed.
> This patch uses GPTIMER 1 for all newer board revisions
> incl. Beagleboard XM.

What's the reason for switching away from gptimer12? Nothing in your patch or changelog says why.