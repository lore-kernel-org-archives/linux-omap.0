From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Mon, 14 Feb 2011 14:26:07 -0800
Message-ID: <1297722367.23393.25.camel@vence>
References: <1296798454-23755-1-git-send-email-shweta.gulati@ti.com>
	 <874o861chl.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:39197 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750948Ab1BNWaf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 17:30:35 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so6574939fxm.5
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 14:30:34 -0800 (PST)
In-Reply-To: <874o861chl.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>

On Mon, 2011-02-14 at 14:24 -0800, Kevin Hilman wrote:
> Shweta Gulati <shweta.gulati@ti.com> writes:
> 
> > From: Thara Gopinath <thara@ti.com>
> >
> > Voltage control on TWL can be done using VMODE/I2C1/I2C_SR.
> > Since almost all platforms use I2C_SR on omap3, omap3_twl_init by
> > default expects that OMAP's I2C_SR is plugged in to TWL's I2C
> > and calls omap3_twl_set_sr_bit. On platforms where I2C_SR is not connected,
> > the board files are expected to call omap3_twl_set_sr_bit(false) to
> > ensure that I2C_SR path is not set for voltage control and prevent
> > the default behavior of omap3_twl_init.
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> 
> Thanks, queueing for 2.6.39 (branch: for_2.6.39/pm-misc) after one minor
> change below...
> 

This patch needs to be reposted one more time with linux-arm-kernel in
CC please.

Kevin


