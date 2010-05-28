From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: omap3 pm: dependency between opp layer and cpufreq
Date: Fri, 28 May 2010 02:39:50 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0132DE0A84@dlee02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDD30@dbde02.ent.ti.com>,<4BFE9D7E.8020602@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E5828FC1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33735 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab0E1Hj4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 03:39:56 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E5828FC1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

> -----Original Message-----
> From: Premi, Sanjeev
> Sent: Thursday, May 27, 2010 10:30 PM

[...]

> >
> > 3) Was there any specific need to tie the functions "opp_get_voltage"
> and others to cpufreq only?
> 
> yes, because without cpufreq there is no transitions in the system :)
> 
> [sp] I does - via bootarg - mpurate!
> 
> When kernel boots, volatge must be set properly.
> We cannot rely on u-boot to be settiing everything correctly. e.g. 720MHz
> on OMAP3530 would fail at nominal 1.2V set by u-boot.

I agree, but mpurate does not seem to use the cpufreq interfaces - so is 
kinda a question how it interfaces back -> but note, mpurate tells us what
the start freq is for the system - it still does no *dynamic* transitions - 
just a static startup frequency. But I agree, it assumes that if you provide 
mpurate, the system supposedly is operating at that frequency, aka all
setups have been done for that operational frequency(including voltage)


Regards,
Nishanth Menon
