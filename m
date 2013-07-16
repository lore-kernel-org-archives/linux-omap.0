From: Tony Lindgren <tony@atomide.com>
Subject: Re: Unable to boot with kernel 3.11-rc1 on Panda Board ES Rev B1
Date: Tue, 16 Jul 2013 02:24:36 -0700
Message-ID: <20130716092435.GV7656@atomide.com>
References: <CADWBrZKJVit7GjYQuMAC0S7uV-TYmxAvjLoYCJ7b2OCr=ivYHA@mail.gmail.com>
 <51E4C836.1040300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55965 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921Ab3GPJYi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jul 2013 05:24:38 -0400
Content-Disposition: inline
In-Reply-To: <51E4C836.1040300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Jacob Minshall <jacob@cozybit.com>, linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [130715 21:19]:
> Hi Jacob,
> On Tuesday 16 July 2013 06:15 AM, Jacob Minshall wrote:
> > When trying to boot a Panda Board ES Rev B1 with the 3.11-rc1 kernel,
> > the boot does not work. All that happens is pasted below, and then it
> > just hangs there not actually starting the kernel. I have also
> > appended my .config file to the end of this email. I have tried this
> > exact setup only with a different image pointed to by the
> > pxelinux.cfg/<file> of a 3.6 kernel which works fine. Any help would
> > be appreciated.
> I guess you are not using DT boot. With the commit 
> "ARM: OMAP2+: Remove board-omap4panda.c" from Tony non-dt boot is
> removed from mainline for OMAP4.
> Please use omap4-panda-es.dtb file for using dt boot on PANDA ES.
> I have boot tested 3.11-rc1 on PANDA ES, here is the log: http://pastebin.com/cnqpWT6m
> Please let me know if you need more info..:)

Also updating u-boot is recommended so you don't have to use appended
DTB. For appended DTB usage, there are some instructions in commit
b42b918194.

If using your custom .config file instead of omap2plus_defconfig,
you need to check that you have CONFIG_MACH_OMAP_GENERIC=y,
CONFIG_REGULATOR_FIXED_VOLTAGE=y, CONFIG_PINCTRL_SINGLE=y.

Regards,

Tony
