From: "Alejandro Blanca G." <alex.blanca@gmail.com>
Subject: Fwd: OMAP1: mcbsp clocks
Date: Fri, 23 Jan 2009 14:02:28 -0600
Message-ID: <b6ab3a160901231202s1422a1b4o7507ecb058c3b309@mail.gmail.com>
References: <20090122235543.GC8137@n2100.arm.linux.org.uk>
	 <20090123011726.GG7172@atomide.com>
	 <20090123174249.GM26184@n2100.arm.linux.org.uk>
	 <20090123175401.GU7172@atomide.com>
	 <7B4574D56E4ADF438756313E9A172A872CABB868@dlee01.ent.ti.com>
	 <20090123191721.GW7172@atomide.com>
	 <b6ab3a160901231159xcfca2ebx3e7390e195bfa102@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:48062 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbZAWUCa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 15:02:30 -0500
Received: by yx-out-2324.google.com with SMTP id 8so2229616yxm.1
        for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2009 12:02:29 -0800 (PST)
In-Reply-To: <b6ab3a160901231159xcfca2ebx3e7390e195bfa102@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Resent as plain text since that's what the linux-omap mail server accepts.

Sorry for the double post (to those who got 2 copies).

-----------

Hi everyone.

First, I'm relatively new to the list and I'm still catching up with
the etiquette to follow.
So, if I break it somehow, please do let me know. It's not my
intention to do so.

Now, I know that the OMAP16xx line of processors is composed (as far
as I know) by the following:

* 1610
* 1611
* 1621
* 1623

Does anybody know about the differences between them and / or about a
document explaining them?

The reason I'm looking for this information is because I've a 1611 SDP
that I'd like to use to boot Linux and some other OSes, but don't know
much about it (compared to the later OMAP families). I would like to
be aware of the differences between them so that I can better select
the versions of the software I'd like to use (in order to avoid
incompatibilities).

Your help will be really appreciated. Thanks in advance for your time.

Cheers,

Alex B.

---------- Forwarded message ----------
From: Alejandro Blanca G. <alex.blanca@gmail.com>
Date: Fri, Jan 23, 2009 at 1:59 PM
Subject: Re: OMAP1: mcbsp clocks
To: Tony Lindgren <tony@atomide.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, Russell King - ARM Linux
<linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org"
<linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Stanley
Miao <stanley.miao@windriver.com>


Hi everyone.

First, I'm relatively new to the list and I'm still catching up with
the etiquette to follow.
So, if I break it somehow, please do let me know. It's not my
intention to do so.

Now, I know that the OMAP16xx line of processors is composed (as far
as I know) by the following:

* 1610
* 1611
* 1621
* 1623

Does anybody know about the differences between them and / or about a
document explaining them?

The reason I'm looking for this information is because I've a 1611 SDP
that I'd like to use to boot Linux and some other OSes, but don't know
much about it (compared to the later OMAP families). I would like to
be aware of the differences between them so that I can better select
the versions of the software I'd like to use (in order to avoid
incompatibilities).

Your help will be really appreciated. Thanks in advance for your time.

Cheers,

Alex B.

On Fri, Jan 23, 2009 at 1:17 PM, Tony Lindgren <tony@atomide.com> wrote:
>
> * Hunter, Jon <jon-hunter@ti.com> [090123 11:03]:
> > Tony Lindgren wrote on Friday, January 23, 2009 11:54 AM:
> >
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090123 09:43]:
> > >> On Thu, Jan 22, 2009 at 05:17:28PM -0800, Tony Lindgren wrote:
> > >>> Basically we currently cannot use virtual clocks because of this
> > >>> and the fact that the parent of the virtual clock may not be known
> > >>> as pointed out by Paul Walmsley.
> > >>
> > >> One other thing I'd like to confirm is how the kernel treats the
> > >> OMAP5912. OMAP5912 is interesting to me at the moment because it
> > >> seems that all the information on it is freely available.  I don't
> > >> know about the others.
> > >>
> > >> However, it would be useful to know how the kernel treats this - iow,
> > >> which of the four categories for OMAP1 SoCs - 310, 730, 1510, 1610.
> > >
> > > 5912 = 1611b = 16xx. Then 1710 is quite similar.
> >
> > Right, the OMAP5912 started off life as the 1611, but 1611 involved into the 1621. So really 5912 = 1621. There are a couple differences between the 1610 and 1621, one of the main being the size of the internal RAM.
>
> Thanks for setting that straight. And looks like we have cpu_is_omap1621()
> macro in the kernel.
>
> > >> Of course, if someone knows (or can send me, maybe Richard W?) where
> > >> there's a similar document to spru751a for the clock architecture for
> > >> these other CPUs (and OMAP2420, OMAP2430, OMAP3430, etc) it would be
> > >> most useful.
> >
> > Unfortunately, most of the original devices have NDA restrictions which is a royal pain in the neck especially for people in the open-source community who would like to develop with these. I am sure this infuriates many. Please don't shoot the messenger!
> >
> > I am disappointed it is still that way for some of these parts. The good news is that for OMAP3 we appear to be getting our act together here.
> >
> > > I have some links on my webpage to the docs:
> > >
> > > http://www.muru.com/linux/omap/
> >
> > Tony, I see you have a link on your website to the OMAP3525. The OMAP3530 == OMAP3430, I would recommend that you point people to the following product folder for documentation:
> > http://focus.ti.com/docs/prod/folders/print/omap3530.html
>
> Thanks, fixed now. Also removed some earlier dead link.
>
> > The OMAP3525 has a reduced feature set...see the following page for an overview of the OMAP35xx series:
> > http://wiki.omap.com/index.php?title=OMAP3_Overview
> >
> > Cheers
> > Jon
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
