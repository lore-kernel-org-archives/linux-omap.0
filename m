From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: Fix section mismatch warning for
 platform_cpu_die()
Date: Tue, 28 Feb 2012 14:34:48 -0800
Message-ID: <20120228223447.GE18901@atomide.com>
References: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
 <1329980310-9007-3-git-send-email-santosh.shilimkar@ti.com>
 <20120223074504.GZ14173@pengutronix.de>
 <CAMQu2gxLJOY8HzMO71dHTr8VfQ+G=KJP+wv5SwvrktTi7b82+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65235 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965320Ab2B1Wex (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 17:34:53 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gxLJOY8HzMO71dHTr8VfQ+G=KJP+wv5SwvrktTi7b82+A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120223 00:09]:
> 2012/2/23 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> > Hello,
> >
> > On Thu, Feb 23, 2012 at 12:28:30PM +0530, Santosh Shilimkar wrote:
> >> WARNING: vmlinux.o(.text+0x226d0):
> >> Section mismatch in reference from the function
> >> platform_cpu_die() to the function .cpuinit.text:omap4_hotplug_cpu=
()
> >> The function platform_cpu_die() references
> >> the function __cpuinit omap4_hotplug_cpu().
> >> This is often because platform_cpu_die lacks a __cpuinit
> >> annotation or the annotation of omap4_hotplug_cpu is wrong.
> >>
> >> Thanks to Russell King for suggesting __ref annotation trick
> >> just like it's parent function for this warning becasue __cupinit
> > s/it's/its/; s/becasue/because/; s/cup/cpu/
> >
> > Having said that I think the grammar is broken, too. Maybe:
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0Thanks to Russell King for suggesting to=
 use __ref instead of
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0the initial (and wrong) approach to use =
__cpuinit.
> >
> > (But note I'm not a native speaker, too)
> >
> Thanks for fixing the grammar. :)
> Updated patch below with comments corrected as per
> your suggestion.

Thanks applying both into fixes-non-critical.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
