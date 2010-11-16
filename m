From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/3] OMAP: wd_timer: remove old, dead probing code
Date: Tue, 16 Nov 2010 15:47:59 +0300
Message-ID: <4CE27D7F.1030107@ru.mvista.com>
References: <20101116102205.27991.37909.stgit@twilight.localdomain> <20101116102518.27991.38133.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40769 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932581Ab0KPMtv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 07:49:51 -0500
Received: by ewy8 with SMTP id 8so207999ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 04:49:49 -0800 (PST)
In-Reply-To: <20101116102518.27991.38133.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha Varadarajan <charu@ti.com>

Hello.

On 16-11-2010 13:25, Paul Walmsley wrote:

> After commit f2ce62312650211f6cf665cd6dc519c334c4071e, watchdog

    Linus has asked to also specify the commit summary in parens...

> probing is handled by files in mach-omap1/ and mach-omap2/, and the
> plat-omap/devices.c probing code is no longer used.  Remove the dead
> code in plat-omap/devices.c.

> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Charulatha Varadarajan<charu@ti.com>

WBR, Sergei
