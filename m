From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 0/6 V3] Cleanups for cpufreq
Date: Thu, 26 May 2011 11:36:18 -0700
Message-ID: <BANLkTimHYCBLBXF8iTMKi=+EvJra3ecmBA@mail.gmail.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <87ipsxcoz0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:39776 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932491Ab1EZSis convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 14:38:48 -0400
Received: by mail-ww0-f46.google.com with SMTP id 28so1055771wwb.3
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 11:38:43 -0700 (PDT)
In-Reply-To: <87ipsxcoz0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, May 26, 2011 at 11:10, Kevin Hilman <khilman@ti.com> wrote:
> So here's a dumb question, being rather ignorant of CPUfreq on SMP.
>
> Should we be running a CPUfreq instance on both CPUs when they cannot=
 be
> scaled independently?
>
> What is being scaled here is actually the cluster (the MPU SS via
> dpll_mpu_ck), not an individual CPU. =A0So to me, it only makes sense=
 to
> have a an instance of the driver per scalable device, which in this c=
ase
> is a single MPU SS.
>
> What am I missing?

my understanding from the code is that we have one instance of cpufreq
controllable from either cpu0 or 1.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
