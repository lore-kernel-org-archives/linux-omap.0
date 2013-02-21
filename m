From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 13:05:30 -0700
Message-ID: <51267E0A.3060204@wwwdotorg.org>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <51265BF1.5000302@ti.com> <alpine.LFD.2.03.1302211358070.6419@syhkavp.arg> <5126778A.4040705@wwwdotorg.org> <20130221195746.70EB6200672@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20130221195746.70EB6200672@gemini.denx.de>
Sender: linux-kbuild-owner@vger.kernel.org
To: Wolfgang Denk <wd@denx.de>
Cc: Nicolas Pitre <nico@fluxnic.net>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Tom Rini <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 02/21/2013 12:57 PM, Wolfgang Denk wrote:
> Dear Stephen,
> 
> In message <5126778A.4040705@wwwdotorg.org> you wrote:
>>
>> If U-Boot always searched a disk for e.g. /boot/boot.scr or similar and
>> just executed that, and there was a standard boot.scr that worked on all
>> boards by use of e.g. bootz, ${soc}, ${board}, then that could be
>> distro-agnostic too. And life would be simple, without the need for any
>> extra build tools at all.
> 
> If the world was so simple, we could eventually do that.  But it ain't
> so.  Just consider the typical "diskless" system that boots over the
> network, using DHCP + TFTP, where the server will provide a single
> file only.

I use TFTP routinely to boot my boards, and load separate zImage and DTB
files from the server without issue, using the exact same filenames as
when I load them from a /boot directory on eMMC or SD.

> Or systems that require sub-second boot times, where you
> don't want to spend time in running boot scripts. etc.

Admittedly this is conjecture, but surely the actual IO time to load a
zImage vastly vastly dwarfs the time take to parse an "ext2load" or
"fsload" command to do so, so running scripts to do this isn't relevant.
And besides, there's always some script, whether it's a boot.scr file or
built into the U-Boot environment.

