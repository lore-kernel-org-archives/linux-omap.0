From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] ARM: DRA7: Add support for soc_is_dra74x() and
 soc_is_dra72x() variants
Date: Thu, 28 Aug 2014 06:19:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1408280618480.21985@utopia.booyaka.com>
References: <1406523237-6905-1-git-send-email-lokeshvutla@ti.com> <1406523237-6905-2-git-send-email-lokeshvutla@ti.com> <alpine.DEB.2.02.1407280529320.24161@utopia.booyaka.com> <53D5E0F4.3080607@ti.com>
 <CAGo_u6pZiyJ8574YUXvg_Pz_P=LDeot-kFh7NQJBUqgwsR+Fmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53205 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932680AbaH1GTt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2014 02:19:49 -0400
In-Reply-To: <CAGo_u6pZiyJ8574YUXvg_Pz_P=LDeot-kFh7NQJBUqgwsR+Fmw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, 27 Aug 2014, Nishanth Menon wrote:

> On Mon, Jul 28, 2014 at 12:34 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
> > On Monday 28 July 2014 10:59 AM, Paul Walmsley wrote:
> >> On Mon, 28 Jul 2014, Lokesh Vutla wrote:
> >>
> >>> From: Rajendra Nayak <rnayak@ti.com>
> >>>
> >>> Use the corresponding compatibles to identify the devices.
> >>>
> >>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >>> Acked-by: Nishanth Menon <nm@ti.com>
> >>> Tested-by: Nishanth Menon <nm@ti.com>
> >>
> >> Thanks, queued for (hopefully) early v3.17-rc.
> > Thanks Paul.
> >
> Paul, Tony,
> 
> we are at 3.17-rc2 today, unfortunately..
> http://slexy.org/view/s20MbRgipa dra72-evm is still broken due to
> this. Needs:
> https://patchwork.kernel.org/patch/4632161/ and
> https://patchwork.kernel.org/patch/4632171/
> 
> What can we do to help speed this along?

A simple reminder, like this one, is good.  Also providing boards and 
documentation generally helps, so the patches can be tested and reviewed.


- Paul
