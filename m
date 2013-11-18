From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
Date: Mon, 18 Nov 2013 19:09:21 +0000
Message-ID: <20131118190921.GT13640@lee--X1>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
 <20131118172510.GI16038@saruman.home>
 <20131118174638.GQ13640@lee--X1>
 <20131118181110.GM10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:51986 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab3KRTJ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 14:09:26 -0500
Received: by mail-ob0-f179.google.com with SMTP id wm4so1895681obc.24
        for <linux-omap@vger.kernel.org>; Mon, 18 Nov 2013 11:09:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131118181110.GM10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

> > Are you Acking this patch by the way?
>=20
> If this looks acceptable to you guys, I'd like to merge this via my f=
ixes
> branch this week with your acks if that works for you. That way I can=
 base
> my omap legacy platform data removal patches on my fixes branch while=
 keep
> things working for the drivers. Alternatively I can naturally base my
> legacy data removal on -rc2 too if this gets merged to mainline by th=
en=20
> via the MFD tree.

I can either send it up for the -rcs, or I can create an immutable
branch for you to pull from. That way the patch can do in via ARM-SoC
and MFD and we can let Git sort it out.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
