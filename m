From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] V7/Cortex/omap34xx fixes for 2.6.33-rc1: DCC,
 kexec, atags
Date: Tue, 29 Dec 2009 14:07:05 -0800
Message-ID: <20091229220705.GM3512@atomide.com>
References: <20091219034151.26198.26570.stgit@localhost>
 <aec7e5c30912272155s41ce8914hd03a5e4c740a5b9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55330 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbZL2WHK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 17:07:10 -0500
Content-Disposition: inline
In-Reply-To: <aec7e5c30912272155s41ce8914hd03a5e4c740a5b9d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

* Magnus Damm <magnus.damm@gmail.com> [091227 21:54]:
> Hi Tony,
>=20
> On Sat, Dec 19, 2009 at 12:45 PM, Tony Lindgren <tony@atomide.com> wr=
ote:
> > Here are some v7 fixes, mostly to make kexec work.
> >
> > Using 2.6.33-rc1, these fixes, and kexec from kexec-tools
> > git repo, I can reboot my n900 in a loop reliably.
>=20
> Thanks for your work on this. I previously tested kexec on ARM V6 and
> V7 and noticed that V7 didn't work. I revisited my V7 test after
> becoming aware of your patches. The single patch below unbreaks V7 on
> my target system.
>=20
> > =A0 =A0 =A0arm: Fix cpu_proc_fin() for proc-v7.S and make kexec wor=
k

Cool. Thank you for fixing the kexec source :)

Are you seeing the occasional crc errors when uncompressing the
new kernel on your v7?

I'm seeing those maybe 1 out of 10 times on omap3430 boards unless if
I do an extra (and wrong) flush_cache_all after local_flush_tlb_all
at the end of setup_mm_for_reboot.

If you're not seeing the crc errors, do you have L2 cache on?

Also, what's the Cortex version on your v7? It's rev r2p3 on
omap3430.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
