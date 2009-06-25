From: Mike Chan <mike@android.com>
Subject: Re: [PATCH 1/2] Support OMAP3 VC adaptation with different Power IC
Date: Thu, 25 Jun 2009 14:18:41 -0700
Message-ID: <8bb80c380906251418n40eda0e9l9e2865eed9486e3e@mail.gmail.com>
References: <4A43CF46.60706@android.com>
	 <B00E06E2766C2744B022DE9BAF3C59D5465B8E@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:52144 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbZFYVSi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 17:18:38 -0400
Received: by pzk27 with SMTP id 27so1592164pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 14:18:41 -0700 (PDT)
In-Reply-To: <B00E06E2766C2744B022DE9BAF3C59D5465B8E@zmy16exm69.ds.mot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Sawsd-A24013 <cqwang@motorola.com>
Cc: linux-omap@vger.kernel.org

On Thu, Jun 25, 2009 at 1:12 PM, Wang Sawsd-A24013<cqwang@motorola.com>=
 wrote:
>> >>> diff --git a/arch/arm/mach-omap2/smartreflex.c
>> >>> b/arch/arm/mach-omap2/smartreflex.c
>> >>> index 9d462e3..bacf602 100644
>> >>> --- a/arch/arm/mach-omap2/smartreflex.c
>> >>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> >>> @@ -52,6 +52,8 @@ struct omap_sr {
>> >>>
>> >>> =A0#define SR_REGADDR(offs) (sr->srbase_addr + offset)
>> >>>
>> >>> +static omap3_voltagescale_vcbypass_t omap3_volscale_vcbypass_fu=
n;
>> >>>
>> >>>
>> >> Perhaps use
>> >> static int (*omap3_volscale_vcbypass_fun) (u32, u32, u8, u8);
>> >>
>> >> This gets rid of the compiler warning on incompatible pointer
>> >> types when
>> >> you register a function via omap3_voltagescale_vcbypass_setup().
>> >>
>> >> -- Mike
>> >>
>> > Thanks Mike, but we do not see the warnning with the original
>> > Code, note this patch is slightly different with the one we sent
>> > To you based on K29, this new patch have four parameters
>> > Sinc some change has been made in the
>> > sr_voltagescale_vcbypass to add two more parameters.
>> >
>> > Is your warnning caused by this?
>> >
>> >
>>
>> This patch stand-alone doesn't give me any warnings. Its only when y=
ou
>> hook into this from your board file. Might be the compiler I'm using=
=2E
>> I used this patch + modified version of the patches you sent me befo=
re
>> to get the two working. (Yes, 4 params).
> I just verified the change on both current linux-omap pm branch and
> The branch we are using, neither of them reports any warnning.
>
> Just reminder, the patch I sent to you are different in all these fil=
es,
> Since we should use 2 params in our kernel, the patch I sent to
> This list has 4 params. Please check whether the warnning
> Is caused by the mismatch in the function declaration and
> The function definition in the board file.
>
> It should not cause the warning even you are using different
> Compiler.
>

Ah you're right, I must have done something wrong on my side. It was
probably the 2 vs 4 params.

-- Mike

>>
>> -- MIke
>> > Thanks,
>> > Chunqiu
>> >
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
