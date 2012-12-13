From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: omap2plus_defconfig: enable twl4030 SoC audio
Date: Fri, 14 Dec 2012 00:58:53 +0100
Message-ID: <CAAwP0s2p+eSe5Xzip+vOtOhKFNsbdLsqcHy7CcFVv7O8CAXmdA@mail.gmail.com>
References: <1353979275-6237-1-git-send-email-javier.martinez@collabora.co.uk> <50B48EB2.1040804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:41096 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309Ab2LMX7O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Dec 2012 18:59:14 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so2894295oag.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Dec 2012 15:59:14 -0800 (PST)
In-Reply-To: <50B48EB2.1040804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Nov 27, 2012 at 10:58 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 11/27/2012 02:21 AM, Javier Martinez Canillas wrote:
>> Many TI OMAP SoC based boards that uses twl4030 as codec have
>> been updated to use the unified audio driver (omap-twl4030)
>> since they have similar audio setup.
>>
>> So, is good to have it built to add audio support to these boards.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>
> I also agree that it is a good practice to enable this in the defconfig.
>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>

Hi Tony,

Any comments on this patch?

Best regards,
Javier
