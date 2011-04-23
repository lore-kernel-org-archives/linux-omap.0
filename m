From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP4: SRAM: Fix warning: format '%08lx' expects type
 'long unsigned int'
Date: Sat, 23 Apr 2011 12:38:12 +0530
Message-ID: <4DB27ADC.6050105@ti.com>
References: <1301907896-30954-1-git-send-email-santosh.shilimkar@ti.com> <20110404091223.GA19854@n2100.arm.linux.org.uk> <4D9993AD.3080401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41012 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751738Ab1DWHIl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 Apr 2011 03:08:41 -0400
Received: by mail-gy0-f177.google.com with SMTP id 20so346101gyh.36
        for <linux-omap@vger.kernel.org>; Sat, 23 Apr 2011 00:08:41 -0700 (PDT)
In-Reply-To: <4D9993AD.3080401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

On 4/4/2011 3:17 PM, Santosh Shilimkar wrote:
> On 4/4/2011 2:42 PM, Russell King - ARM Linux wrote:
[....]

> Thanks for pointing out this. I see Will's commit on this
> one "29a38193"
> Here is the updated patch as you suggested.

Are you considering this patch and another one [1] for the -rc's?

Regards
Santosh
[1] http://eeek.borgchat.net/lists/linux-omap/msg49557.html
