From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value
Date: Fri, 20 Mar 2009 08:28:55 -0700
Message-ID: <20090320152854.GP29546@atomide.com>
References: <94a0d4530903200317h403210f2u622b837be1e5d9a8@mail.gmail.com> <EAF47CD23C76F840A9E7FCE10091EFAB02A925775D@dbde02.ent.ti.com> <94a0d4530903200325s2fd43525ub4d9e6cabb8fbe00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64598 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbZCTP2y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 11:28:54 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530903200325s2fd43525ub4d9e6cabb8fbe00@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Varide, Nischal" <nischal.varide@ti.com>

* Felipe Contreras <felipe.contreras@gmail.com> [090320 03:37]:
> On Fri, Mar 20, 2009 at 12:22 PM, Gupta, Ramesh <grgupta@ti.com> wrote:
> > Felipe,
> >
> >
> >> -----Original Message-----
> >> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> >> Sent: Friday, March 20, 2009 3:48 PM
> >> To: Hiroshi DOYU
> >> Cc: Gupta, Ramesh; Kanigeri, Hari; Guzman Lugo, Fernando;
> >> linux-omap@vger.kernel.org; ameya.palande@nokia.com
> >> Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a
> >> saner value
> >>
> >> On Fri, Mar 20, 2009 at 9:36 AM, Hiroshi DOYU
> >> <Hiroshi.DOYU@nokia.com> wrote:
> >> > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> >> > Migrating to the existing mailbox driver("plat-omap/mailbox.c") is
> >> > also another option to support multiple OMAP architectures
> >> at the same
> >> > time. That mailbox driver has already had a message queuing feature
> >> > inside and it's buildable on OMAP3.
> >>
> >> Yeap, I have it in my to-do list, so if somebody doesn't beat
> >> me to it I play with that.
> >
> > We already started looking into this :), made some progress,
> > will provide more updates in a day or two.
> 
> Sweet! :)

Good to hear. For the common features, we need to have code that
can be shared among all the DSP implementations.

Tony
