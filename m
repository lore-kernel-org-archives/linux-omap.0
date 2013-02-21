From: Wolfgang Denk <wd@denx.de>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 21:18:41 +0100
Message-ID: <20130221201841.31A3B200663@gemini.denx.de>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <51265BF1.5000302@ti.com> <alpine.LFD.2.03.1302211358070.6419@syhkavp.arg> <5126778A.4040705@wwwdotorg.org> <20130221195746.70EB6200672@gemini.denx.de> <51267E0A.3060204@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-reply-to: <51267E0A.3060204@wwwdotorg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Tom Rini <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Dear Stephen,

In message <51267E0A.3060204@wwwdotorg.org> you wrote:
>
> > so.  Just consider the typical "diskless" system that boots over the
> > network, using DHCP + TFTP, where the server will provide a single
> > file only.
> 
> I use TFTP routinely to boot my boards, and load separate zImage and DTB
> files from the server without issue, using the exact same filenames as
> when I load them from a /boot directory on eMMC or SD.

You may do this in a development environment; I do the same routinely
here.  But there are users out there who commission large
installations like that; they simply do not want to have multiple
files for each system (and not even for each configuration).

> And besides, there's always some script, whether it's a boot.scr file or
> built into the U-Boot environment.

Not really - especially not when booting using Falcon mode.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If you can't beat it or corrupt it, you pretend it was your  idea  in
the first place.                 - Terry Pratchett, _Guards! Guards!_
