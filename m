From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 4/4] memory: emif: add device tree support to emif driver
Date: Fri, 29 Jun 2012 19:16:19 +0530
Message-ID: <CAMQu2gx2RT0iyo+LD1TyTJg9FRSUD8SK2tA=nxAoULzQOa6L7A@mail.gmail.com>
References: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com>
 <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com>
 <20120614154820.GG17140@kroah.com> <CAMQu2gx5CCDyrvozX06neBnA8J2heg+HL7DOewDm5voxqbpetw@mail.gmail.com>
 <CAMQu2gy7oj-+1qCteAFMXEeOL-Wdrs6e4gKWM=HsOukXcPuv-A@mail.gmail.com>
 <20120625182830.GA23850@kroah.com> <CAMQu2gxDG=69X7UQPUoTLP5h1ZLpHngp=3C4vSDOS6L-N2XZSw@mail.gmail.com>
 <4FE9467A.2050906@ti.com> <CAMQu2gzOszT54ZU0Z3-9k=mMM7yTCH_MCZV=gRKwGoGRj0zjaA@mail.gmail.com>
 <4FE947F7.9030000@ti.com> <CAMQu2gwzFV-79CuEAmOHCZ7XivXrALjXkoB+J-QpgJkZ_PoRVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:58927 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754411Ab2F2Nqw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 09:46:52 -0400
Received: by qadz3 with SMTP id z3so663549qad.10
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 06:46:48 -0700 (PDT)
In-Reply-To: <CAMQu2gwzFV-79CuEAmOHCZ7XivXrALjXkoB+J-QpgJkZ_PoRVg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>

Greg,

On Tue, Jun 26, 2012 at 1:19 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>
> On Tue, Jun 26, 2012 at 10:56 AM, Rajendra Nayak <rnayak@ti.com> wrot=
e:
> > On Tuesday 26 June 2012 10:53 AM, Shilimkar, Santosh wrote:
> >>
> >> On Tue, Jun 26, 2012 at 10:49 AM, Rajendra Nayak<rnayak@ti.com> =A0=
wrote:
> >>>
> >>> On Tuesday 26 June 2012 10:39 AM, Shilimkar, Santosh wrote:
> >>>>>>
> >>>>>>
> >>>>>> +#if defined(CONFIG_OF)
> >>>>>>>
> >>>>>>> =A0> =A0 =A0+static const struct of_device_id emif_of_match[]=
 =3D {
> >>>>>>> =A0> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 =A0 { .compatible =3D "ti,e=
mif-4d" },
> >>>>>>> =A0> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 =A0 { .compatible =3D "ti,e=
mif-4d5" },
> >>>>>>> =A0> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 =A0 {},
> >>>>>>> =A0> =A0 =A0+};
> >>>>>>> =A0> =A0 =A0+MODULE_DEVICE_TABLE(of, emif_of_match);
> >>>>>>> =A0> =A0 =A0+#endif
> >>>>>>> =A0> =A0 =A0+
> >>>>>>> =A0> =A0 =A0 =A0static struct platform_driver emif_driver =3D=
 {
> >>>>>>> =A0> =A0 =A0 =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p=
(emif_remove),
> >>>>>>> =A0> =A0 =A0 =A0 =A0 =A0 .shutdown =A0 =A0 =A0 =3D emif_shutd=
own,
> >>>>>>> =A0> =A0 =A0 =A0 =A0 =A0 .driver =3D {
> >>>>>>> =A0> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "emif",
> >>>>>>> =A0> =A0 =A0+#if defined(CONFIG_OF)
> >>>>>>> =A0> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_=
match_ptr(emif_of_match),
> >>>>>>> =A0> =A0 =A0+#endif
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> =A0Are these two still #if defined needed?
> >>>>>>
> >>>>>> =A0Also, what about the IS_DEFINED macro?
> >>>>>>
> >>>>
> >>>> Yes. To avoid the build break in !DT build.
> >>>>
> >>>
> >>> No, infact of_match_ptr is there just so you can avoid a
> >>> #ifdef around and not break !CONFIG_OF.
> >>
> >>
> >> Need to recheck but the build was throwing error becasue of
> >> "emif_of_match"
> >> mostly.
> >
> >
> > You still need the first one. I meant the second one around
> > 'of_match_ptr' should be removed.
> >
> > With !CONFIG_OF, of_match_ptr(_ptr) is just defined as NULL.
> >
> Yep. That make sense too.
> Will drop the second check.
>
Posted the entire series again with updated $subject patch.
With your ack, I will ask Tony to pull this series for 3.6.

regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
