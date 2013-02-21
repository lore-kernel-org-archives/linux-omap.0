From: Wolfgang Denk <wd@denx.de>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 20:57:46 +0100
Message-ID: <20130221195746.70EB6200672@gemini.denx.de>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <51265BF1.5000302@ti.com> <alpine.LFD.2.03.1302211358070.6419@syhkavp.arg> <5126778A.4040705@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:50946 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544Ab3BUT5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 14:57:52 -0500
In-reply-to: <5126778A.4040705@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Tom Rini <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Dear Stephen,

In message <5126778A.4040705@wwwdotorg.org> you wrote:
>
> If U-Boot always searched a disk for e.g. /boot/boot.scr or similar and
> just executed that, and there was a standard boot.scr that worked on all
> boards by use of e.g. bootz, ${soc}, ${board}, then that could be
> distro-agnostic too. And life would be simple, without the need for any
> extra build tools at all.

If the world was so simple, we could eventually do that.  But it ain't
so.  Just consider the typical "diskless" system that boots over the
network, using DHCP + TFTP, where the server will provide a single
file only.  Or systems that require sub-second boot times, where you
don't want to spend time in running boot scripts. etc.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
We see things not as they are, but as we are.       - H. M. Tomlinson
