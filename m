From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] staging: tidspbridge: request dmtimer clocks on init
Date: Thu, 8 Dec 2011 22:11:25 +0200
Message-ID: <CAMP44s16cSBw23Py7qUW4Oj60gXKuvmtx-c=urisxecMQEE6Dw@mail.gmail.com>
References: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35256 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab1LHUL0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 15:11:26 -0500
Received: by bkbzv3 with SMTP id zv3so2037921bkb.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 12:11:25 -0800 (PST)
In-Reply-To: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

On Sat, Nov 19, 2011 at 12:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> Given that dm timer framework doesn't support request of clocks
> by soft | hard irqs because some recent changes, tidspbridge needs
> to request its clocks on init and enable/disable them on demand.
>
> This was first seen on 3.2-rc1.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Tested-by: Felipe Contreras <felipe.contreras@gmail.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

Something the commit message didn't mention is that this fixes a nasty
continuous loop that happens as soon as you load the module.
Definitely 3.2-fix material IMO :)

Cheers.

-- 
Felipe Contreras
