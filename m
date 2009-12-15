From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 03/17] DSPBRIDGE: Enable/Disable MCBSP_CLOCKS for MCBSP2
Date: Tue, 15 Dec 2009 20:26:56 +0200
Message-ID: <94a0d4530912151026i533d4b5dt81247c163b512d33@mail.gmail.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
	 <1260857998-19349-4-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:59445 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760833AbZLOS05 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 13:26:57 -0500
Received: by iwn1 with SMTP id 1so105969iwn.33
        for <linux-omap@vger.kernel.org>; Tue, 15 Dec 2009 10:26:57 -0800 (PST)
In-Reply-To: <1260857998-19349-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

On Tue, Dec 15, 2009 at 8:19 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> From: Fernando Guzman Lugo <x0095840@ti.com>
>
> Enable/Disable McBSP_CLOCKS when McBSP2 is requested
> so DPLL can be gated.

I'm guessing this means you found a bug and this patch fixes it. This
can be clarified on the commit message, right?

-- 
Felipe Contreras
