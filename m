From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
Date: Mon, 30 Apr 2012 09:55:26 +0530
Message-ID: <CAJ6a13ZFj47nps1teNHyE3FyzZOUBx9HDOL-3_CNC+_vdbs6ag@mail.gmail.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<20120426191159.GA9415@sirena.org.uk>
	<CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
	<20120427175657.GP18260@opensource.wolfsonmicro.com>
	<87397o3n4y.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:52051 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751205Ab2D3EZ1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 00:25:27 -0400
Received: by obcni5 with SMTP id ni5so4574854obc.13
        for <linux-omap@vger.kernel.org>; Sun, 29 Apr 2012 21:25:26 -0700 (PDT)
In-Reply-To: <87397o3n4y.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, j-pihet@ti.com

On Sat, Apr 28, 2012 at 2:31 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Mark,
>
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
>
>> On Fri, Apr 27, 2012 at 11:09:10AM +0530, J, KEERTHY wrote:
>>
>>> Devfreq and cpufreq are related to dynamic frequency/voltage switch=
ing between
>>> pre defined Operating Performance Points or the OPPs. Every OPP bei=
ng
>>> a voltage/frequency pair. Smartreflex is a different
>>> power management technique.
>>
>> But presumably these things should integrate somehow - for example,
>> should devfreq and cpufreq be providing inputs into what AVS is doin=
g,
>> and if so how?
>
> The way it is currently designed, cpufreq/devfreq/regulator layers do=
n't
> need to know about AVS.
>
> The higher-level layers only know about the "nominal" voltage. =A0AVS
> hardware does automatic, adaptive, micro-adjustments around that nomi=
nal
> voltage, and these micro-adjustments are managed by the AVS hardware
> sending commands to the PMIC. =A0(specifically, on OMAP, the AVS sens=
ors
> provide inputs to the voltage processor (VP) which provide inputs to =
the
> voltage controller (VC) which sends commands to the PMIC[1].)
>
> The driver proposed here is primarily for initializing the various
> parameters/sensitivity/etc. of the AVS hardware, but the actual volta=
ge
> adjustments are done in hardware by VC/VP.
>
> The only thing the higher-level layers might potentially need to do t=
o
> enable/disable AVS around transitions (e.g. when changing OPP, AVS is
> disabled before changing OPP and only re-enabled when the new nominal
> voltage has been acheived.)
>
> On OMAP, we handle this inside the OMAP-specific voltage layer which =
is
> called by the regulator framework, so even the regulators do not need
> any knowledge of AVS.
>
> Kevin
>
> [1] Figure 3-76 in OMAP4430 ES2.1 Public TRM vAD provides a
> =A0 =A0detailed diagram:
> =A0 =A0http://www.ti.com/pdfs/wtbu/OMAP4430_ES2.x_PUBLIC_TRM_vAD.zip

Thanks for the detailed answer Kevin.

--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
