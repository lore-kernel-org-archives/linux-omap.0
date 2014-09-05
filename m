From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] ARM: DRA7: Add support for soc_is_dra74x() and
 soc_is_dra72x() variants
Date: Fri, 5 Sep 2014 18:08:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1409051803190.9444@utopia.booyaka.com>
References: <1406523237-6905-1-git-send-email-lokeshvutla@ti.com> <1406523237-6905-2-git-send-email-lokeshvutla@ti.com> <alpine.DEB.2.02.1407280529320.24161@utopia.booyaka.com> <53D5E0F4.3080607@ti.com> <CAGo_u6pZiyJ8574YUXvg_Pz_P=LDeot-kFh7NQJBUqgwsR+Fmw@mail.gmail.com>
 <alpine.DEB.2.02.1408280618480.21985@utopia.booyaka.com> <CAGo_u6qLJdrHw-FosDvhdvMQxQntf=ujZdRW+MrCdqbHZruU4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57362 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbaIESIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2014 14:08:42 -0400
In-Reply-To: <CAGo_u6qLJdrHw-FosDvhdvMQxQntf=ujZdRW+MrCdqbHZruU4A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 28 Aug 2014, Nishanth Menon wrote:

> On Thu, Aug 28, 2014 at 1:19 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Wed, 27 Aug 2014, Nishanth Menon wrote:
> >
> >> On Mon, Jul 28, 2014 at 12:34 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
> >> > On Monday 28 July 2014 10:59 AM, Paul Walmsley wrote:
> >> >> On Mon, 28 Jul 2014, Lokesh Vutla wrote:
> >> >>
> >> >>> From: Rajendra Nayak <rnayak@ti.com>
> >> >>>
> >> >>> Use the corresponding compatibles to identify the devices.
> >> >>>
> >> >>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >> >>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >> >>> Acked-by: Nishanth Menon <nm@ti.com>
> >> >>> Tested-by: Nishanth Menon <nm@ti.com>
> >> >>
> >> >> Thanks, queued for (hopefully) early v3.17-rc.
> >> > Thanks Paul.
> >> >
> >> Paul, Tony,
> >>
> >> we are at 3.17-rc2 today, unfortunately..
> >> http://slexy.org/view/s20MbRgipa dra72-evm is still broken due to
> >> this. Needs:
> >> https://patchwork.kernel.org/patch/4632161/ and
> >> https://patchwork.kernel.org/patch/4632171/
> >>
> >> What can we do to help speed this along?
> >
> > A simple reminder, like this one, is good.  Also providing boards and
> > documentation generally helps, so the patches can be tested and reviewed.
> 
> TI is working diligently towards a public TRM and potentially a
> related platform as well for all.
> 
> Unfortunately, I am not yet aware of a official finalized release
> date.. hopefully this year..

OK

> In the meanwhile, we will try to provide test logs that you may desire 
> for at least the platforms we have functioning and access to. please 
> feel free to request specific test vectors if you feel our coverage is 
> not good enough.

Thanks.  You've been showing a lot of great leadership in proactively 
posting test logs.  What I'd suggest doing is to keep that up, and if 
possible, post one of the test reports for each patch series that's 
posted, if possible. 


- Paul
