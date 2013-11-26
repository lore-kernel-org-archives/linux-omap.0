From: Chao Xu <caesarxuchao@gmail.com>
Subject: Re: [BUG] PandaBoard hangs before starting init while booting v3.12
Date: Tue, 26 Nov 2013 13:59:17 -0600
Message-ID: <CAKZq+rcpSg02X_xmTzq_fzG6cAWNS+TeXoqZsNFdneqekiaavw@mail.gmail.com>
References: <87hab9agjr.fsf@gmail.com>
	<CAKZq+rdQLrNE43aGaPtnDfaO6CHsq_ePLu+oRgWNs25OrdCtdw@mail.gmail.com>
	<87wqk3n54l.fsf@gmail.com>
	<20131120183548.GH10317@atomide.com>
	<CAKZq+rcoC5PLSVVazWcce7V7TcBM8=M2jM56bvk9HO2orKt8fg@mail.gmail.com>
	<20131126182022.GJ26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:48786 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab3KZT7S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 14:59:18 -0500
Received: by mail-qe0-f48.google.com with SMTP id gc15so6256447qeb.7
        for <linux-omap@vger.kernel.org>; Tue, 26 Nov 2013 11:59:17 -0800 (PST)
In-Reply-To: <20131126182022.GJ26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ben Gamari <bgamari.foss@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Thanks, Tony. I checked my .config and this option is enabled. FYI, I
raised this issue in u-boot mailing-list, too. It seems to be a bug in
u-boot and only happens to certain version of pandaboard. The name of
the thread is "No single character output after update to latest
u-boot on pandaboard"

On Tue, Nov 26, 2013 at 12:20 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Chao Xu <caesarxuchao@gmail.com> [131122 19:28]:
>> "I wonder if we also have some dependency to some earlier versions of
>> u-boot as u-boot now only muxes the essential pins?"
>> This is exactly the problem in my case. I added "#define
>> CONFIG_SYS_ENABLE_PADS_ALL" in u-boot/include/configs/omap4_common.h
>> and now there is output.
>>
>> I guess the reason that the u-boot worked out-of-box for Ben but not
>> for me is that I missed some configurations in v3.12 kernel. I image
>> there is a config options that tells the kernel to take care of the
>> non-essential pins that used to be the responsibility of u-boot. Could
>> you confirm my hypothesis? And if so, could you kindly suggest what's
>> the name of the config option?
>
> That would be CONFIG_PINCTRL_SINGLE=y for device tree based omaps.
> But if we have the configuration missing for some driver in the
> board specific .dts file, that won't help naturally. We do have
> PINCTRL_SINGLE enabled in omap2plus_defconfig.
>
> Regards,
>
> Tony



-- 
Regards,
Chao Xu
