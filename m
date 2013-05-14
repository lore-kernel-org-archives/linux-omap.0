From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: am3517: failed to boot 3.10-rc1
Date: Tue, 14 May 2013 15:01:57 +0200
Message-ID: <519235C5.1010608@visionsystems.de>
References: <519202DC.10100@visionsystems.de> <20130514125216.GE21107@arwen.pp.htv.fi>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:54231 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770Ab3ENNCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 May 2013 09:02:16 -0400
In-Reply-To: <20130514125216.GE21107@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Mark A. Greer" <mgreer@animalcreek.com>, Maxim Podbereznyy <lisarden@gmail.com>

On 14.05.2013 14:52, Felipe Balbi wrote:
> On Tue, May 14, 2013 at 11:24:44AM +0200, Yegor Yefremov wrote:
>> Trying to boot 3.10-rc1 on an am3515 based board. With the same
>> .config as 3.7 the system comes to RTC stops there. I've also tried
>> make omap2plus_defconfig with no visible difference. I'm booting from
>> MMC card and it will be detected by the system. Kernel is from
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git, latest
>> commit f722406faae2d073cc1d01063d1123c35425939e. Are there any pending
>> patches needed to boot on am3517?
> does v3.9 work ? Can you bisect ?

'git checkout v3.9' version is working, will try to bisect.

Yegor
