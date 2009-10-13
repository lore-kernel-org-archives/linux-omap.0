From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3] OMAP3: PM: Make PRM setup times and CPUidle latencies/threshold board specific
Date: Tue, 13 Oct 2009 12:31:33 -0700
Message-ID: <87bpkbjdka.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D1009@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:64745 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981AbZJMTcs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 15:32:48 -0400
Received: by pxi10 with SMTP id 10so175073pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 12:31:36 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D1009@dbde02.ent.ti.com> (Rajendra Nayak's message of "Mon\, 12 Oct 2009 19\:11\:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> The setup times to be programmed in the PRM module on OMAP (for
> clksetup, voltsetup etc) are board specific. They depend heavily on
> the PMIC used and even on different boards with the same PMIC, they
> vary based on the sleep/wake sequence used, system clock speed et
> al.
>
> The CPUidle latencies and hence thresholds (derived from latencies
> and Power consumption numbers) and very much dependent on these
> setup values and hence also need to be board specific.
>
> This patchset makes it possible for the PRM setup times and the
> CPUidle latencies/threshold numbers to be configured from board
> files, and some default values are used if nothing gets passed from
> board files.
>
> Only the 3430SDP board file is currently been modifed to pass these
> values and the rest of the 3430 based board's still pass NULL and
> hence use the default values defined.

Hi Rajendra,

Thanks for making these changes.  I'm very much for the approach
you've taken in these patches to make these more configurable.

One other comment that would require one more spin:

Since we may be moving the OPP tables from board code to SoC common code,
let's separate the rate tables from the VC and cpudle parameters.

How about an optional omap3_pm_init_vc() for the setup times. and
omap3_pm_init_cpuidle() for the CPUidle values.  This way only the
board files that don't want the defaults have to call them.

The other benefit of having optional calls is that we don't have to
keep touching every single board file to make these kinds of changes.

Thanks,

Kevin


