From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Wed, 16 Feb 2011 11:22:09 +0530
Message-ID: <AANLkTi=3PCBOvFtd1T-=tDjXcs+_0opKqxVps+StCZqf@mail.gmail.com>
References: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com>
	<20110215171652.601c9c68.jhnikula@gmail.com>
	<20110215172931.3a6e45a8.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:43311 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751330Ab1BPFwL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 00:52:11 -0500
Received: by mail-bw0-f41.google.com with SMTP id 16so1246056bwz.14
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 21:52:10 -0800 (PST)
In-Reply-To: <20110215172931.3a6e45a8.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org

On Tue, Feb 15, 2011 at 8:59 PM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> On Tue, 15 Feb 2011 17:16:52 +0200
> Jarkko Nikula <jhnikula@gmail.com> wrote:
>
>> Would it make more sense to set only the flag here and do the register
>> writes when omap3_twl_init is executing? Then it's not so strict when
>> the board code calls this function.
>>
> Probably discussed earlier but would it make more sense to have flag in
> struct twl4030_platform_data and to do registers writes in twl-core?
> Looks suspicious to have i2c_writes under arch/arm/.
twl_i2c_read/write APIs are used from arch/arm in many board files,
so I think it should not cause any issue.
> --
> Jarkko
>



-- 
Thanks,
Regards,
Shweta
