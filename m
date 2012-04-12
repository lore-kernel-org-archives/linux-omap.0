From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP4: Remove un-used control module headers
 and defines.
Date: Thu, 12 Apr 2012 16:01:40 +0530
Message-ID: <4F86AF0C.5060806@ti.com>
References: <1330338743-24097-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:41871 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753183Ab2DLKbr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 06:31:47 -0400
Received: by obbta17 with SMTP id ta17so1696313obb.29
        for <linux-omap@vger.kernel.org>; Thu, 12 Apr 2012 03:31:45 -0700 (PDT)
In-Reply-To: <1330338743-24097-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Benoit,

On Monday 27 February 2012 04:02 PM, Santosh Shilimkar wrote:
> Most of the OMAP4 control module register defines are not used and
> can be removed. Keep only needed defines and move them to common
> control module header just like other OMAP versions.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---

What do you think about this patch ?

Regards
Santosh
