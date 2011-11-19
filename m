From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Sat, 19 Nov 2011 22:42:25 +0800
Message-ID: <CACVXFVNuz62+2DzOks3-0io2Ni=LK5SJienU4GcGRMtkh92vvQ@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-5-git-send-email-ming.lei@canonical.com>
	<alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
	<CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
	<alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
	<4EC6566C.70202@ti.com>
	<20111118145635.GB17991@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48273 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1KSOm0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Nov 2011 09:42:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RRm7e-0001VM-11
	for linux-omap@vger.kernel.org; Sat, 19 Nov 2011 14:42:26 +0000
Received: by eye27 with SMTP id 27so4261119eye.19
        for <linux-omap@vger.kernel.org>; Sat, 19 Nov 2011 06:42:25 -0800 (PST)
In-Reply-To: <20111118145635.GB17991@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi Will,

On Fri, Nov 18, 2011 at 10:56 PM, Will Deacon <will.deacon@arm.com> wro=
te:
> Hi Benoit,
>
> On Fri, Nov 18, 2011 at 12:58:20PM +0000, Cousson, Benoit wrote:
>> Hi Ming Lei,
>>
>> Sorry, for the delay, it took me some time to gather the exhaustive =
data for that block.
>
> Thanks for looking at this! I don't think we'd have managed to get al=
l of
> the magic numbers in the right place ourselves :)
>
> Ming Lei - can you take this into your patch series please?

Yes, I have made omap4 pmu work already with Benoit's patch,
and if no one has objections on other patches(5/7, 6/7, 7/7), I
can post out the next version for -next tree.

>
> Then we'll have:
>
> =A0 =A0 =A0 =A0- The two perf patches in my tree
> =A0 =A0 =A0 =A0- The hwmod fix in Tony's tree (pending pull)
> =A0 =A0 =A0 =A0- Your patches plus this one for hooking everything to=
gether
>
> The sooner we can push these into -next, the better.
>
> Cheers,
>
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
