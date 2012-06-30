From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 4/4] memory: emif: add device tree support to emif driver
Date: Sat, 30 Jun 2012 09:44:05 +0530
Message-ID: <CAMQu2gzBxYT1axeLpbDrRJMJa9jB+D7BkQCLZH_bfO96AzT+mg@mail.gmail.com>
References: <CAMQu2gy7oj-+1qCteAFMXEeOL-Wdrs6e4gKWM=HsOukXcPuv-A@mail.gmail.com>
 <20120625182830.GA23850@kroah.com> <CAMQu2gxDG=69X7UQPUoTLP5h1ZLpHngp=3C4vSDOS6L-N2XZSw@mail.gmail.com>
 <4FE9467A.2050906@ti.com> <CAMQu2gzOszT54ZU0Z3-9k=mMM7yTCH_MCZV=gRKwGoGRj0zjaA@mail.gmail.com>
 <4FE947F7.9030000@ti.com> <CAMQu2gwzFV-79CuEAmOHCZ7XivXrALjXkoB+J-QpgJkZ_PoRVg@mail.gmail.com>
 <CAMQu2gx2RT0iyo+LD1TyTJg9FRSUD8SK2tA=nxAoULzQOa6L7A@mail.gmail.com>
 <20120629210752.GA13859@kroah.com> <4FEE1E04.1060600@ti.com> <20120630025057.GA3482@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:53386 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750699Ab2F3EO1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Jun 2012 00:14:27 -0400
Received: by qaas11 with SMTP id s11so1053143qaa.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 21:14:25 -0700 (PDT)
In-Reply-To: <20120630025057.GA3482@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jon Hunter <jon-hunter@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>, linux-arm-kernel@lists.infradead.org

On Sat, Jun 30, 2012 at 8:20 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Jun 29, 2012 at 04:28:36PM -0500, Jon Hunter wrote:
>>
>> On 06/29/2012 04:07 PM, Greg Kroah-Hartman wrote:
>> > On Fri, Jun 29, 2012 at 07:16:19PM +0530, Shilimkar, Santosh wrote=
:
>> >> Greg,
>> >>
>> >> On Tue, Jun 26, 2012 at 1:19 PM, Shilimkar, Santosh
>> >> <santosh.shilimkar@ti.com> wrote:
>> >>>
>> >>> On Tue, Jun 26, 2012 at 10:56 AM, Rajendra Nayak <rnayak@ti.com>=
 wrote:
>> >>>> On Tuesday 26 June 2012 10:53 AM, Shilimkar, Santosh wrote:
>> >>>>>
>> >>>>> On Tue, Jun 26, 2012 at 10:49 AM, Rajendra Nayak<rnayak@ti.com=
> =A0wrote:
>> >>>>>>
>> >>>>>> On Tuesday 26 June 2012 10:39 AM, Shilimkar, Santosh wrote:
>> >>>>>>>>>
>> >>>>>>>>>
>> >>>>>>>>> +#if defined(CONFIG_OF)
>> >>>>>>>>>>
>> >>>>>>>>>> =A0> =A0 =A0+static const struct of_device_id emif_of_mat=
ch[] =3D {
>> >>>>>>>>>> =A0> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 =A0 { .compatible =3D "=
ti,emif-4d" },
>> >>>>>>>>>> =A0> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 =A0 { .compatible =3D "=
ti,emif-4d5" },
>> >>>>>>>>>> =A0> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 =A0 {},
>> >>>>>>>>>> =A0> =A0 =A0+};
>> >>>>>>>>>> =A0> =A0 =A0+MODULE_DEVICE_TABLE(of, emif_of_match);
>> >>>>>>>>>> =A0> =A0 =A0+#endif
>> >>>>>>>>>> =A0> =A0 =A0+
>> >>>>>>>>>> =A0> =A0 =A0 =A0static struct platform_driver emif_driver=
 =3D {
>> >>>>>>>>>> =A0> =A0 =A0 =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __ex=
it_p(emif_remove),
>> >>>>>>>>>> =A0> =A0 =A0 =A0 =A0 =A0 .shutdown =A0 =A0 =A0 =3D emif_s=
hutdown,
>> >>>>>>>>>> =A0> =A0 =A0 =A0 =A0 =A0 .driver =3D {
>> >>>>>>>>>> =A0> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "emif"=
,
>> >>>>>>>>>> =A0> =A0 =A0+#if defined(CONFIG_OF)
>> >>>>>>>>>> =A0> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D=
 of_match_ptr(emif_of_match),
>> >>>>>>>>>> =A0> =A0 =A0+#endif
>> >>>>>>>>
>> >>>>>>>>
>> >>>>>>>>>
>> >>>>>>>>> =A0Are these two still #if defined needed?
>> >>>>>>>>>
>> >>>>>>>>> =A0Also, what about the IS_DEFINED macro?
>> >>>>>>>>>
>> >>>>>>>
>> >>>>>>> Yes. To avoid the build break in !DT build.
>> >>>>>>>
>> >>>>>>
>> >>>>>> No, infact of_match_ptr is there just so you can avoid a
>> >>>>>> #ifdef around and not break !CONFIG_OF.
>> >>>>>
>> >>>>>
>> >>>>> Need to recheck but the build was throwing error becasue of
>> >>>>> "emif_of_match"
>> >>>>> mostly.
>> >>>>
>> >>>>
>> >>>> You still need the first one. I meant the second one around
>> >>>> 'of_match_ptr' should be removed.
>> >>>>
>> >>>> With !CONFIG_OF, of_match_ptr(_ptr) is just defined as NULL.
>> >>>>
>> >>> Yep. That make sense too.
>> >>> Will drop the second check.
>> >>>
>> >> Posted the entire series again with updated $subject patch.
>> >> With your ack, I will ask Tony to pull this series for 3.6.
>> >
>> > Sent them where? =A0I didn't see a copy here :(
>>
My bad. Accidentally in reworked patch, CC line got dropped.

>> Hi Greg, should have hit both linux-omap and linux-arm. See:
>>
>> http://marc.info/?l=3Dlinux-omap&m=3D134097764625471&w=3D2
>
> Ah, two lists I am not on, so how would I know to be able to ack them=
?
> Please always cc: people you wish to review patches, otherwise it cou=
ld
> get lost, or as in this case, the people might not even be on the lis=
ts
> you send the patches to.
>
I just bounced the $subject patch looping you.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
