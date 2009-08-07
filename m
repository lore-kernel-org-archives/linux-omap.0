From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH 2/2] OMAP: remove OMAP_TAG_UART
Date: Fri, 07 Aug 2009 09:03:09 +0300
Message-ID: <87tz0kma8y.fsf@litku.valot.fi>
References: <20090807051516.4787.36125.stgit@tikku>
	<20090807051650.4787.84433.stgit@tikku>
	<FCCFB4CDC6E5564B9182F639FC35608702F5988C18@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:62268 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbZHGGDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 02:03:11 -0400
Received: by bwz9 with SMTP id 9so1182711bwz.41
        for <linux-omap@vger.kernel.org>; Thu, 06 Aug 2009 23:03:10 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F5988C18@dbde02.ent.ti.com> (Vikram Pandita's message of "Fri\, 7 Aug 2009 11\:10\:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

>>Omap tags are deprecrated and convert all OMAP_TAG_UART cases to use
>>omap_uart_platform_data instead.
>>
>>Tested on rx51 and n8x0. Compile tested on omap_osk_5912.
>>
>>Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
>
> Any plans to remove OMAP_TAG_LCD

I don't have any plans, but I don't know about others.

-- 
Kalle Valo
