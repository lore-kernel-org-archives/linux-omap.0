From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BUG] PandaBoard hangs before starting init while booting v3.12
Date: Tue, 26 Nov 2013 10:20:22 -0800
Message-ID: <20131126182022.GJ26766@atomide.com>
References: <87hab9agjr.fsf@gmail.com>
 <CAKZq+rdQLrNE43aGaPtnDfaO6CHsq_ePLu+oRgWNs25OrdCtdw@mail.gmail.com>
 <87wqk3n54l.fsf@gmail.com>
 <20131120183548.GH10317@atomide.com>
 <CAKZq+rcoC5PLSVVazWcce7V7TcBM8=M2jM56bvk9HO2orKt8fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59921 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932372Ab3KZSUZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 13:20:25 -0500
Content-Disposition: inline
In-Reply-To: <CAKZq+rcoC5PLSVVazWcce7V7TcBM8=M2jM56bvk9HO2orKt8fg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chao Xu <caesarxuchao@gmail.com>
Cc: Ben Gamari <bgamari.foss@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Chao Xu <caesarxuchao@gmail.com> [131122 19:28]:
> "I wonder if we also have some dependency to some earlier versions of
> u-boot as u-boot now only muxes the essential pins?"
> This is exactly the problem in my case. I added "#define
> CONFIG_SYS_ENABLE_PADS_ALL" in u-boot/include/configs/omap4_common.h
> and now there is output.
> 
> I guess the reason that the u-boot worked out-of-box for Ben but not
> for me is that I missed some configurations in v3.12 kernel. I image
> there is a config options that tells the kernel to take care of the
> non-essential pins that used to be the responsibility of u-boot. Could
> you confirm my hypothesis? And if so, could you kindly suggest what's
> the name of the config option?

That would be CONFIG_PINCTRL_SINGLE=y for device tree based omaps.
But if we have the configuration missing for some driver in the
board specific .dts file, that won't help naturally. We do have
PINCTRL_SINGLE enabled in omap2plus_defconfig.

Regards,

Tony
