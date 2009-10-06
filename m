From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on
 OMAP3430
Date: Tue, 6 Oct 2009 06:50:28 -0500
Message-ID: <4ACB2F04.2090608@ti.com>
References: <1254741761-31546-1-git-send-email-y> <87ljjpzs9p.fsf@deeprootsystems.com> <4ACA2C83.9080400@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB030A3321EF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60318 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932138AbZJFLvG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Oct 2009 07:51:06 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A3321EF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gulati, Shweta" <shweta.gulati@ti.com>

Gopinath, Thara had written, on 10/06/2009 01:59 AM, the following:
> The problem here is not with the restore. If MPU reads the PADCONF_SAVEDONE bit very close
> to the end of context save sequence for the pad conf registers, the last context is not
> saved to the scratchpad memory. This is a h/w bug. The workaround proposed is to delay the
> MPU access of SAVEDONE bit until the last context has been saved. 300 us delay is the current
> safe delay proposed by TI. I believe investigations are going on to whether this delay can be
> optimized. Also only the last context (ETK_D14) has the risk of not getting saved.
So, if I were to save specifically the ETK14 and restore it explicitly, 
I could in theory work around this issue.

> 
> We could add a defconfig option for this workaround and enable it on need basis till TI
> comes out with proper optimized workaround sequence.
we could probably hope to see a final patch then I believe?

Regards,
Nishanth Menon
