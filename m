From: Kevin Hilman <khilman@ti.com>
Subject: Re: Regressions for older OMAP3503 silicon
Date: Wed, 05 Oct 2011 16:28:26 -0700
Message-ID: <87r52rnhlx.fsf@ti.com>
References: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
	<877h4j5my0.fsf@ti.com>
	<CAGDS+nng341_xQMAmQcu9J0avk0p1bbYC2vs53qTAc-DguoKZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:57165 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935488Ab1JEX2a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Oct 2011 19:28:30 -0400
Received: by pzk36 with SMTP id 36so6042596pzk.7
        for <linux-omap@vger.kernel.org>; Wed, 05 Oct 2011 16:28:29 -0700 (PDT)
In-Reply-To: <CAGDS+nng341_xQMAmQcu9J0avk0p1bbYC2vs53qTAc-DguoKZg@mail.gmail.com>
	(Steve Sakoman's message of "Wed, 5 Oct 2011 12:48:49 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Dave Hylands <dhylands@gmail.com>, linux-omap@vger.kernel.org

Steve Sakoman <sakoman@gmail.com> writes:

> On Wed, Oct 5, 2011 at 11:10 AM, Kevin Hilman <khilman@ti.com> wrote:
>
>> The need to comment this out suggests that omap3_has_io_wakeup() is
>> returning true for this SoC but should not.
>>
>> Looking at mach-omap2/io.c, that feature flag is not set on the 3505=
 and
>> 3517, but is set on the 3503:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cpu_is_omap3505() && !cpu_is_omap351=
7())
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_features=
 |=3D OMAP3_HAS_IO_WAKEUP;
>>
>> Adding a case for the 3503 here should fix this problem.
>>
>> Maybe check other checks for cpu_is_omap3505() and see if those shou=
ld
>> also be checking for the 3503.
>
> I only see this error on ES2.1 3503 based Overo COMs.
>
> So I am wondering if there might be an errata in this area for early
> 3503 processors?

The IO daisy chain feature was added in later revisions (for 34xx, it
only exists for >=3D ES3.1.)  Sounds like enabling that feature flag
should have some revision checks added.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
