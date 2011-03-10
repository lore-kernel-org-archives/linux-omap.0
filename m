From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Thu, 10 Mar 2011 18:28:36 +0530
Message-ID: <4D78CAFC.4080502@ti.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com> <4D775418.6050105@ti.com> <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:53955 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752285Ab1CJNEh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 08:04:37 -0500
Received: by mail-yw0-f45.google.com with SMTP id 41so844573ywl.18
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 05:04:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Hi Paul,

On Thursday 10 March 2011 05:48 PM, Paul Walmsley wrote:
> This patch is currently breaking boot on OMAP4430 ES2.0 Pandaboard,
> so I've dropped it from the integration branch until it can be
> debugged.  Could you check it, please?
>
> The tag "integration-2.6.39-20110310-008" of
> git://git.pwsan.com/linux-integration boots fine; it's got everything
> but this patch.  Then when this patch is applied, I2C problems show
> up, and root (on MMC) doesn't mount.

Looks like you are missing this patch which should fix the i2c
timeouts..
http://marc.info/?l=linux-omap&m=129924561819873&w=2

regards,
Rajendra



