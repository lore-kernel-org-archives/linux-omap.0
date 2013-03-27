From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH V2 0/8] ARM: OMAP3+: support cpufreq-cpu0 for device tree boot
Date: Wed, 27 Mar 2013 13:37:58 -0700
Message-ID: <87a9po60k9.fsf@linaro.org>
References: <1363715590-5131-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:52242 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab3C0UiD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 16:38:03 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so2323283pab.32
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 13:38:02 -0700 (PDT)
In-Reply-To: <1363715590-5131-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Tue, 19 Mar 2013 12:53:02 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Hi Nishanth,

Nishanth Menon <nm@ti.com> writes:

> Hi,
> The following version 2 of the series arose from trying to use BeagleBoard-XM
> (OMAP3 variant) for doing CPU DVFS using cpufreq-cpu0. This series enables the
> generic cpufreq-cpu0 driver to be used in device tree enabled boot while
> maintaining support of the legacy omap-cpufreq driver when used in non device
> tree enabled boot.

Benoit should have a look and ack the DT data changes, but the general
direction is right IMO.  

I just had one comment on the last patch about how the omap-cpufreq
driver should be handled for the non-DT case.

Other than that, this is a great step in the right direction.  Thanks!

Kevin
