From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
 cause data corruption
Date: Tue, 15 Feb 2011 15:00:11 +0530
Message-ID: <b10e9b5cef20f3f01035d7ffaa465387@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com><1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com><AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com><13596bec9184b117d6a1d02da8e017bf@mail.gmail.com><AANLkTimjXG5-kEW=1vodnGo3Ct_xOS_HihdqN0TeL9ba@mail.gmail.com><33573d5cfc91cf45dc58ee861cccc2ae@mail.gmail.com><4dfaffa99292bf8e36791ea9a68de75e@mail.gmail.com>
 <AANLkTinSOUPZuDikusgnT99Qmqv8p+DNQu2Hu42N=yJb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:52136 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752211Ab1BOJaP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 04:30:15 -0500
Received: by wyj26 with SMTP id 26so5563809wyj.28
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 01:30:13 -0800 (PST)
In-Reply-To: <AANLkTinSOUPZuDikusgnT99Qmqv8p+DNQu2Hu42N=yJb@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>, Catalin Marinas <catalin.marinas@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com

> -----Original Message-----
> From: Andrei Warkentin [mailto:andreiw@motorola.com]
> Sent: Tuesday, February 15, 2011 2:40 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel@lists.infradead.org; linux-
> omap@vger.kernel.org; Kevin Hilman; tony@atomide.com; Catalin
> Marinas
> Subject: Re: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
> operation can cause data corruption
>
> On Tue, Feb 15, 2011 at 1:14 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> >> -----Original Message-----
> >> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> >> Sent: Monday, February 14, 2011 10:39 AM
> >> To: Andrei Warkentin
> >> Cc: linux-omap@vger.kernel.org; Kevin Hilman; tony@atomide.com;
> >> linux-arm-kernel@lists.infradead.org; Catalin Marinas
> >> Subject: RE: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way
> >> operation can cause data corruption
> >>
> >

[....]

> >
>
> Why set by default to NULL, why not have a normal l2x0_set_debug
> which
> just does a write to L2X0_DEBUG_CTRL, and then just invoke the
> function pointer when you wish to manipulate the DCR? That way you
> don't need the runtime check, and it's just clearer, I think.
>
I though about it. There more changes in the file and hence I
avoided it. This can be done though.

> Also, why not do something like -
> ....
> do_stuff();
> #ifdef CONFIG_NEED_ERRATA_1234
> do_errata_stuff();
> #endif
> do_more_stuff();
> ...
>
Which makes code completely ugly.

> instead of  -
>
> ...
> #ifdef CONFIG_NEED_ERRATA_1234
> do_some_stuf() {
> bar();
> }
> #else
> {
> do_some_stuff() {
> }
> // nothing
> }
>
We have already discussed this. The code becomes ugly. If you
are interested in the reasoning, please check archives.

Russell and Catalin has suggested above.

If you understand the errata in first place, you could
understand the comment.

I let Catalin, Russell comment on it more, but unnecessary
CONFIG options and polluting every function with #If, else
checks don't make sense. Rest of your comments are related
to this.

Regards,
Santosh
