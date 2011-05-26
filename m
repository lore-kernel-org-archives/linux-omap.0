From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC][PATCH 9/9] OMAP4460: dpll: Support MPU frequencies > 1 Ghz
Date: Wed, 25 May 2011 21:53:15 -0700
Message-ID: <BANLkTimNbJi7UNuJWBabOAxCWayRDEn1fQ@mail.gmail.com>
References: <1306375016-707-1-git-send-email-nm@ti.com> <1306375016-707-10-git-send-email-nm@ti.com>
 <20110526031634.GA23867@google.com> <4DDDD385.2000706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:56412 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751054Ab1EZExi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 00:53:38 -0400
Received: by bwz18 with SMTP id 18so301566bwz.1
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 21:53:35 -0700 (PDT)
In-Reply-To: <4DDDD385.2000706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Todd Poynor <toddpoynor@google.com>, linux-omap <linux-omap@vger.kernel.org>, Vishwanath BS <vishwanath.bs@ti.com>, Paul <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Wed, May 25, 2011 at 21:13, Rajendra Nayak <rnayak@ti.com> wrote:
> On 5/26/2011 8:46 AM, Todd Poynor wrote:
>>
>> On Wed, May 25, 2011 at 06:56:56PM -0700, Nishanth Menon wrote:
>> ...
>>>
>>> @@ -427,6 +465,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk=
,
>>> unsigned long rate)
>>> =A0 =A0 =A0 =A0u16 freqsel =3D 0;
>>> =A0 =A0 =A0 =A0struct dpll_data *dd;
>>> =A0 =A0 =A0 =A0int ret;
>>> + =A0 =A0 =A0 unsigned long orig_rate =3D 0;
>>>
>>> =A0 =A0 =A0 =A0if (!clk || !rate)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>> @@ -454,6 +493,19 @@ int omap3_noncore_dpll_set_rate(struct clk *cl=
k,
>>> unsigned long rate)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!ret)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_parent =3D dd->c=
lk_bypass;
>>> =A0 =A0 =A0 =A0} else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* On 4460, the MPU clk for frequen=
cies higher than 1Ghz
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is sourced from CLKOUTX2_M3, ins=
tead of CLKOUT_M2,
>>> while
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* value of M3 is fixed to 1. Hence=
 for frequencies
>>> higher
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* than 1 Ghz, lock the DPLL at hal=
f the rate so the
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* CLKOUTX2_M3 then matches the req=
uested rate.
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap446x()&& =A0!strcmp(cl=
k->name,
>>> "dpll_mpu_ck")
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 && =A0(rate> =A01000000000)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 orig_rate =3D rate;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate =3D rate/2;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> +
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dd->last_rounded_rate !=3D rate)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_dpll_round_rat=
e(clk, rate);
>>>
>>> @@ -468,6 +520,12 @@ int omap3_noncore_dpll_set_rate(struct clk *cl=
k,
>>> unsigned long rate)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WARN=
_ON(1);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the rate back to original for =
book keeping*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (orig_rate) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate =3D orig_rate;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dd->last_rounded_rate=
 =3D dd->last_rounded_rate *
>>> 2;
>>
>> Not sure why dd->last_rounded_rate is being adjusted here. =A0Its
>> value was computed based on orig_rate/2, and this adjustment will
>> force the code above to call omap2_dpll_round_rate() every time
>> (because the * 2 value will never equal the / 2 value). =A0I haven't
>> seen the value reported anywhere, so it doesn't seem necessary?
>
> Todd, I have to admit I have'nt even tested this patch myself on a 44=
60
> (I don't even have one) and I did mention this to Nishanth when I sen=
t
> this out to him.
> You are right that playing with the last_rounded_rate is not a good
> idea, that was done thinking the omap3_noncore_dpll_program then uses
> it and it needs the orig_rate and not the /2. But that certainly
> causes the omap2_dpll_round_rate to get called every time.
> I need to work some more on this patch and certainly *test* it to
> work on a 4460.
Hmm.. I apologize, I had expected the bootloader I was using was
supposed to boot at highest frequency - I might have been
mistaken(expectation was to test without a DVFS framework). However,
that said, the interest here in RFC itself (beyond the point that it
is done wrongly - thanks for confirming), is to know if this is the
right place to handle it. Looping in Paul and Benoit as well for their
views on the approach taken.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
