From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Wed, 29 Dec 2010 15:07:57 +0200
Message-ID: <20101229130757.GD2222@legolas.emea.dhcp.ti.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-2-git-send-email-dlambert@ti.com>
 <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
 <AANLkTi=6iWz0jdakBBgw2OEOjADvS2YmCN0ebKODQ7Ke@mail.gmail.com>
 <20101229094738.GA2254@legolas.emea.dhcp.ti.com>
 <1293618931.3451.17.camel@odin>
 <20101229104432.GB2254@legolas.emea.dhcp.ti.com>
 <1293623571.3451.51.camel@odin>
 <20101229120443.GB2222@legolas.emea.dhcp.ti.com>
 <1293627600.3451.93.camel@odin>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53042 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752165Ab0L2NIC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Dec 2010 08:08:02 -0500
Received: by mail-ey0-f180.google.com with SMTP id 18so4248415eyf.39
        for <linux-omap@vger.kernel.org>; Wed, 29 Dec 2010 05:08:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1293627600.3451.93.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: balbi@ti.com, "Lambert, David" <dlambert@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Wed, Dec 29, 2010 at 01:00:00PM +0000, Liam Girdwood wrote:
>Ok, I now think you meant other "ARM architectures" here than other
>Linux architectures in general. It does make a more sense for ARM
>distribution deployment, but I still think guaranteeing successful build
>for this driver on all non ARM architectures atm just to give us
>satisfaction that the driver is "well written" is unnecessary effort.

Ok.

>In a lot of cases drivers under drivers/* and sound/* must touch plat/*
>and mach/* headers for runtime access to hardware IP. I've just grepped
>and the list is quite long for drivers/*

IMHO that's wrong :-p But that's only my opinion. Anyway, I'm ok with
your decision FWIW.

-- 
balbi
