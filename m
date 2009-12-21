From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp
Date: Mon, 21 Dec 2009 12:28:03 +0530
Message-ID: <4B2F1C7B.5070600@ti.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>	<1258004721-7315-2-git-send-email-nm@ti.com>	<1258004721-7315-3-git-send-email-nm@ti.com>	<1258004721-7315-4-git-send-email-nm@ti.com>	<1258004721-7315-5-git-send-email-nm@ti.com>	<1258004721-7315-6-git-send-email-nm@ti.com> <87eimrx4em.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36322 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbZLUG6P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Dec 2009 01:58:15 -0500
In-Reply-To: <87eimrx4em.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> 
> SmartReflex is not quite working with this version which is in
> pm-wip-opp.  My (untested) theory below...
Mostly you have not included SR in the build. OTOH I raised this issue earlier
that the omap cpufreq driver is not honoring CPUFREQ_RELATION_L and
CPUFREQ_RELATION_H flags. I do not understand why do we need to do a
opp_find_freq_ceil here? The validate function of the frequency resources would
have already identified if we can get this exact frequency or not.
