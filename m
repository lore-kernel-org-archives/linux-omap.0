From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH 00/26] PM: Create the AVS class of drivers
Date: Tue, 22 Nov 2011 21:01:23 +0100
Message-ID: <CAORVsuUi-bxLrrv0Tq30GU1f28Y_efQ0raTNdXc-sPK3NaYAWw@mail.gmail.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
	<20111122164302.GI6624@sirena.org.uk>
	<4ECBDE77.6000703@ti.com>
	<20111122174739.GF30583@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48387 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706Ab1KVUBY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 15:01:24 -0500
Received: by vcbfk1 with SMTP id fk1so642353vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 12:01:23 -0800 (PST)
In-Reply-To: <20111122174739.GF30583@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>

Hi Mark, Benoit,

On Tue, Nov 22, 2011 at 6:47 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Nov 22, 2011 at 06:40:07PM +0100, Cousson, Benoit wrote:
>> On 11/22/2011 5:43 PM, Mark Brown wrote:
>
>> >This sounds a lot like what devfreq (which was recently merged) is
>> >supposed to do. =A0Have you looked at the overlap there?
>
>> devfreq is a fmwk for DVFS governors at device level, whereas AVS
>> stands for Adaptive Voltage Scaling. This technique does not involve
>> any frequency change, and does a fine voltage adjustment to adapt to
>> silicon process / aging / thermal variation based on a HW closed
>> loop.
>
> Ah, I see. =A0It wasn't clear from the changelog that this was about =
fine
> adjustmnets rather than operating point selection.
Ok I will update the commit description as well as the Kconfig descript=
ion.

>
>> Both DVFS and AVS can be used independently.
>
>> I think that AVS does belong to the voltage control infrastructure
>> more than the DVFS/freq one.
>
> This does sound like the two may need to understand each other at som=
e
> point - if you want to do AVS on things that can vary their operating
> point to fine tune the voltages that get set then you'll need to be a=
ble
> to interface the two.
Sure it is needed to notify the AVS code when the OPP changes, in
order to update the adjustment parameters of the SmartReflex IP.
I need to update my ToDo list with this point.

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
