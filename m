From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 0/3] OMAP2+ hwmod fixes
Date: Tue, 22 Feb 2011 18:41:36 +0530
Message-ID: <e6550ef1ea27499e3bc093e264c54d0f@mail.gmail.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com>
 <4D5BCC10.2060301@ti.com> <6cc4b2788ff1e15c22987d5db91f0395@mail.gmail.com>
 <4D5E85EA.70605@ti.com> <alpine.DEB.2.00.1102210901140.22636@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:38267 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751697Ab1BVNLl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 08:11:41 -0500
Received: by mail-bw0-f54.google.com with SMTP id 12so3543686bwz.41
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 05:11:40 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102210901140.22636@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, February 21, 2011 10:25 PM
> To: Cousson, Benoit; Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 0/3] OMAP2+ hwmod fixes
>
> Hello Beno=EEt, Rajendra,
>
> On Fri, 18 Feb 2011, Cousson, Benoit wrote:
>
> > On 2/16/2011 2:43 PM, Nayak, Rajendra wrote:
> > > > -----Original Message-----
> > > > From: Cousson, Benoit [mailto:b-cousson@ti.com]
> > > > Sent: Wednesday, February 16, 2011 6:37 PM
> > > > To: Nayak, Rajendra
> > > > Cc: linux-omap@vger.kernel.org; paul@pwsan.com;
> > > linux-arm-kernel@lists.infradead.org
> > > > Subject: Re: [PATCH 0/3] OMAP2+ hwmod fixes
> > > >
> > > > Hi Rajendra,
> > > >
> > > > On 2/16/2011 1:11 PM, Nayak, Rajendra wrote:
> > > > > This series fixes some hwmod api return values
> > > > > and also adds some state checks.
> > > > > The hwmod iterator functions are made to
> > > > > continue and not break if one of the
> > > > > callback functions ends up with an error.
> > > >
> > > > By doing that, you change the behavior of this function.
> > > > I'm not sure I fully understand why.
> > > > Could you elaborate on the use case?
> > >
> > > Since these functions iterate over all hwmods
> > > calling a common callback function, there might
> > > be cases wherein the callback function for *some*
> > > hwmods might fail. For instance, if you run through
> > > all hwmods and try to clear the context registers
> > > for all of them, for some hwmods which might
> > > not have context registers the callback function
> > > might return a -EINVAL, however that should not
> > > stop you from attempting to clear the context
> > > registers for the rest of the hwmods which have
> > > them and abort the function midway, no?
> > > This is more hypothetical, however the real usecase
> > > that prompted me with this patch was when I
> > > had some wrong state check in _setup function,
> > > and the iterator would stop with the first failure
> > > and not even attempt to setup the rest of the
> > > hwmods.
> >
> > Yeah, but by using that function you implicitly accept that an erro=
r
will
> > break the loop, so the function you pass to the iterator should be
written for
> > that. Meaning if you do not want to exit on error you should not
report an
> > error.
> >
> > > > To avoid that behavior in the past, I was just returning
> > > > 0 in case of failure to avoid stopping the iteration.
> > > > It looks like you do not want to stop the iteration but still
> > > > retrieve the error.
> > > > I do not see in this series what you plan to do with the
> > > > error at the end of the iteration.
> > >
> > > Most users of these iterators would just use the non-zero
> > > return value to throw an error/warning out stating there
> > > were failures running through all the callback functions.
> > > That does not change with this patch, and they can still
> > > do it.
> >
> > Except that now, the iterator is not able anymore to stop on error =
if
needed
> > potentially.
> > My point is that you are changing the behavior of this function
without
> > maintaining the legacy.
> >
> > So maybe creating a new iterator is a better approach.
> > Even is this feature is not used today I have some secret plan for
this
> > behavior in the near future :-)
> >
> > But my initial comment is still valid, if you do not care about the
final
> > error status after the iteration, you'd better not return any error=
 at
the
> > beginning.
> > This was the behavior or the _setup until now.
>
> The original behavior of the iterator was intentional: loops over
> functions like _init_clocks() and _setup() should terminate upon
> encountering an error.  This is because the rest of that code current=
ly
> relies on the hwmod/clock data to be accurate in order to work.  Ther=
e
is
> no provision in the code for a hwmod to fail initialization due to da=
ta
> errors.  The idea was that if the data is inaccurate, the data should=
 be
> fixed first before doing anything else.

The original behavior of the iterators, to terminate upon
encountering an error, seems fine to me. The only problem
I faced was that they fail silently and go undetected, unless
their user catches the return value and WARN's, which I found
was not the case with most users, mainly those of
omap_hwmod_for_each_by_class.
I was thinking of keeping the behaviour of these iterators
same for now and add WARN's in these iterators itself upon
an error, so its seen even if the user fails to catch it.

Regards,
Rajendra

>
> That said, I suppose that it's possible to enhance the code such that
> hwmods could be allowed to fail initialization, and simply brick
> themselves, rather than prevent the rest of the hwmods from
initializing.
> Probably that would need a new _HWMOD_STATE_INIT_FAILED, or something
> similar.  If a hwmod would end up in that state, it must not be used =
by
> any other code, and the code should complain loudly.
>
> The broader issue of whether the iterators should return immediately
upon
> failure (as the current code does), or continue through the rest of t=
he
> list, is a separate one.  I'd suggest one of two approaches:
>
> 1. If the rest of the code can be changed to gracefully handle cases
where
> hwmod initialization fails, and if Beno=EEt agrees, I don't have a pr=
oblem
> with changing the iterator behavior to ignore failures as you describ=
e.
> Of course, all of the current users of omap_hwmod_for_each*() would n=
eed
> to be checked to ensure that this behavior makes sense for them.
>
> ... or ...
>
> 2. The iterators could take an extra parameter that would control the
> behavior upon encountering an error: terminate, or continue.  But I a=
m
not
> sure that both cases are needed.  Ideas, feedback here are welcome.
>
>
> - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
