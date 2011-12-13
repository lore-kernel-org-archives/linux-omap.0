From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: Trying to boot Panda with DT
Date: Tue, 13 Dec 2011 18:55:52 +0530
Message-ID: <4EE75260.3070700@ti.com>
References: <1323781385.1877.75.camel@deskari> <4EE7512C.6010207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:32898 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942Ab1LMN0A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 08:26:00 -0500
Received: by mail-yw0-f45.google.com with SMTP id g71so414952yhg.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 05:25:59 -0800 (PST)
In-Reply-To: <4EE7512C.6010207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap mailing list <linux-omap@vger.kernel.org>

On Tuesday 13 December 2011 06:50 PM, Cousson, Benoit wrote:
>
> I've just sent a patch to add the default DT config for OMAP. It will
> add these config into the OMAP2plus Kconfig.
>
> +    select USE_OF
> +    select ARM_APPENDED_DTB
> +    select ARM_ATAG_DTB_COMPAT
> +    select PROC_DEVICETREE
>
> In theory ARM_APPENDED_DTB and ARM_ATAG_DTB_COMPAT should not be needed
> in your case but only for legacy u-boot.
> It should not messed up the DT in case of DT aware uboot, but it worst
> checking if this is the case.

I don't think thats a problem as I have those options enabled and am
able to boot with the DT aware uboot.
