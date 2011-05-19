From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/5] OMAP: DSS2: configuring non-zero values for
 fir_hinc/fir_vinc
Date: Thu, 19 May 2011 09:34:24 +0300
Message-ID: <1305786864.1849.26.camel@deskari>
References: <1305783090-21214-1-git-send-email-amber@ti.com>
	 <1305783090-21214-3-git-send-email-amber@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:56520 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754521Ab1ESGe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 02:34:28 -0400
Received: by mail-ew0-f42.google.com with SMTP id 2so1433692ewy.1
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 23:34:27 -0700 (PDT)
In-Reply-To: <1305783090-21214-3-git-send-email-amber@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amber Jain <amber@ti.com>
Cc: linux-omap@vger.kernel.org, molnar@ti.com

On Thu, 2011-05-19 at 11:01 +0530, Amber Jain wrote:
> fir_hinc and fir_vinc can only have a non-zero value as per TRM.
> Hence removed the if...else condition and also made the necesary changes

Typo with necessary.

> caused as the result of the condition removal.

Here also a bit more description would help to understand the patch.

If the patch is not totally trivial, I think it's normally good to
provide at least two distinct parts in the description, which are
something like:
- The current state, and what's wrong with it
- What this patch does and why it fixes the thing

So here you should tell something like:
- FIR values can not have zero values as per TRM, and the current code
writes zero there when no scaling is used. However, when zero values are
written to FIR registers scaling is disabled, so it shouldn't cause any
problems, but it's still safer to fix it.
- The patch changes to code to write a calculated FIR value even when no
scaling is used (meaning FIR value of 1024), but the scaling enable bits
are still kept off if scaling is not needed.

Also, if it's not obvious, it's nice to mention if the patch should
change some functionality or not. In this case nothing should change.

And generally try not to refer to the code in a way that requires the
reviewer to read the patch before understanding the description, like
"Hence removed the if...else condition and also made the necesary
changes caused as the result of the condition removal". The sentence
doesn't make sense if you don't read the patch first, which is totally
not the point of the description.

Either say something like "removed the if..else condition used to do
this and that, which cause this and that, requiring changing that and
this", which may get a bit confusing. Usually it's better to speak in
higher level terms about what the patch does (not always, though),
something similar to what I wrote in the paragraph someway up there.

 Tomi


