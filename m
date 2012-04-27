From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
Date: Fri, 27 Apr 2012 14:01:17 -0700
Message-ID: <87397o3n4y.fsf@ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<20120426191159.GA9415@sirena.org.uk>
	<CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
	<20120427175657.GP18260@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:48741 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752540Ab2D0VBS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 17:01:18 -0400
Received: by dacx6 with SMTP id x6so1202153dac.32
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 14:01:15 -0700 (PDT)
In-Reply-To: <20120427175657.GP18260@opensource.wolfsonmicro.com> (Mark
	Brown's message of "Fri, 27 Apr 2012 18:56:58 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "J, KEERTHY" <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, j-pihet@ti.com

Hi Mark,

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Fri, Apr 27, 2012 at 11:09:10AM +0530, J, KEERTHY wrote:
>
>> Devfreq and cpufreq are related to dynamic frequency/voltage switching between
>> pre defined Operating Performance Points or the OPPs. Every OPP being
>> a voltage/frequency pair. Smartreflex is a different
>> power management technique.
>
> But presumably these things should integrate somehow - for example,
> should devfreq and cpufreq be providing inputs into what AVS is doing,
> and if so how?

The way it is currently designed, cpufreq/devfreq/regulator layers don't
need to know about AVS.

The higher-level layers only know about the "nominal" voltage.  AVS
hardware does automatic, adaptive, micro-adjustments around that nominal
voltage, and these micro-adjustments are managed by the AVS hardware
sending commands to the PMIC.  (specifically, on OMAP, the AVS sensors
provide inputs to the voltage processor (VP) which provide inputs to the
voltage controller (VC) which sends commands to the PMIC[1].)

The driver proposed here is primarily for initializing the various
parameters/sensitivity/etc. of the AVS hardware, but the actual voltage
adjustments are done in hardware by VC/VP.

The only thing the higher-level layers might potentially need to do to
enable/disable AVS around transitions (e.g. when changing OPP, AVS is
disabled before changing OPP and only re-enabled when the new nominal
voltage has been acheived.)

On OMAP, we handle this inside the OMAP-specific voltage layer which is
called by the regulator framework, so even the regulators do not need
any knowledge of AVS.

Kevin

[1] Figure 3-76 in OMAP4430 ES2.1 Public TRM vAD provides a 
    detailed diagram:
    http://www.ti.com/pdfs/wtbu/OMAP4430_ES2.x_PUBLIC_TRM_vAD.zip
