From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
 	cache line size
Date: Mon, 11 May 2009 18:21:37 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2AF668B1@dlee03.ent.ti.com>
References: <1242017713-25795-1-git-send-email-Hiroshi.DOYU@nokia.com>
	 <1242017713-25795-2-git-send-email-Hiroshi.DOYU@nokia.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AF66245@dlee03.ent.ti.com>
	 <20090511.184705.116375196.Hiroshi.DOYU@nokia.com>
 <94a0d4530905110931i3b81b991x9b7686c5bda25ff8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53685 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756964AbZEKXVs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 19:21:48 -0400
In-Reply-To: <94a0d4530905110931i3b81b991x9b7686c5bda25ff8@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe,

> 
> IMHO the only sensible way to approach this is to create a new ioctl
> for a special restrictive mapping where user-space specifies if the
> memory area is read-only or write-only and the size must be the real
> size. This also has advantage that it does not break legacy
> applications. 

-- How are you planning to inform LCML about choosing this new ioctl as opposed to the regular one? Any ways, I think the ulMapAttr flag in DSPProcessor_Map function can be extended to provide the information about read-only or write-only. The only issue is with this we can enforce the checks on only the applications that set this check and it will not cover the buffer alignment issues with the applications that don't enforce this check.

>While we are at it, this new mapping could do
> PROC_ReserveMemory at the same time so that the user-space application
> doesn't get a chance to modify the pa.
>
-- What does PROC_ReserveMemory has to do with pa ?

Thank you,
Best regards,
Hari

