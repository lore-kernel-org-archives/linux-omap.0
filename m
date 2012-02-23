From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv5 03/14] arm: omap3+: voltage: parameter segregation
Date: Thu, 23 Feb 2012 09:05:44 -0600
Message-ID: <CAOMWX4dR++A4qQKNkdh=k37XGtz8GZ8VGGRO0R8_Ca8-2vmTHg@mail.gmail.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
 <1329833098-19900-4-git-send-email-t-kristo@ti.com> <CAOMWX4d+M9oagDtmSqG=X8Ln4kUEyLaqpfB9Pz0Y+6RmK=sjYw@mail.gmail.com>
 <1329988133.4102.500.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:39615 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754003Ab2BWPGH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 10:06:07 -0500
Received: by werm13 with SMTP id m13so1403879wer.27
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 07:06:04 -0800 (PST)
In-Reply-To: <1329988133.4102.500.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, Feb 23, 2012 at 03:08, Tero Kristo <t-kristo@ti.com> wrote:
> On Wed, 2012-02-22 at 19:37 -0600, Menon, Nishanth wrote:
>> On Tue, Feb 21, 2012 at 08:04, Tero Kristo <t-kristo@ti.com> wrote:
>> [...]
>> > diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/v=
oltage.h
>> > index 949938d..940a0d6 100644
>> > --- a/arch/arm/mach-omap2/voltage.h
>> > +++ b/arch/arm/mach-omap2/voltage.h
>>
>> [...]
>> > @@ -171,6 +169,18 @@ struct omap_voltdm_pmic {
>> > =A0 =A0 =A0 =A0u8 (*uv_to_vsel) (unsigned long uV);
>> > =A0};
>> >
>> > +struct omap_vp_param {
>> > + =A0 =A0 =A0 u32 vddmax;
>> > + =A0 =A0 =A0 u32 vddmin;
>> > +};
>> > +
>>
>> Thinking a little deeper about this(SoC level vdd min and max) on a
>> slightly different angle- core of the question that intend to answer
>> are:
>> =A0- what is the least voltage we want to allow in active transtion?=
 it
>> should not be lower than retention voltage.
>
> I think this is a fair assumption, so we could init the vddmin to be =
the
> same as the retention voltage for the domain (or even drop the
> parameter.)
>
>> - what is the max voltage we want to allow in active transition? it
>> should be the max Nom voltage of all the OPPs for that domain.
>
> Isn't it higher? I guess smartreflex can scale voltages even up from =
the
> nominal level if we have a really old and/or bad silicon. Limiting th=
is
> to max opp would be bad, no? Maybe we could use max opp voltage + som=
e
> margin though... but what would be a safe margin here?
Vnom voltage definition tends to be a variant - yep. at least OMAP3,4 h=
ave
intended to have Vnom as the max voltage for the worst corner lot sampl=
e
at end of life - aka worst possible voltage for that OPP. But with newe=
r process
technologies of the future SoCs, this definition might turn out to beco=
me the
start voltage.

OK, it is safer to have vnom max at max SoC supported voltage i guess t=
o prevent
code churn in the future and maintain compatibility with current SoCs.


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
