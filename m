From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: multi_v7: Add OMAP with ramdisk config bits
Date: Tue, 25 Jun 2013 00:02:04 -0700
Message-ID: <20130625070203.GA5523@atomide.com>
References: <1371071282-14750-1-git-send-email-santosh.shilimkar@ti.com>
 <20130618082422.GE5523@atomide.com>
 <51C07253.3040909@ti.com>
 <51C858B4.2020106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36909 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751728Ab3FYHCI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jun 2013 03:02:08 -0400
Content-Disposition: inline
In-Reply-To: <51C858B4.2020106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>

* Sricharan R <r.sricharan@ti.com> [130624 07:39]:
> Hi,
> On Tuesday 18 June 2013 08:14 PM, Santosh Shilimkar wrote:
> > On Tuesday 18 June 2013 04:24 AM, Tony Lindgren wrote:
> >> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130612 14:14]:
> >>> Add ramdisk fileystem related options which lets OMAP5 and Keystone
> >>> SOCs to boot till shell with multi_v7_config.
> >> Please add also other v7 omaps.
> >>
> > Should have done first place. Sorry.
> > Will update other machines and after testing, repost it.
> >
> > Regards,
> > Santosh
> >
>  Since CONFIG_ARCH_OMAP2PLUS=y is set in the patch,
>  OMAP3, OMAP4 are getting enabled by default.
> 
>  I tested OMAP4 PANDA on mainline + multi_v7_config + above patch
>  and it booted up fine.

OK thanks for testing. Those default y things will be going
away, but we can update both defconfigs after that.

Acked-by: Tony Lindgren <tony@atomide.com>
