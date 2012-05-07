From: Guillaume Gardet <guillaume.gardet@free.fr>
Subject: Re: [PATCH] omap-usb-host: include <plat/cpu.h>
Date: Mon, 07 May 2012 14:02:19 +0200
Message-ID: <4FA7B9CB.9000608@free.fr>
References: <4FA1467C.8030005@suse.com> <20120503075042.GH20043@arwen.pp.htv.fi>
Reply-To: guillaume.gardet@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fb1.tech.numericable.fr ([82.216.111.51]:53516 "EHLO
	fb1.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756112Ab2EGMDE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 08:03:04 -0400
Received: from smtp7.tech.numericable.fr (smtp7.nc.sdv.fr [10.0.0.118])
	by fb1.tech.numericable.fr (Postfix) with ESMTP id 19E219EE43
	for <linux-omap@vger.kernel.org>; Mon,  7 May 2012 14:03:03 +0200 (CEST)
In-Reply-To: <20120503075042.GH20043@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Jeff Mahoney <jeffm@suse.com>, linux-omap@vger.kernel.org, Guillaume GARDET <guillaume.gardet@opensuse.org>

Hi,

Le 03/05/2012 09:50, Felipe Balbi a =E9crit :
> Hi,
>
> On Wed, May 02, 2012 at 10:36:44AM -0400, Jeff Mahoney wrote:
>> omap-usb-host calls cpu_is_omap3430, which is defined in plat/cpu.h.
>>
>> Reported-by: Guillaume GARDET<guillaume.gardet@opensuse.org>
>> Signed-off-by: Jeff Mahoney<jeffm@suse.com>
> this looks right to me, though a driver shouldn't be using cpu_is_***
> macros. Still, that patch can come later, this is needed now.
>
> Acked-by: Felipe Balbi<balbi@ti.com>
>

It seems it have been added in mainline:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D13176a89e1c4a0011bd9f576730b0338ecb619ff

Guillaume

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
