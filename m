From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v5 3/7] arm: perf: support device with other non-irq resources
Date: Tue, 25 Oct 2011 18:23:03 +0800
Message-ID: <CACVXFVOVeuWpVGSUP-sDDbiWb=W8XVB+PDYns4ttK9+ty0GMmA@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-4-git-send-email-ming.lei@canonical.com>
	<20111024150814.GA4771@mudshark.cambridge.arm.com>
	<CACVXFVOzQ0QEnaAb=mLFdr7AU3H3TsT=wXcNgtqeUGVLXahd4Q@mail.gmail.com>
	<20111025083420.GA6184@mudshark.cambridge.arm.com>
	<alpine.DEB.2.00.1110250242130.27118@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48258 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465Ab1JYKXG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Oct 2011 06:23:06 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RIe9w-0005Fl-Kk
	for linux-omap@vger.kernel.org; Tue, 25 Oct 2011 10:23:04 +0000
Received: by ggnb1 with SMTP id b1so329941ggn.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Oct 2011 03:23:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110250242130.27118@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Will Deacon <will.deacon@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Tue, Oct 25, 2011 at 4:44 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 25 Oct 2011, Will Deacon wrote:
>
>> Hurrah! If you can get the OMAP / hwmod bits acked by the OMAP guys then I'm
>> happy to take the perf and PMU changes into my tree.
>
> I'd suggest that you take the perf/PMU stuff yourself if you are happy
> with it, and then we'll deal with the OMAP bits ourselves, since it looks
> like they aren't dependent on each other, and the OMAP parts will need
> changes.

One omap4 patch(struct arm_pmu_platdata related) depends on 2/7, which
need to be rebased. But I still suggest that arm perf/PMU stuff may be
merged first.

Paul, expect your comments on OMAP4 parts.

thanks,
--
Ming Lei
