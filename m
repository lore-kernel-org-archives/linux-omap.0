From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 0/5] V7/Cortex/omap34xx fixes for 2.6.33-rc1: DCC,
	kexec, atags
Date: Tue, 5 Jan 2010 13:36:29 +0200
Message-ID: <20100105113629.GB8349@gw.healthdatacare.com>
References: <20091219034151.26198.26570.stgit@localhost> <aec7e5c30912272155s41ce8914hd03a5e4c740a5b9d@mail.gmail.com> <20091229220705.GM3512@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:55709 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab0AELge (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 06:36:34 -0500
Received: by fxm25 with SMTP id 25so9627616fxm.21
        for <linux-omap@vger.kernel.org>; Tue, 05 Jan 2010 03:36:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091229220705.GM3512@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Dec 29, 2009 at 02:07:05PM -0800, Tony Lindgren wrote:
> Hi,
>=20
> * Magnus Damm <magnus.damm@gmail.com> [091227 21:54]:
> > Hi Tony,
> >=20
> > On Sat, Dec 19, 2009 at 12:45 PM, Tony Lindgren <tony@atomide.com> =
wrote:
> > > Here are some v7 fixes, mostly to make kexec work.
> > >
> > > Using 2.6.33-rc1, these fixes, and kexec from kexec-tools
> > > git repo, I can reboot my n900 in a loop reliably.
> >=20
> > Thanks for your work on this. I previously tested kexec on ARM V6 a=
nd
> > V7 and noticed that V7 didn't work. I revisited my V7 test after
> > becoming aware of your patches. The single patch below unbreaks V7 =
on
> > my target system.
> >=20
> > > =A0 =A0 =A0arm: Fix cpu_proc_fin() for proc-v7.S and make kexec w=
ork
>=20
> Cool. Thank you for fixing the kexec source :)
>=20
> Are you seeing the occasional crc errors when uncompressing the
> new kernel on your v7?
>=20
> I'm seeing those maybe 1 out of 10 times on omap3430 boards unless if
> I do an extra (and wrong) flush_cache_all after local_flush_tlb_all
> at the end of setup_mm_for_reboot.

Hi,

I've also been playing with this patch.

One thing I noticed is that If I disable L2 cache in cpu_v7_proc_fin()
then kexec works fine and no crc errors from decompressor (I did
~30 kexec boots). With L2 cache enabled, it fails almost immediately.

Tested with OMAP3430 ES3.1.

Thanks,
MW
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
