From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 0/8] drivers: touchscreen: tsc2007 and ads7846/tsc2046 improvements (use common touchscreen bindings, pre-calibration, spi fix and provide iio raw values)
Date: Wed, 15 Feb 2017 15:03:07 +0100
Message-ID: <751454D6-9552-48D9-91EC-37DAD7B1A576@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <BB8421B2-6626-4A95-BCD0-25C4CAF30F61@goldelico.com> <17d2c23b-6cbb-d365-71cb-fd4d7af7c958@kernel.org> <B04BF50A-A54E-4CA2-BB0E-7B547D40403A@goldelico.com> <85077609-9A95-4DBC-BDC8-649C8692065B@goldelico.com> <3225CF5D-53B7-456F-8128-50BCF31ADD0F@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3225CF5D-53B7-456F-8128-50BCF31ADD0F-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

> Am 12.02.2017 um 16:18 schrieb H. Nikolaus Schaller =
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>:
>=20
> Hi Dmitry,
>=20
>> Am 28.01.2017 um 19:16 schrieb H. Nikolaus Schaller =
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>:
>>=20
>> Hi Dmitry,
>> there have been no further comments/complaints about this patch =
series in the last month.
>> And it appears as if only your action is needed.
>>=20
>> What is missing for this patch series to be finally accepted?
>=20
> Did you find time to look into my comment on patch 1/9 and make a =
decision on patch 6/8?
>=20
> Is there anything open which prohibits inclusion to (and further =
testing within) linux/next?

May I ask a question for my fundamental understanding of the Linux =
integration process.
Maybe, I have a wrong expectation which you can clarify.

My question is how it does come that patches like

=
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?i=
d=3D449aa83e69ff10d77fe088eadacafe1e97937c14

appear within 2 days in linux-next, but our patch series had months of =
review (we are at v9)
and there have been no further comments from the community for weeks?

What is still missing what we can do or provide as information?

BR and thanks,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
