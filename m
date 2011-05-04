From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 0/2 v5] twl4030-madc driver
Date: Tue, 3 May 2011 21:11:55 -0700
Message-ID: <BANLkTik2B_w5Rn+Q-erPhQs6VbfrNz2mcA@mail.gmail.com>
References: <1298986926-31180-1-git-send-email-j-keerthy@ti.com>
	<20110302101512.GC16181@sortiz-mobl>
	<BANLkTimc6uz353DDb9Ent6s6WjfY7f-xuA@mail.gmail.com>
	<BANLkTi=zt1j_s1uDfjL=SRG6_LS1pa3xAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39106 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1EDEL4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 00:11:56 -0400
Received: by vxi39 with SMTP id 39so756803vxi.19
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 21:11:55 -0700 (PDT)
In-Reply-To: <BANLkTi=zt1j_s1uDfjL=SRG6_LS1pa3xAg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Tue, May 3, 2011 at 12:49 PM, J, KEERTHY <j-keerthy@ti.com> wrote:
> Hello Steve,
>
> Can you try adding this patch?

Thanks!

I tried the patch and it did indeed fix the issue.  We should try to
get this in mainline since the hwmon driver won't work without it.

Steve
