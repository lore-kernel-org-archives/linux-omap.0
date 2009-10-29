From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] omap-pm: Fixes behaviour of some shared resource
	framework functions
Date: Thu, 29 Oct 2009 11:16:32 +0000
Message-ID: <20091029111632.GC15559@sirena.org.uk>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DDCE4650@dbde02.ent.ti.com> <87iqejktan.fsf@deeprootsystems.com> <alpine.DEB.2.00.0910281236270.19865@utopia.booyaka.com> <003201ca581b$256863c0$544ff780@am.dhcp.ti.com> <87hbtj3zpc.fsf@deeprootsystems.com> <B85A65D85D7EB246BE421B3FB0FBB59301DE16EE0D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:53341 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbZJ2LQa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 07:16:30 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE16EE0D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, 'Paul Walmsley' <paul@pwsan.com>, "'linux-omap@vger.kernel.org'" <linux-omap@vger.kernel.org>, "Titiano, Patrick" <p-titiano@ti.com>

On Thu, Oct 29, 2009 at 01:09:25PM +0530, Dasgupta, Romit wrote:

[Reflowed into 80 columns - you might want to look at your MUA setup.]

>      The sampling intervals for the cpufreq governors are quite large
>      and thus the latency for the frequency change to occur is large.
>      This was seen in Android UI responsiveness. The initial response
>      of the UI seems to be quite sluggish until after a while when the
>      cpufreq governors would catch up to the required MIPS.  I know
>      that Patrick (Cc'd) did some experiments with conservative
>      governor but my understanding is that it still has this basic
>      problem.

This appears to be a general problem with cpufreq on faster embedded
systems, not just OMAP.  I suspect that what we really need here is
either tuning of the existing governors or new governors better adapted
to embedded systems.  

I seem to remember from the last time I looked at this that I had a
suspicion that the relatively high transition latencies embedded systems
often have due to I2C PMICs really weren't helping here since the
governors all tend to base their polling intervals on a multiple of
those, resulting in poll times of the order of a second which are far
too long for raising the frequency.  Something like capping the latency
used when raising the frequency or scaling the poll time based on the
distance from the maximum frequency looked like a useful approach -
certainly, claiming a very low transition latency avoids the UI-visible
issue.
