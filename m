From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v7 00/12] omap3: pm: TWL4030 power scripts and workaround
 for TWL errata 27
Date: Mon, 21 Feb 2011 17:50:51 +0530
Message-ID: <AANLkTikQf4__Oo4FQYy742XKAhyaJrWhyX8SusEUzkpF@mail.gmail.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
 <AANLkTinTAVuK=CJaCgve4LQa-4jPhHf1ycUf-BhEz5i0@mail.gmail.com>
 <AANLkTi=O+ouOsgkOHKgPZuDEQO7Nu255dYZvUVyEVV6a@mail.gmail.com> <20110221115709.GJ11250@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:39564 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755406Ab1BUMVQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 07:21:16 -0500
Received: by wyb29 with SMTP id 29so1318303wyb.4
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 04:21:13 -0800 (PST)
In-Reply-To: <20110221115709.GJ11250@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: "ext Manuel, Lesly Arackal" <leslyam@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Mon, Feb 21, 2011 at 17:27, Peter 'p2' De Schrijver
<peter.de-schrijver@nokia.com> wrote:
[..]
> > >> This changes are tested on OMAP3430 & OMAP3630 SDP with off mode=
 enabled in suspend path.
> > >> =A0 =A0 =A0 =A0Tested with suspend/resume script, which will tes=
t system suspend in a loop.
> > >> =A0 =A0 =A0 =A0Tested for more than 1000 iterations.
> > >
> > > Good to see the TWL scripts back in the mainline kernel!
> > > Are the scripts compatible with the OMAP3 Beagleboard? I would li=
ke to
> > > test the changes on that board.
> >
> > I have not tested on Beagleboard.
> > I think Beagleboard is using different PM IC TPSxxxx.
> > If its equivalent to TRITON then this script should work on it.
>
> As far as I know they are equivalent. I don't know if the errata need=
 to
> be applied though. Maybe someone from TI can comment?

Yes for the impacted revisions.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
