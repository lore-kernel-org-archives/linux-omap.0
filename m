From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: OMAP34xx
Date: Fri, 10 Feb 2012 13:53:12 +0200
Message-ID: <CANOLnOPucEMxYa2=fy=Vm_NSHWthnNAq0hJK5u37VZdcwwozFw@mail.gmail.com>
References: <20120208231551.GA9009@kroah.com>
	<alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
	<20120209004731.GA11343@kroah.com>
	<4F3374F0.3080002@bitmer.com>
	<20120209133739.GB2590@sirena.org.uk>
	<20120209183624.GJ1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41529 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab2BJLxO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 06:53:14 -0500
Received: by yhoo21 with SMTP id o21so1389201yho.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Feb 2012 03:53:13 -0800 (PST)
In-Reply-To: <20120209183624.GJ1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Thu, Feb 9, 2012 at 8:36 PM, Tony Lindgren <tony@atomide.com> wrote:
> Please everybody using omaps with mainline give a test for the
> merge of the various fixes planned. I've done a branch with
> v3.3-rc3 + Russell's fixes + Paul's serial port fixes + fixes
> that I've queued up.

Seems to be good on pandora with omap2plus_defconfig, only one section =
mismatch:

WARNING: vmlinux.o(.text+0x22b64): Section mismatch in reference from
the function omap4_hotplug_cpu() to the function
=2Ecpuinit.text:omap_secondary_startup()
The function omap4_hotplug_cpu() references the function __cpuinit
omap_secondary_startup().
This is often because omap4_hotplug_cpu lacks a __cpuinit annotation
or the annotation of omap_secondary_startup is wrong.



--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
