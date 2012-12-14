From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: enable devtmpfs and devtmpfs automount
Date: Fri, 14 Dec 2012 19:16:31 +0100
Message-ID: <CAAwP0s1d4xPfYyaU+Cu=fH6YL5gmyYF+6x0aHOmNVeHshZ1ZeA@mail.gmail.com>
References: <1353504411-19811-1-git-send-email-javier.martinez@collabora.co.uk>
 <20121214181051.GY4989@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35371 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756958Ab2LNSQw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 13:16:52 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so3658677obb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Dec 2012 10:16:52 -0800 (PST)
In-Reply-To: <20121214181051.GY4989@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Dec 14, 2012 at 7:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [121121 05:29]:
>> Since udev-182, udev no longer creates device nodes under /dev
>> and this has to be managed by the kernel devtmpfs filesystem.
>>
>> This means that a kernel built with the current OMAP2+ config
>> will not boot on a system with a recent udev.
>>
>> Also, it is good to have /dev automatically mounted since some
>> non-initramfs based setups assumes this and don't manually mount it.
>
> Thanks applying into omap-for-v3.8/fixes-for-merge-window.
>
> Regards,
>
> Tony
>

Hi Tony,

I resend a v2 today: [PATCH v2 1/1] ARM: OMAP2+: omap2plus_defconfig:
enable devtmpfs and automount

That fixes an issue in the patch comments. Sekar Nori pointed out that
the first udev to make this a requirement was 176 not 182.
So probably is better if you can apply that one instead.

Thanks a lot and best regards,
Javier
