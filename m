From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt
 for AM33XX
Date: Sat, 03 Nov 2012 16:22:00 +0000
Message-ID: <509544A8.7010507@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33789 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab2KEEdR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Nov 2012 23:33:17 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so3633519pbb.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Nov 2012 20:33:16 -0800 (PST)
In-Reply-To: <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

On 11/02/2012 12:32 PM, Vaibhav Bedia wrote:
> AM33XX has only one usable timer in the WKUP domain.

After reading the TRM, it seems there are two: DMTIMER0 and DMTIMER1.

Looking at the hwmod data though, I don't see a hwmod for DMTIMER0.  Can
you explain a little about why DMTIMER0 is missing/broken?

Kevin
