From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [RFC 10/12] omap: mcbsp: Move sidetone clock management to mach-omap2/mcbsp.c
Date: Fri, 1 Jul 2011 16:04:34 +0530
Message-ID: <BANLkTinzyxT-zzZV+tvQ-4v2ZNtnwhV2aA@mail.gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
	<1309510356-27147-11-git-send-email-jhnikula@gmail.com>
	<alpine.DEB.2.00.1107010317460.27025@utopia.booyaka.com>
	<4E0D92CC.5030006@ti.com>
	<alpine.DEB.2.00.1107010331230.27025@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:55307 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754902Ab1GAKeg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 06:34:36 -0400
Received: by mail-qw0-f50.google.com with SMTP id 5so1899456qwe.37
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 03:34:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1107010331230.27025@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>

On Fri, Jul 1, 2011 at 3:04 PM, Paul Walmsley <paul@pwsan.com> wrote:
> cc'ing Kishon
>
> On Fri, 1 Jul 2011, Cousson, Benoit wrote:
>
>> On 7/1/2011 11:23 AM, Paul Walmsley wrote:
>> > On Fri, 1 Jul 2011, Jarkko Nikula wrote:
>> >
>> > > Active sidetone requires that McBSP interface clock doesn't idle=
 and there
>> > > is no mechanism in hwmod to turn autoidling on/off in runtime. M=
cBSP2 and
>> > > 3
>> > > in OMAP34xx share their interface clock with McBSP sidetone modu=
le and
>> > > that interface clock must be active when the sidetone is operati=
ng.
>> > >
>> > > Sidetone has its own autoidle bit which should keep the interfac=
e clock
>> > > active but it is broken. Putting the McBSP core to no-idle mode =
when the
>> > > sidetone is active is no good either since it results to higher =
power
>> > > consumption when using the threshold based DMA transfers.
>> >
>> > In the hwmod code/data, we've got the OCPIF_SWSUP_IDLE flag that c=
an be
>> > set on a struct omap_hwmod_ocp_if. =A0I think this is probably wha=
t's needed
>> > here. =A0The only problem is that we haven't linked that to the cl=
ock code
>> > to deny idle on the interface clock yet (see omap_hwmod.c:_setup()=
).
>> > Adding that code in, plus adding that OCPIF_SWSUP_IDLE flag to the
>> > McBSP2/3 data, seems like the right approach here.
>> >
>> > I guess we also will need some basic usecounting for denying idle =
in the
>> > clock code.
>> >
>> > Otherwise these direct register manipulations of clock registers, =
outside
>> > the clock code, could turn into a mess :-(
>>
>> AFAIR Kishon did submit some patches to expose this feature to the d=
river
>> through omap_device API. The point is that other broken IP like SDMA=
 of USB
>> will require such feature.
>>
>> Didn't we pull them?

I'll repost by early next week.

>
> You sent him some comments on March 1 but it looks like the series ne=
ver
> got updated and reposted, at least not that I can find in my mail
> archive. =A0Kishon?
>
> Anyway, those patches won't help in this case if the sidetone AUTOIDL=
E bit
> is broken - looks like the interface clock autoidle bit is what needs=
 to
> change.
>
>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
