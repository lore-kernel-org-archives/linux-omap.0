From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 25/26] OMAP: PM: convert the SmartReflex code into the AVS driver framework
Date: Wed, 11 Jan 2012 16:52:17 -0800
Message-ID: <87d3apvj26.fsf@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
	<1321974370-25800-26-git-send-email-j-pihet@ti.com>
	<20111123095120.GD25068@legolas.emea.dhcp.ti.com>
	<CAORVsuV2bRJrCnk2Kntr3YgZzoTcFyVcg6A6ZSUUOqkh9Jz0uA@mail.gmail.com>
	<20111123110448.GP25068@legolas.emea.dhcp.ti.com>
	<CAORVsuUio6viQxBFJES0wm7sP3O44se0CsiXue95XEKiR5_F4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:33077 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751729Ab2ALAwW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jan 2012 19:52:22 -0500
Received: by mail-gx0-f170.google.com with SMTP id r4so732924ggn.15
        for <linux-omap@vger.kernel.org>; Wed, 11 Jan 2012 16:52:21 -0800 (PST)
In-Reply-To: <CAORVsuUio6viQxBFJES0wm7sP3O44se0CsiXue95XEKiR5_F4w@mail.gmail.com>
	(Jean Pihet's message of "Wed, 23 Nov 2011 12:30:54 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: balbi@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

>> if you already decide in runtime the correct initialization to call, why
>> do you add ifdefs ?
>
> There is no #ifdef with CONFIG_POWER_AVS_OMAP_V[12], those options are
> used to compile or not the respective modules, cf.
> driver/power/avs/Makefile.

I'd suggest not even having user-selectable Kconfig for this.  

Just have a single Kconfig for POWER_AVS, then have

config POWER_AVS_OMAP
       default PM && (ARCH_OMAP3 || ARCH_OMAP4)

which compiles both versions of the OMAP IP.

Kevin
