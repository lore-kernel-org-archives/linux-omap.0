From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 8/8] ARM: OMAP4: PM: Added option for enabling OSWR
Date: Thu, 3 May 2012 19:14:03 +0300
Message-ID: <1336061643.2149.213.camel@sokoban>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
	 <1334913591-26312-9-git-send-email-t-kristo@ti.com>
	 <CAORVsuWVMa-_T4JuXTwT6sePhp0mPoE9U_xhwA28AULveeiM+w@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45618 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab2ECQOK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 12:14:10 -0400
In-Reply-To: <CAORVsuWVMa-_T4JuXTwT6sePhp0mPoE9U_xhwA28AULveeiM+w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org


<clip>

> > @@ -274,8 +278,16 @@ static int __init pm_dbg_init(void)
> >
> >        pwrdm_for_each(pwrdms_setup, (void *)d);
> >
> > -       (void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
> > -                                  &enable_off_mode, &pm_dbg_option_fops);
> > +       if (cpu_is_omap34xx())
> > +               (void) debugfs_create_file("enable_off_mode",
> > +                       S_IRUGO | S_IWUSR, d, &enable_off_mode,
> > +                       &pm_dbg_option_fops);
> Is the enable_off_mode entry needed on other OMAP platorms (OMAP<3)?

Actually I am not sure, I've never used OMAP2. It looks like at least
the kernel does not support off-mode for OMAP2, but according to TRM it
might be possible to support it on HW.

-Tero

