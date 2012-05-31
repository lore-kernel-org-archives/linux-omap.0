From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/3] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
Date: Thu, 31 May 2012 16:28:51 -0700
Message-ID: <4FC7FEB3.3090107@deeprootsystems.com>
References: <1337369601-14915-1-git-send-email-nm@ti.com> <1337369601-14915-2-git-send-email-nm@ti.com> <874nqwx7gt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38368 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758643Ab2EaX2u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 May 2012 19:28:50 -0400
Received: by pbbrp8 with SMTP id rp8so2120104pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 16:28:50 -0700 (PDT)
In-Reply-To: <874nqwx7gt.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Wenbiao Wang <wwang@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/31/2012 04:21 PM, Kevin Hilman wrote:
>> diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
>> >  index 7c155d2..0abf895 100644
>> >  --- a/arch/arm/mach-omap2/vp.h
>> >  +++ b/arch/arm/mach-omap2/vp.h
>> >  @@ -31,7 +31,7 @@ struct voltagedomain;
>> >    #define OMAP4_VP_VDD_MPU_ID 2
>> >
>> >    /* XXX document */
>> >  -#define VP_IDLE_TIMEOUT		200
>> >  +#define VP_IDLE_TIMEOUT		500
> Were you planning to insert the comment here as suggested by Eduardo?

Oops, ignore this comment.  I see you posted a v3 with this added.

Sorry,

Kevin
