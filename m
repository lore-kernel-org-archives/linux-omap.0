From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 4/4] memory: emif: add device tree support to emif driver
Date: Tue, 26 Jun 2012 10:39:59 +0530
Message-ID: <CAMQu2gxDG=69X7UQPUoTLP5h1ZLpHngp=3C4vSDOS6L-N2XZSw@mail.gmail.com>
References: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com>
 <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com>
 <20120614154820.GG17140@kroah.com> <CAMQu2gx5CCDyrvozX06neBnA8J2heg+HL7DOewDm5voxqbpetw@mail.gmail.com>
 <CAMQu2gy7oj-+1qCteAFMXEeOL-Wdrs6e4gKWM=HsOukXcPuv-A@mail.gmail.com> <20120625182830.GA23850@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:35119 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750799Ab2FZFKV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 01:10:21 -0400
Received: by qaeb19 with SMTP id b19so2194088qae.18
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 22:10:19 -0700 (PDT)
In-Reply-To: <20120625182830.GA23850@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>

On Mon, Jun 25, 2012 at 11:58 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 19, 2012 at 02:33:11PM +0530, Shilimkar, Santosh wrote:
> > @@ -1644,11 +1923,23 @@ static void __attribute__((unused))
> > freq_post_notify_handling(void)
> > =A0 =A0 =A0 spin_unlock_irqrestore(&emif_lock, irq_state);
> > =A0}
> >
> > +#if defined(CONFIG_OF)
> > +static const struct of_device_id emif_of_match[] =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 { .compatible =3D "ti,emif-4d" },
> > + =A0 =A0 =A0 =A0 =A0 =A0 { .compatible =3D "ti,emif-4d5" },
> > + =A0 =A0 =A0 =A0 =A0 =A0 {},
> > +};
> > +MODULE_DEVICE_TABLE(of, emif_of_match);
> > +#endif
> > +
> > =A0static struct platform_driver emif_driver =3D {
> > =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(emif_remove),
> > =A0 =A0 =A0 .shutdown =A0 =A0 =A0 =3D emif_shutdown,
> > =A0 =A0 =A0 .driver =3D {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "emif",
> > +#if defined(CONFIG_OF)
> > + =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_match_ptr(emif_of_=
match),
> > +#endif
>
> Are these two still #if defined needed?
>
> Also, what about the IS_DEFINED macro?
>
Yes. To avoid the build break in !DT build.

> And, if you resend, please resend the whole series, I don't have the =
old
> ones around anymore.
>
Ok. Will repost the entire series.
As mentioned earlier, the series needs to go via OMAP tree beasue the
other three
patches are touching the platform files. I will need your ack on the
$subject patch
to queue that via Tony's linux-omap tree.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
