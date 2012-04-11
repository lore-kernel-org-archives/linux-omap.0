From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 05/12] arm: omap3: am35x: Add PWROFF feature
Date: Wed, 11 Apr 2012 15:46:20 -0700
Message-ID: <87iph5q43n.fsf@ti.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
	<1334171147-7517-6-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:49053 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756374Ab2DKWqL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 18:46:11 -0400
Received: by pbcuo1 with SMTP id uo1so1990774pbc.26
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 15:46:09 -0700 (PDT)
In-Reply-To: <1334171147-7517-6-git-send-email-mgreer@animalcreek.com> (Mark
	A. Greer's message of "Wed, 11 Apr 2012 12:05:40 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

Hi Mark,

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> Typical OMAP3 SoCs have four power domain states: ON,
> INACTIVE, RETENTION, and OFF.  The am35x family of SoCs
> has only two states: ON and INACTIVE.  To distinguish which
> set of states the current device has, add the 'OMAP3_HAS_PWROFF'
> feature.  When that feature/bit is set, the device supports the
> RETENTION and OFF states; otherwise, it doesn't.
>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Paul has mentioned this already, but the same applies here: We shouldn't
be using SoC-global feature flag for this.   We already have per-pwrdm
flags that indicate what states a given powerdomain suports (see .pwrsts
field.)

Wherever we have blind writes to next powerstates that assume support
for RET/OFF is present, those should probably use a helper function from
the powerdomain code that checks if that state is even supported.

Jean's work on functional powerstates will probably help here if you
really need to support INACTIVE.  However, Paul may be right in that you
might just start with supporing ON only, and validate that module-level
wakups acutally work.

Kevin
