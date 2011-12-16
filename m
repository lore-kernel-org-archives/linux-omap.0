From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: problem with twl4030 GPIO irqs
Date: Fri, 16 Dec 2011 02:56:32 +0200
Message-ID: <CAMP44s04pfCU3Y33FeER+N4LFCVJuaK+U=wZ+zzpkv2an9mpMg@mail.gmail.com>
References: <CANOLnON1-vg45KWZ7Rp+jL1n-jwBiTA2Qmkr_z1XnDKQ0XBPJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65520 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab1LPA4c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 19:56:32 -0500
Received: by dajs34 with SMTP id s34so1724061daj.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Dec 2011 16:56:32 -0800 (PST)
In-Reply-To: <CANOLnON1-vg45KWZ7Rp+jL1n-jwBiTA2Qmkr_z1XnDKQ0XBPJw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, NeilBrown <neilb@suse.de>, Felipe Balbi <balbi@ti.com>

On Fri, Dec 16, 2011 at 2:03 AM, Grazvydas Ignotas <notasas@gmail.com> =
wrote:
> I'm running 3.2-rc5 on pandora with Neil's twl patches on top, and
> omap_hsmmc driver fails to probe:
> [ =C2=A0 =C2=A03.491394] omap_hsmmc omap_hsmmc.0: context was not los=
t
> [ =C2=A0 =C2=A03.497161] omap_hsmmc omap_hsmmc.0: enabled
> [ =C2=A0 =C2=A03.715270] omap_hsmmc omap_hsmmc.0: Unable to grab MMC =
CD IRQ
>
> Pandora is using twl4030 GPIOs for card detect. From what I tried to
> debug, omap_hsmmc is failing after call to request_irq() on card
> detect irq with -EINVAL, irq number is 384 which is in range of other
> twl4030 irqs. It looks like request_irq() is calling
> request_threaded_irq() on ARM with NULL thread_fn, which in turn call=
s
> __setup_irq() that calls irq_settings_is_nested_thread() that results
> with true. As this nested flag is set it checks thread_fn, but that i=
s
> NULL causing -EINVAL final result.
>
> Could someone who knows irq code better look at this? I think this
> should reproduce on beagle too.

Basically all the modules of twl4030 should be converted to use
request_threaded_irq(), if they are not, they will fail, and that's
good, as trying to workaround the issue would just cause more trouble.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
