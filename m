From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 08/13] OMAP2+: McBSP: hwmod adaptation
 for McBSP
Date: Fri, 18 Feb 2011 10:08:22 +0200
Message-ID: <20110218100822.751b28d5.jhnikula@gmail.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<1296485437-12806-9-git-send-email-kishon@ti.com>
	<4D47FB19.9040901@nokia.com>
	<20110201194436.74826dd0.jhnikula@gmail.com>
	<AANLkTimzjg3+yGwz1sa+dfWyrjaS1mO+zn_LT3hhDHdQ@mail.gmail.com>
	<20110217234140.GH20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59060 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756060Ab1BRIHs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 03:07:48 -0500
Received: by ewy5 with SMTP id 5so1446806ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 00:07:47 -0800 (PST)
In-Reply-To: <20110217234140.GH20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@alsa-project.org, b-cousson@ti.com, khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, p-basak2@ti.com, lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, shubhrajyoti@ti.com, charu@ti.com

On Thu, 17 Feb 2011 15:41:40 -0800
Tony Lindgren <tony@atomide.com> wrote:

> > > Actually this part of code doesn't compile for CONFIG_ARCH_OMAP2 if
> > > CONFIG_ARCH_OMAP3 is not set. Reason is that the buffer_size in under
> > > CONFIG_ARCH_OMAP3 compilation in struct omap_mcbsp_platform_data
> > > definition.
> > >
> > > I think it's easiest if this patch just removes that conditional
> > > compilation from struct omap_mcbsp_platform_data as it really doesn't
> > > save that much from non !OMAP3 builds.
> > 
> >   Thanks. Will fix it in the next version.
> 
> Any news on updating this series?
> 
> Note that you can now leave out the omap4 hwmod data as that has
> been merged to omap-for-linus.
> 
My impression from last round was that there is not that many changes
required. Of course there must not have bisect issues like above, should
not break OMAP1 (which I think was addressed already) but otherwise I
think most of the issues were small.

Kevin had concerns about PM testing but I would not put that much
emphasis on that since the set should not make things any worse but
should make possible to go forward with PM.

-- 
Jarkko
