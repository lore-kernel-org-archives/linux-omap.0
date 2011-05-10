From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH] OMAP: Added recalculation of clock rate in
 'clk_set_rate'
Date: Tue, 10 May 2011 19:12:16 +0530
Message-ID: <20110510134216.GG25479@avinash-laptop>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
 <alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com>
 <BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
 <alpine.DEB.2.00.1105061549150.30136@utopia.booyaka.com>
 <BANLkTikjm7th9mv9MOBdMT7j6QPo5Ke7Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:52939 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752434Ab1EJNmb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 09:42:31 -0400
Received: by mail-yw0-f50.google.com with SMTP id 8so2650806ywa.37
        for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 06:42:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikjm7th9mv9MOBdMT7j6QPo5Ke7Xw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Tue, May 10, 2011 at 04:25:19PM +0530, Gulati, Shweta wrote:
> Hi,
>=20
> On Sat, May 7, 2011 at 3:19 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Thu, 21 Apr 2011, Gulati, Shweta wrote:
> >
> >> Yes, but in current code clk_set_rate of dpll3_m2 -
> >> 'omap3_core_dpll_m2_set_rate'
> >> doesn't update clk.rate, I will submit patch fixing that bug and w=
ill
> >> make sure that
> >> set_rate of all clocks should update clk.rate
> >
> > Ping. =A0Do you plan to post this soon? =A0This should be a trivial=
 patch.
> Sorry for the delay, I will post today.

Hi Shweta ,

To avoid delay, yesterday posted a patch for the same with your signed
off by :=20

http://www.spinics.net/lists/linux-omap/msg50776.html

Please verify the patch and if anything is missing, please submit a new
patch.

thanks ,

- Avinash


> > - Paul
> >
>=20
>=20
>=20
> --=20
> Thanks,
> Regards,
> Shweta
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
