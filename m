From: Kevin Hilman <khilman@ti.com>
Subject: Re: Remaining omap pull requests
Date: Tue, 02 Aug 2011 17:06:26 -0700
Message-ID: <4E389102.1050302@ti.com>
References: <20110711114736.GX5783@atomide.com> <201107120016.12366.arnd@arndb.de> <20110713061634.GG5783@atomide.com> <4E3884EE.3070507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:60865 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753267Ab1HCAG3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 20:06:29 -0400
Received: by mail-pz0-f52.google.com with SMTP id 13so520460pzd.11
        for <linux-omap@vger.kernel.org>; Tue, 02 Aug 2011 17:06:28 -0700 (PDT)
In-Reply-To: <4E3884EE.3070507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>

On 08/02/2011 04:14 PM, Kevin Hilman wrote:
[...]
>>
>> Looks like I forgot the i2c driver changes that also should be
>> merged by us. Those are acked by Ben Dooks, Kevin's pull request
>> for that is at:
>>
>> http://marc.info/?l=3Dlinux-omap&m=3D131014213007667&w=3D2
>>
>
> I thought this was already pulled, but looking now I see that this wa=
s
> never pulled into the arm-soc tree.
>
> Can you pull this for v3.1 please?

Oops, I had to rebase this branch as Paul had picked up a few of these=20
patches for his fixes (which are now part of arm-soc/next/fixes2.)=20
Updated pull request below.

Also, I noticed there's a minor conflict with something coming from the
trivial tree[1].

Kevin

The following changes since commit 6d3c55fd4f0f94a9455d30df9414ddb0f755=
f402:

   OMAP: hwmod: fix the i2c-reset timeout during bootup (2011-07-10=20
05:27:16 -0600)

are available in the git repository at:
=20
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git=
=20
for_3.1/i2c-andy-2

Andy Green (12):
       I2C: OMAP2+: Name registers in I2C IP V2 only accordingly
       I2C: OMAP: add rev to omap i2c platform data
       I2C: OMAP1: set IP revision in platform data
       I2C: OMAP2+: Pass hwmod rev knowledge via platform_data when i2c=
=20
bus added
       I2C: OMAP2+: use platform_data ip revision to select register ma=
p
       I2C: OMAP2+: Solve array bounds overflow error on i2c idle
       I2C: OMAP2+: address confused probed version naming
       I2C: OMAP1/OMAP2+: add flags field to omap i2c platform data
       I2C: OMAP2+: Pass flags up to omap i2c platform_data as well
       I2C: OMAP1: set i2c unit feature implementation flags in platfor=
m=20
data
       I2C: OMAP2+: Convert omap I2C driver to use feature=20
implementation flags from platform data
       I2C: OMAP1/OMAP2+: prepend I2C IP version to probed version show=
n=20
in dev_info

  arch/arm/plat-omap/i2c.c      |   27 +++++++++++
  drivers/i2c/busses/i2c-omap.c |  100=20
++++++++++++++++++++++------------------
  include/linux/i2c-omap.h      |    2 +
  3 files changed, 84 insertions(+), 45 deletions(-)


[1]
commit 32575a9183c82a5ea0f9ed1bcf13c17189ea1118
Author: Jesper Juhl <jj@chaosbits.net>
Date:   Sat Jul 9 23:20:42 2011 +0200

     drivers/i2c: static should be at beginning of declaration

     Make sure that the 'static' keywork is at the beginning of declara=
tion
     for drivers/i2c/busses/i2c-omap.c

     This gets rid of warnings like
       warning: =91static=92 is not at beginning of declaration
     when building with -Wold-style-declaration (and/or -Wextra which a=
lso
     enables it).

     Signed-off-by: Jesper Juhl <jj@chaosbits.net>
     Signed-off-by: Jiri Kosina <jkosina@suse.cz>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
