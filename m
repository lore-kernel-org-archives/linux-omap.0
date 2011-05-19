From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/5] OMAP: DSS2: Adds new registers for NV12 support
Date: Thu, 19 May 2011 09:45:18 +0300
Message-ID: <1305787518.1849.34.camel@deskari>
References: <1305783090-21214-1-git-send-email-amber@ti.com>
	 <1305783090-21214-5-git-send-email-amber@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:50914 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932304Ab1ESGpY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 02:45:24 -0400
Received: by wyg36 with SMTP id 36so1741003wyg.10
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 23:45:21 -0700 (PDT)
In-Reply-To: <1305783090-21214-5-git-send-email-amber@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amber Jain <amber@ti.com>
Cc: linux-omap@vger.kernel.org, molnar@ti.com

On Thu, 2011-05-19 at 11:01 +0530, Amber Jain wrote:
> Adds new register definitions and simple helper functions to configure them.

Remember that the subject and the description are separate things. Even
if you mention NV12 in the subject, the description also should be
"whole" and mention NV12, as the line above doesn't really say anything
what kind of registers are being added. And this is not only about NV12,
it's also about the new scaling config thingie for the old YUV modes.

And it wouldn't hurt to tell a bit more about the registers, as their
use is not very clear. The reader should of course look at the TRM to
get full understanding of the subject, but it would be good to briefly
explain the UV plane registers and how it affects things.

> Added these new registers to save/restore and DUMPREG fumction.
> Also adds two new features FEAT_HANDLE_UV_SEPARATE and FEAT_ATTR2.

What do the features do and on what platforms are they enabled?

 Tomi


