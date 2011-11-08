From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v5 3/7] arm: perf: support device with other non-irq resources
Date: Tue, 8 Nov 2011 17:25:52 +0800
Message-ID: <CACVXFVPD90q0euQXXG+3ujyvzxCjAovFSSPKvqf6esU7vkD7Tg@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-4-git-send-email-ming.lei@canonical.com>
	<20111024150814.GA4771@mudshark.cambridge.arm.com>
	<CACVXFVOzQ0QEnaAb=mLFdr7AU3H3TsT=wXcNgtqeUGVLXahd4Q@mail.gmail.com>
	<20111025083420.GA6184@mudshark.cambridge.arm.com>
	<alpine.DEB.2.00.1110250242130.27118@utopia.booyaka.com>
	<CACVXFVOVeuWpVGSUP-sDDbiWb=W8XVB+PDYns4ttK9+ty0GMmA@mail.gmail.com>
	<alpine.DEB.2.00.1110250459160.12667@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39730 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab1KHJZy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 04:25:54 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RNhwH-0007FU-Hh
	for linux-omap@vger.kernel.org; Tue, 08 Nov 2011 09:25:53 +0000
Received: by ggnb2 with SMTP id b2so331094ggn.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Nov 2011 01:25:52 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1110250459160.12667@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, b-cousson@ti.com, "tony@atomide.com" <tony@atomide.com>, Will Deacon <will.deacon@arm.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Oct 25, 2011 at 7:00 PM, Paul Walmsley <paul@pwsan.com> wrote:
> + Beno=EEt
>
> Hi
>
> On Tue, 25 Oct 2011, Ming Lei wrote:
>
>> On Tue, Oct 25, 2011 at 4:44 PM, Paul Walmsley <paul@pwsan.com> wrot=
e:
>> > On Tue, 25 Oct 2011, Will Deacon wrote:
>> >
>> >> Hurrah! If you can get the OMAP / hwmod bits acked by the OMAP gu=
ys then I'm
>> >> happy to take the perf and PMU changes into my tree.
>> >
>> > I'd suggest that you take the perf/PMU stuff yourself if you are h=
appy
>> > with it, and then we'll deal with the OMAP bits ourselves, since i=
t looks
>> > like they aren't dependent on each other, and the OMAP parts will =
need
>> > changes.
>>
>> One omap4 patch(struct arm_pmu_platdata related) depends on 2/7, whi=
ch
>> need to be rebased. But I still suggest that arm perf/PMU stuff may =
be
>> merged first.
>>
>> Paul, expect your comments on OMAP4 parts.
>
> Beno=EEt is the right person to review OMAP4 hwmod data.

Beno=EEt, gentle ping, :-)

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
