From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 6/9] ARM: OMAP4+: Remove out of placed smp_wmb() in secondary
 wakeup code
Date: Thu, 21 Feb 2013 16:55:33 +0400
Message-ID: <51261945.4040508@cogentembedded.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com> <1361373527-21695-7-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:57879 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab3BUM4I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 07:56:08 -0500
Received: by mail-la0-f49.google.com with SMTP id fs13so8790886lab.36
        for <linux-omap@vger.kernel.org>; Thu, 21 Feb 2013 04:56:06 -0800 (PST)
In-Reply-To: <1361373527-21695-7-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Hello.

On 20-02-2013 19:18, Santosh Shilimkar wrote:

> The smp_wmb() here is out of placed

    s/placed/place/

> and redundant. So remove it. It is
> a left over of the pain_release

   Sure it's not 'pen_release'?

> cleanup mostly.

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

WBR, Sergei

