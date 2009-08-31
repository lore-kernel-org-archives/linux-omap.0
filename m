From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: [PATCH 00/18] OMAP: DSS2: Intro
Date: Mon, 31 Aug 2009 20:10:59 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C0037CE48136__45561.2812111669$1251729694$gmane$org@dbde02.ent.ti.com>
References: <1251462337-12531-1-git-send-email-tomi.valkeinen@nokia.com>
	 <4A9B96A7.5040005@gmail.com>
 <5e088bd90908310720p290ba68dwd6106a778fd7c740@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40034 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbZHaOlQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 10:41:16 -0400
In-Reply-To: <5e088bd90908310720p290ba68dwd6106a778fd7c740@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, Artem Bityutskiy <dedekind1@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Steve
> Sakoman
> Sent: Monday, August 31, 2009 7:50 PM
> To: Artem Bityutskiy
> Cc: Andrew Morton; Tony Lindgren; Tomi Valkeinen; linux-kernel@vger.kernel.org; linux-
> omap@vger.kernel.org Mailing List
> Subject: Re: [PATCH 00/18] OMAP: DSS2: Intro
> 
> On Mon, Aug 31, 2009 at 2:23 AM, Artem Bityutskiy<dedekind1@gmail.com> wrote:
> 
> > We are using DSS2 in Nokia for about a year already. N900 is using this
> > code, for example. Other (non-Nokia) projects are using DSS2 as well.
> > The code was public for long time and was sent several times for review.
> >
> > In any case,
> >
> > Tested-by: Artem Bityutskiy <artem.bityutskiy@nokia.com>
> 
> Gumstix has also been shipping with DSS2 on their Overo product for
> many months now.
> 
> Tested-by: Steve Sakoman <steve@sakoman.com>

If there is a concern on OMAP2 support, I can confirm that there is no difference between OMAP2 and OMAP3 Display Subsystem from Register level. So what ever works on OMAP3 DSS2 should straight away work for OMAP2 as well.

I agree with rest of the folks here, we should get DSS2 merged in mainline. It is being extensively used on all OMAP3 platforms.

Regards,
Khasim
