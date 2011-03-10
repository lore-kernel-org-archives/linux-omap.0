From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] perf: add OMAP support for the new power events
Date: Wed, 9 Mar 2011 18:04:10 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103091759300.15132@utopia.booyaka.com>
References: <1298052645-4164-1-git-send-email-j-pihet@ti.com> <1299147943-2929-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39935 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab1CJBEM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 20:04:12 -0500
In-Reply-To: <1299147943-2929-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Jean Pihet <j-pihet@ti.com>

On Thu, 3 Mar 2011, Jean Pihet wrote:

> The patch adds the new power management trace points for
> the OMAP architecture.
> 
> The trace points are for:
> - default idle handler. Since the cpuidle framework is
>   instrumented in the generic way there is no need to
>   add trace points in the OMAP specific cpuidle handler;
> - cpufreq (DVFS),
> - SoC clocks changes (enable, disable, set_rate),
> - power domain states: the desired target state and -if different-
>   the actually hit state.
> 
> Because of the generic nature of the changes, OMAP3 and OMAP4 are supported.
> 
> Tested on OMAP3 with suspend/resume, cpuidle, basic DVFS.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

In terms of tracing powerdomain state changes, since OMAP powerdomains can 
potentially transition without the MPU knowing about it, some powerdomain 
transitions will be missed by these.  (The software counters miss them 
too.)  The only way to be certain about these is to watch the debug 
observability lines.  Still, it is the rare board that brings out debobs 
lines.  So this seems reasonable, as long as people don't expect 100% 
coverage.

For the clock and powerdomain changes,

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
