From: David Anders <x0132446@ti.com>
Subject: Re: Open issues after 2.6.38 merge window
Date: Fri, 14 Jan 2011 14:57:31 -0600
Message-ID: <4D30B8BB.90804@ti.com>
References: <20110114194758.GM4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37276 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976Ab1ANU5c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Jan 2011 15:57:32 -0500
In-Reply-To: <20110114194758.GM4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,

i've been testing the 2.6.37 kernel on ES2.0, ES2.1, ES2.2 using the 
following:

x-loader:
git://gitorious.org/x-loader/x-loader.git
branch: master
  6f3a261 omap1: remove support for 1710 and 1510
defconfig: omap4430panda_config

U-boot:
git://git.denx.de/u-boot.git
tag: v2010.12
defconfig: omap4_panda_config

kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
tag: v2.6.37
defconfig: omap2plus_defconfig

i've not seen the power off issue you have described.


thanks
Dave



On 01/14/2011 01:47 PM, Tony Lindgren wrote:
> Hi all,
>
> Before I update out master branch, let's try to summarize the
> open issues after the merge window. Here's a list of issues
> in omap-fixes-for-linus that I'm aware of:
>
> - NFS root oopses while mounting root
>
> - omap4430 es1.0 hangs if L2X0 cache is enabled
>
> - omap4 panda powers down after boot (watchdog?)
>
> - omap3 ldp board powers down after boot?
>
> Any other issues?
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>    

