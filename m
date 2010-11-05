From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] omap: dsp: remove shm from normal memory
Date: Fri, 5 Nov 2010 19:53:30 +0200
Message-ID: <AANLkTi=4cT=JByCHmRiHBimoN55Kidt+deUhQLozGvez@mail.gmail.com>
References: <1287473844-6228-1-git-send-email-felipe.contreras@gmail.com>
	<1287473844-6228-2-git-send-email-felipe.contreras@gmail.com>
	<20101105163417.GI9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53956 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab0KERxc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 13:53:32 -0400
Received: by bwz11 with SMTP id 11so2903276bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 10:53:30 -0700 (PDT)
In-Reply-To: <20101105163417.GI9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>

On Fri, Nov 5, 2010 at 6:34 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Contreras <felipe.contreras@gmail.com> [101019 00:28]:
>> Also, don't be picky about the location.
>
> As this code is in CONFIG_TIDSPBRIDGE block and AFAIK that is
> not working, this should probably wait for the next merge window?

I plan to send a patch to revert the iommu changes to staging so that
it does work... But this patch would be needed as well.

-- 
Felipe Contreras
