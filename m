From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Fri, 20 Jan 2012 17:26:45 +0530
Message-ID: <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
References: <1327055619.1921.57.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58120 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750950Ab2ATL5H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 06:57:07 -0500
Received: by lahc1 with SMTP id c1so270695lah.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 03:57:06 -0800 (PST)
In-Reply-To: <1327055619.1921.57.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>

On Fri, Jan 20, 2012 at 4:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
> I'm testing v3.3-rc1 on OMAP3 overo, and I'm having problems probably
> related to PM.
>
> First, when I boot up, the console (via USB serial) is very laggy, it
> often takes many seconds until the key pressed appears so it's more or
> less unusable.
>
> Second, I compile DSS as modules, and don't load them. Looking at
> debugfs/pm_debug/time, I can see that both RET and ON for dss_pwrdm are
> increasing. What is making DSS powerdomain switch back and forth?
>
> Third, when I load the DSS modules, I see only ON state increasing for
> dss_pwrdm, as it should be. However, I'm getting constant stream of sync
> losts from DSS, and the display doesn't basically work at all.
>
> I can see MPU pwrdm going into RET a lot, and if I do "while true; do
> echo foo; done", which I presume basically prevents RET for MPU, the
> display becomes stable.
>
> This sounds a bit like the problem reported by Joe (DSS2/PM on 3.2
> broken?), although this is happening all the time. In this case, as in
> Joe's, the DSS fck is well below 96MHz, which is the limit on OMAP3 for
> DSS fclk on OPP2. And I'm not aware of any other constraints for DSS
> (well, memory throughput, but that should cause fifo underflows).
>
> Is there a way to lock the OPP to the full power OPP?
>

btw,

I think enabling cpu_idle and performance governor to should ensure that.

However enabling performance governor boot fails.

failure logs as in here [1]. I was using latest mainline and beagle -XM

--
Thanks,
Govindraj.R

[1]:

http://pastebin.com/9ZfB2V6B
