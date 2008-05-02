From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: PM Issues after Android bootup on 2430
Date: Fri, 2 May 2008 09:16:45 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C001578E7762@dbde02.ent.ti.com>
References: <70E3BF80B2DA6E469688AD5C3BBCC6C40365F3B7@BLR-EC-MBX02.wipro.com>
	<782515bb0804291818w2296bdcajc026f3ab6e6af96a@mail.gmail.com>
 <87d4o5elx0.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54943 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbYEBDsP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 May 2008 23:48:15 -0400
In-Reply-To: <87d4o5elx0.fsf@paris.hilman.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>, Nishanth Menon <menon.nishanth@gmail.com>
Cc: "shivananda.hebbarp@wipro.com" <shivananda.hebbarp@wipro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, May 02, 2008 3:18 AM
> To: Nishanth Menon
> Cc: shivananda.hebbarp@wipro.com; linux-omap@vger.kernel.org
> Subject: Re: PM Issues after Android bootup on 2430
>
> "Nishanth Menon" <menon.nishanth@gmail.com> writes:
>
> > On 4/29/08, shivananda.hebbarp@wipro.com <shivananda.hebbarp@wipro.com>
> wrote:
> >> omapfb omapfb: irq error status 00e2
> >> omapfb omapfb: irq error status 0040
> >> omapfb omapfb: irq error status 0040
> >> omapfb omapfb: irq error status 0040
> >> omapfb omapfb: irq error status 0040
> >> omapfb omapfb: irq error status 0040
> >> omapfb omapfb: irq error status 0040
> >> omapfb omapfb: irq error status 0040
> >> omapfb omapfb: irq error status 0040
> >> omapfb omapfb: irq error status 0040
> > This does look suspiciously like the thread
> > http://linux.omap.com/pipermail/linux-omap-open-source/2007-
> July/010566.html
> >
> > Interesting... ;)... I never got the chance to debug this issue..
> >
> > Kevin, Khasim, did u guys get a chance to look at this later?? I dont
> > recollect hearing any one saying the same for 3430 though..
>
> No, I never debugged this any further.  AFAIK, the omapfb is still
> broken in git.
>
Me too :(.

We have FB working for 3530 EVM / Beagle boards. Should be same for 2430/2530 as well.

Regards,
Khasim
