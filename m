From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: DSP Bridge video decode of above VGA videos
Date: Mon, 22 Nov 2010 15:42:32 -0600
Message-ID: <AANLkTim6++ATTJ=BCssvLYKRek0EXKVPMGgKH1WMNuRM@mail.gmail.com>
References: <AANLkTim2PQ9kAvSi12987gAykMAuPg7f3XM3zQNo5Tip@mail.gmail.com>
	<AANLkTinCT-zQaGyLfS-NZU9Pue+2hmrLDckHYKqD_u8m@mail.gmail.com>
	<AANLkTimhKaS4y+k0t_x39aw8LvO-tNUH-=x3V9jk7BsC@mail.gmail.com>
	<AANLkTi=71zFhuBh3MArYjSEvJ+YXciF_9d2cn+5ojTb6@mail.gmail.com>
	<AANLkTinkMPb4Htv4GN8--PZP0UdkWuyXiLYvRC3QasWD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:60746 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754424Ab0KVVmy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 16:42:54 -0500
Received: by wyj26 with SMTP id 26so8713201wyj.18
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 13:42:33 -0800 (PST)
In-Reply-To: <AANLkTinkMPb4Htv4GN8--PZP0UdkWuyXiLYvRC3QasWD@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: James Adams <james.r.adams@gmail.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org

James,

On Mon, Nov 22, 2010 at 11:12 AM, James Adams <james.r.adams@gmail.com> wrote:
> Hi Rene,
>
> We have got the watchdog timer enabled at the moment (interval 5 seconds).
> The code does indeed point to the line as you say.
> I tried using dump_stack and it was getting triggered by an interrupt
> calling handle_hibernation_fromDSP which then called functions
> eventually triggering the SYNC_entercs (via DEV_getfirst if I remember
> right)
> I certainly don't understand why this should happen, but it seems to
> happen quite a lot (probably every 5 seconds...) and the lower
> resolution videos didn't seem to mind so I have been ignoring it.
>

Looking at the drivers/dsp/bridge/wmd/tiomap3430_pwr.c file tagged
with L25.12 release at [1]  I don't see feasible the path to have
handle_hibernation_fromDSP() to get to SYNC_entercs(), so probably you
have a newer or older version of the file.

Basically what i was looking with those assertions is to see if those
could be because of  a DSP WDT overflow. Also those assertions can
fail because of the calling of IO_DispatchMsg by io_dpc(), if that's
the case there should not be a problem. On the other hand if there is
a WDT overflow those assertions could also fail.

Can you double check by printing the call stack again when the
assertion fails, just to see why for your case
handle_hibernation_fromDSP() is failing in the assertion?

> Is it a bad idea to use WDT?

No,  it is ok  to use it.

Regards,
Rene Sapiens
--
[1] http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=drivers/dsp/bridge/wmd/tiomap3430_pwr.c;h=f698b4475584e92467e03ecec96bc887948275f9;hb=64b404e9f457f19537972e7f2424f4c73a8a7789#l116
