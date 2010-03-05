From: <me@felipebalbi.com>
Subject: Re: =?UTF-8?Q?usb=5Fnop=5Fxceiv=5Fregister=28=29=20missing=20when=20OTG?=
 =?UTF-8?Q?=20built=20as=20modules?=
Date: Fri, 05 Mar 2010 13:54:04 -0600
Message-ID: <558f5bffd42210a777154737d6730232@secure211.sgcpanel.com>
References: <87635d54nn.fsf@deeprootsystems.com> <19F8576C6E063C45BE387C64729E7394044DB7B6BD@dbde02.ent.ti.com> <87eik03scn.fsf@deeprootsystems.com> <20100305090426.GG12757@nokia.com> <871vfy3azr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51786 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471Ab0CETyK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 14:54:10 -0500
In-Reply-To: <871vfy3azr.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: felipe.balbi@nokia.com, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, linux-omap@vger.kernel.org

On Fri, 05 Mar 2010 09:59:52 -0800, Kevin Hilman
> It would be my fault if I wrote those board files.  ;)

sure, sorry. Maybe I didn't express myself really well.

>> I suggest you keep usb as a module, but keep nop xceiv built-in.
> 
> Yes, that's the workaround I'm already using, but it is not a fix.
> 
> This dependency breaks the ability to build a minimal kernel with
> everything as modules (allmodconfig)

now this is a really good point. Haven't thought that way...

> The nop xceiv needs a way for built-in code to register itself for
> the cases when no xceiv is built as a module.

when way to do that is not to use usb_nop_xceiv_register() and
add the platform_device to the board-files. I never really liked
the whole usb_nop_xceiv_register() hackery. Almost all board-files
have a list of platform_devices which get added by platform_add_devices()
anyways, so why not using that ??

to me the usb_nop_xceiv_register() thing is just a lazy way of
defining platform_devices. Specially one that takes some 3
lines of code only.

-- 
balbi
