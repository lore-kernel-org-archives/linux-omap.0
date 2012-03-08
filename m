From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for v3.4
Date: Thu, 08 Mar 2012 10:09:32 -0800
Message-ID: <87399jc6cj.fsf@ti.com>
References: <877gywjhht.fsf@ti.com> <20120308021843.GQ12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39461 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751273Ab2CHSJc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 13:09:32 -0500
Received: by mail-iy0-f172.google.com with SMTP id z13so1149388iaz.31
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 10:09:31 -0800 (PST)
In-Reply-To: <20120308021843.GQ12083@atomide.com> (Tony Lindgren's message of
	"Wed, 7 Mar 2012 18:18:43 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [120307 11:42]:
>> Tony,
>> 
>> Please pull the following support for using regulators to control the
>> on-chip VC/VP managed voltage domains.
>> 
>> The regulator driver support for this is already queued in the regulator
>> tree, and this is the supporting core work.
>> 
>> This combined with the CPUfreq changes to use the regulator framework
>> will finally result in MPU DVFS working in mainline.
>
> Nice.. However this one might be missing some header changes?

Oh, that's because it depends on the regulator core changes that are in
Mark's regulator tree.  You need the for-next branch of :

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

For this to compile correctly.

Sorry, I should've been more clear above about the build dependency.

Kevin
