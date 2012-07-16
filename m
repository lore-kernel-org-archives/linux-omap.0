From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: omap2plus_defconfig: enable OMAP DMA
 engine support
Date: Tue, 17 Jul 2012 01:28:04 +0200
Message-ID: <CABxcv=nbUOKKhJxTG302fX=UzHsX3mN=R2nEi88VZM61ka11Vg@mail.gmail.com>
References: <1342321398-11009-1-git-send-email-javier@dowhile0.org>
	<87bojfeikj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40964 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab2GPX2E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jul 2012 19:28:04 -0400
Received: by obbuo13 with SMTP id uo13so10186824obb.19
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 16:28:04 -0700 (PDT)
In-Reply-To: <87bojfeikj.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Jul 16, 2012 at 7:12 PM, Kevin Hilman <khilman@ti.com> wrote:
> Javier Martinez Canillas <javier@dowhile0.org> writes:
>
>> commit 13f30fc893e4610f67dd7a8b0b67aec02eac1775
>> Author: Russell King <rmk+kernel@arm.linux.org.uk>
>> Date:   Sat Apr 21 22:41:10 2012 +0100
>>
>>     mmc: omap: remove private DMA API implementation
>>
>> removed the private DMA API implementation from the OMAP mmc host to
>> make it use exclusively the DMA engine API.
>>
>> Unfortunately the omap2plus_defconfig doesn't enable this feature
>> leading to the following error on an IGEPv2 Rev.C (and probably on most
>> boards with MMC support):
>
> Personally, I'd rather see this fixed by having the drivers that depend
> on DMA engine 'select DMADEVICES'.  That way, any defconfig will work
> correctly instead of just omap2plus_defconfig.
>
> Kevin
>

Hi Kevin,

Thanks a lot for your feedback. I'll do what you suggest and send a v2
of the patch.

Best regards,
Javier
