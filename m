From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 10/11] omap4: thermal: add basic CPU thermal zone
Date: Mon, 28 May 2012 13:26:04 +0300
Message-ID: <CAGF5oy9Dwrasv3Hr_fkGg2N5uBei4tyRbZ+ADrEZ1FR-R_Q+0w@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-11-git-send-email-eduardo.valentin@ti.com>
	<CAMQu2gxNa4sPMKPLXGkKz_wkbQF8bTYipo4910p-ui9WNdeVFQ@mail.gmail.com>
	<20120528094850.GS18918@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:44936 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753465Ab2E1K0G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 May 2012 06:26:06 -0400
Received: by obqv19 with SMTP id v19so6516552obq.8
        for <linux-omap@vger.kernel.org>; Mon, 28 May 2012 03:26:04 -0700 (PDT)
In-Reply-To: <20120528094850.GS18918@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, tony@atomide.com, paul@pwsan.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org

Hello Santosh,

On Mon, May 28, 2012 at 12:48 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, May 28, 2012 at 03:03:26PM +0530, Shilimkar, Santosh wrote:
>> On Fri, May 25, 2012 at 1:56 PM, Eduardo Valentin
>> <eduardo.valentin@ti.com> wrote:
>> > This patch exposes OMAP4 thermal sensor as a thermal zone
>> > named "cpu". Only thermal creation is done here.
>> >
>> > TODO:
>> >
>> > =A0- Add cooling bindings
>> > =A0- Add extrapolation rules
>> >
>> > Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> > ---
>> > =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 | =A0 12 ++++++
>> > =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0| =A0 =A01 +
>> > =A0drivers/thermal/omap-bandgap.c =A0| =A0 =A01 +
>> > =A0drivers/thermal/omap-bandgap.h =A0| =A0 12 ++++++
>> > =A0drivers/thermal/omap4-thermal.c | =A0 72 ++++++++++++++++++++++=
+++++++++++++++++
>> > =A05 files changed, 98 insertions(+), 0 deletions(-)
>> > =A0create mode 100644 drivers/thermal/omap4-thermal.c
>> >
>> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> > index ffdd240..2e82797 100644
>> > --- a/drivers/thermal/Kconfig
>> > +++ b/drivers/thermal/Kconfig
>> > @@ -39,3 +39,15 @@ config OMAP_BANDGAP
>> > =A0 =A0 =A0 =A0 =A0This includes alert interrupts generation and a=
lso the TSHUT
>> > =A0 =A0 =A0 =A0 =A0support.
>> >
>> > +config OMAP4_THERMAL
>> > + =A0 =A0 =A0 bool "Texas Instruments OMAP4 thermal support"
>> > + =A0 =A0 =A0 depends on OMAP_BANDGAP
>> > + =A0 =A0 =A0 depends on ARCH_OMAP4
>> > + =A0 =A0 =A0 help
>> > + =A0 =A0 =A0 =A0 If you say yes here you get thermal support for =
the Texas Instruments
>> > + =A0 =A0 =A0 =A0 OMAP4 SoC family. The current chip supported are=
:
>> > + =A0 =A0 =A0 =A0 =A0- OMAP4460
>> > +
>> It's more of IP feature than OMAP specific, so something like
>>
>> config =A0HAVE_BANDGAP_THERMAL_SUPPORT
>>
>> and then let processor's which support enable it. That OMAP varients
>> in AMXX etc if needed can make use of it.
>
> Those are just an OMAP in disguise.
>
>> If you agree, then rest of the driver also can be cleaned to avoid
>> omap_* in file names and variables.
>>
>> Apart from this minor comment, rest of the patch looks fine to me.
>
> Then it will appear as a fully generic bandgap driver, which is not t=
he
> case. This is really a TI thing, right ?

I have to agree with Felipe here. I do see your point to have a name
which is applicable to AMxx, but having such generic naming is not
helping either :-( as this bandgap driver is not supposed to be
generic.

I though of "ti_bandgap.*", but still seams to be misleading..

I guess same applies to usb_phy and scm.

Again, if you have a name that fits better I won't hesitate to use it :=
-)

>
> --
> balbi



--=20

Eduardo Valentin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
