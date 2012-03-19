From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc-smsc911x: only register regulator for first instance
Date: Mon, 19 Mar 2012 14:39:12 -0700
Message-ID: <87mx7c5kzj.fsf@ti.com>
References: <1331080771-30687-1-git-send-email-khilman@ti.com>
	<201203192118.09286.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:59455 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756152Ab2CSVix (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 17:38:53 -0400
Received: by mail-pz0-f44.google.com with SMTP id l33so13102568dak.17
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 14:38:52 -0700 (PDT)
In-Reply-To: <201203192118.09286.arnd@arndb.de> (Arnd Bergmann's message of
	"Mon, 19 Mar 2012 21:18:09 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Matt Porter <mporter@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 07 March 2012, Kevin Hilman wrote:
>> commit e4b0b2cbbb (ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
>> regulators) added regulators which are registered during
>> gpmc_smsc911x_init().  However, some platforms (OMAP3/Overo) have more
>> than one instance of the SMSC911x and result in attempting to register
>> the same regulator more than once which causes a panic().
>> 
>> Fix this by only registering the regulator when the platform_data id
>> field is zero, indicating its the first instance.
>> 
>> Cc: Matt Porter <mporter@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> It seems that both Olof and I forgot to forward this one to Linus.
>
> If it's ok for you, I'll add it to the fixes branch for v3.4 now
> and mark it for backporting to v3.3-stable.

A slightly different version of this is already in linux-next as commit
bb60424af517d6e6148505fb5ef256caa91b5b43.

It was in your 'fixes' branch, and was merged by Olaf from Tony on 3/13:
Merge branch 'fix-smsc911x-regulator' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes

Kevin

