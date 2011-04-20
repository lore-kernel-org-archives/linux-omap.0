From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
Date: Wed, 20 Apr 2011 19:42:21 +0400
Message-ID: <4DAEFEDD.1040106@ru.mvista.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46017 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab1DTPn7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Apr 2011 11:43:59 -0400
Received: by wya21 with SMTP id 21so720501wya.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Apr 2011 08:43:58 -0700 (PDT)
In-Reply-To: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Paul Wamsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

Hello.

On 20-04-2011 13:25, Shweta Gulati wrote:

> From: Gulati, Shweta<shweta.gulati@ti.com>

> Core Clk Tree shows incorrect Clk rates at OPP50, as
> in commit e07f469d284ca3d1f5dcf5438c22982be98bc071

    Please also specify that commit's summary -- for human readers.

> calling of 'recalc' in API clk_set_rate is unintentionally
> removed, because of which clock's tree rates get goofed
> up when DVFS happens. This Patch adds recalc API back.

> Tested on OMAP3630 SDP Board.

> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
> Cc: Rajendra Nayak<rnayak@ti.com>
> Cc: Paul Wamsley<paul@pwsan.com>

WBR, Sergei
