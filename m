From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Wed, 4 Sep 2013 08:12:58 -0700
Message-ID: <CA+Bv8Xac-HdLU5Cx=zi9=eVmd-hx+xJKVxBVHTaXuoM1c94c=Q@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<5211E3F6.6090108@ti.com>
	<52125A39.3010008@ti.com>
	<87vc2qyjao.fsf@linaro.org>
	<521FBD6B.3020208@ti.com>
	<87mwo0rvf8.fsf@linaro.org>
	<CA+Bv8Xamd7e24nswG4QhLDNhHXs92EfXcfu8E2uL=XLhsL70Hw@mail.gmail.com>
	<CAGa+x84okZ_j71=oOnK5c43T9L3gmsGcQjWSxZSchfzheA_2HQ@mail.gmail.com>
	<52261B34.60206@ti.com>
	<CAGa+x85D2tnX_9QDNb6s1LQCpAz_kGUiOK82C7fPLVTmiZMEFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:43515 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674Ab3IDPM6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Sep 2013 11:12:58 -0400
Received: by mail-qa0-f45.google.com with SMTP id f11so2049548qae.4
        for <linux-omap@vger.kernel.org>; Wed, 04 Sep 2013 08:12:58 -0700 (PDT)
In-Reply-To: <CAGa+x85D2tnX_9QDNb6s1LQCpAz_kGUiOK82C7fPLVTmiZMEFg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Gururaja Hebbar <gururaja.hebbar@ti.com>

On Wed, Sep 4, 2013 at 8:01 AM, Kevin Hilman <khilman@linaro.org> wrote:
> Hi Dave,
>
>> Thanks for taking the time to try this out, it does seem there are a few
>> kinks with BeagleBone Black but we'll get those worked out.
>
> I also just noticed that wake from RTC isn't working, but wake from
> serial console does.  Does RTC wake work for you?  (I use rtcwake -m
> mem -s4)
>
> Kevin

On Beaglebone white or black? For PG 1.0 (Beaglebone white) there is
the following errata:

"RTC: 32.768-kHZ Clock is Gating Off"

Details The RTC has a clock gating issue that stops the internal
32.768-kHz clock when the VDD_CORE voltage domain drops below the
recommended operating range or the PWRONRSTn input terminal is held
low. This issue has the following side effects:

- The RTC counters stop incrementing when the 32.768-kHz clock is
gated. This causes the RTC to lose time while the clock is gated.

- A wakeup event applied to the EXT_WAKEUP input terminal is masked if
the EXT_WAKEUP_DB_EN bit in the RTC PMIC register (0x98) is set to 1
which enables the de-bounce function for the EXT_WAKEUP input. This
occurs because the 32.768-kHz clock is being used to clock the
de-bounce circuit.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
