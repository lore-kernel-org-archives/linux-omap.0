From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Fri, 8 Apr 2011 16:23:27 +0200
Message-ID: <4D9F1A5F.1090108@ti.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>  <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>  <1301489930.15095.51.camel@deskari>  <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com> <1301900022.2715.12.camel@deskari> <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59653 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756889Ab1DHOXn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Apr 2011 10:23:43 -0400
In-Reply-To: <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Paul,

On 4/7/2011 9:27 PM, Paul Walmsley wrote:
> Hello Tomi, Beno=EEt,
>
> On Mon, 4 Apr 2011, Tomi Valkeinen wrote:
>
>> On Fri, 2011-04-01 at 20:12 -0600, Paul Walmsley wrote:
>>
>>> Based on the E-mail thread so far, I'd say that changing the clock =
aliases
>>> is the way to go for right now.  The clock aliases are not hardware=
 data;
>>> they just control how the clock hardware is mapped to the drivers.
>>
>> I'd very much prefer this option. Below is a patch for this.
>>
>> If Benoit doesn't complain too much about this, I'd like to get this
>> merged as soon as possible, as OMAP4 DSS is currently crashing in th=
e
>> mainline kernel.
>
> I will queue your clock aliases patch and attempt to merge it upstrea=
m for
> the -rc series.  I am not happy to be disagreeing with Beno=EEt here,=
 but
> this is the rationale that I am using.  (Beno=EEt, Tomi, please feel =
free to
> correct if there is something blatantly false below.)

That's quite good that you were disagreeing with me, because I think=20
that you are indeed right:-)

> 1. The integration of the DSS module is an unusual case.  The
>     MODULEMODE bits for the DSS bits do not control the DSS "main"
>     functional clock (the clock that is needed to access device
>     registers); instead, they only control the DSS interface clock.
>     (This is because the DSS can use a functional clock that is not
>     provided by the OMAP core.)  So calling the DSS MODULEMODE struct
>     clk "dss_fck" is not really correct, since it is really controlli=
ng
>     the interface clock.

I've just got the confirmation from a PRCM designer that this is indeed=
=20
what is happening.

In the case of the DSS the optional functional clocks are provided by=20
the PRCM and thus managed by the PRCM. The only difference is that sinc=
e=20
two different functional clocks are available, the PRCM cannot chose=20
automatically the proper one.
Hence the term optional fck, meaning that the SW has to explicitly=20
enable them. The PRCM will not do it when modulemode will be enabled.

So in that case enabling the modulemode will effectively enable the=20
module for the PRCM point of view and just request the iclk if not=20
already available.

The only point that we need to take care of is the sequence.
The PRCM spec clearly specify that one of the optional clock must be=20
active before the modulemode is enabled.
That does not seems to be the case in the current DSS code.

> 2. This patch does not create a precedent for hacking around general
>     driver clocking problems in the clock or clock data.  This is onl=
y
>     needed because the MODULEMODE bits don't control the module
>     functional clock in this case.  As I understand it, the only othe=
r
>     device that this problem could occur with is McBSP, due to
>     mcbsp_clks.

In that case this is slightly different because even the PRCM does not=20
control these external clocks. Whereas in the case of the dss_fck, if=20
the DPLL is not locked when you request it, it will be enabled=20
automatically. Assuming that auto mode are enabled.

> 3. The existing DSS2 driver clock design apparently works fine when
>     this change is implemented[1], so no driver changes will be neede=
d.

Yeah, but my point was that driver changes will be needed anyway, hence=
=20
my preference to hack the driver instead of hacking the clock data.

> 4. The proposed DSS driver patch to work around this uses a nasty hac=
k
>     that really should be NACK'ed[2].
>
> All this said, we may not be able to merge this change upstream, due =
to
> the recent unhappiness about the clock data changes.  If Linus reject=
s it,
> you'll need a "Plan B."

That's was my #2 concern as well.

See you soon at ELC.

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
