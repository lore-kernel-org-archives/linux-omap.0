From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Mon, 14 Feb 2011 14:30:36 -0800
Message-ID: <87pqquz1tf.fsf@ti.com>
References: <1296798454-23755-1-git-send-email-shweta.gulati@ti.com>
	<874o861chl.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:46724 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750948Ab1BNWal (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 17:30:41 -0500
Received: by qwa26 with SMTP id 26so3303475qwa.28
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 14:30:40 -0800 (PST)
In-Reply-To: <874o861chl.fsf@ti.com> (Kevin Hilman's message of "Mon, 14 Feb
	2011 14:24:06 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>

Kevin Hilman <khilman@ti.com> writes:

> Shweta Gulati <shweta.gulati@ti.com> writes:
>
>> From: Thara Gopinath <thara@ti.com>
>>
>> Voltage control on TWL can be done using VMODE/I2C1/I2C_SR.
>> Since almost all platforms use I2C_SR on omap3, omap3_twl_init by
>> default expects that OMAP's I2C_SR is plugged in to TWL's I2C
>> and calls omap3_twl_set_sr_bit. On platforms where I2C_SR is not connected,
>> the board files are expected to call omap3_twl_set_sr_bit(false) to
>> ensure that I2C_SR path is not set for voltage control and prevent
>> the default behavior of omap3_twl_init.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Thara Gopinath <thara@ti.com>
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>
> Thanks, queueing for 2.6.39 (branch: for_2.6.39/pm-misc) 

Oops, not quite yet.

Please re-post one more time with linux-arm-kernel in Cc.

Thanks,

Kevin
