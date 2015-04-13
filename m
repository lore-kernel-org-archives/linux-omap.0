From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap late prcm clean-up for v4.1
Date: Tue, 14 Apr 2015 01:06:40 +0200
Message-ID: <201504140106.40326.arnd@arndb.de>
References: <20150403232536.GC18048@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:54904 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbbDMXGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Apr 2015 19:06:48 -0400
In-Reply-To: <20150403232536.GC18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org

On Saturday 04 April 2015, Tony Lindgren wrote:
> The following changes since commit 209431eff8afb928d72200c79153165c7d860ca0:
> 
>   ARM: DRA7: Enable Cortex A15 errata 798181 (2015-03-27 14:38:03 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/prcm-dts
> 
> for you to fetch changes up to 21295368367beaa563b310d5492166dba158b884:
> 
>   Merge branch '4.0-rc1-prcm-cleanup-v6' of https://github.com/t-kristo/linux-pm into omap-for-v4.1/prcm-cleanup (2015-04-01 12:24:29 -0700)
> 
> ----------------------------------------------------------------
> Clean-up for omap PRCM (Power Reset Clock Management) and interconnects
> from Tero Kristo <t-kristo@ti.com>.
> 
> This sets gets us into a better position for further clean-up:
> 
> - Gets PRCM code closer to being device drivers
> 
> - Allows to move the remainig clock code to drivers/clk for v4.2
> 
> - Starts enforcing interconnect hierarchy in the SoC specific .dts
>   files to enforce device drivers are only accesing registers in
>   the related hardware module
> 
> This patchset has seen quite a few revisions but did not come into
> mergeable shape until recently. As other patchsets for clock specific
> device drivers depend on this, it would be good to get this merged
> although it's a bit late for the v4.1 merge window.
> 
> Note that as the device entries in the .dts files are moved around,
> this is based on earlier non-urgent fixes to avoid a non-trivial
> merge conflict.

Sorry for missing this earlier, I've put it into the next/late branch now.
If everything goes well, we'll submit that a few days after the other
branches.

	Arnd
