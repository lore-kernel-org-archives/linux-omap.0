From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH] cpufreq: OMAP: specify range for voltage scaling
Date: Fri, 2 Mar 2012 10:56:03 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A931788E1A@DBDE01.ent.ti.com>
References: <1330004964-22831-1-git-send-email-afzal@ti.com>
	<87fwdshyhk.fsf@ti.com> <87d38wf008.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38859 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757854Ab2CBK4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 05:56:07 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q22Au5wQ009895
	for <linux-omap@vger.kernel.org>; Fri, 2 Mar 2012 04:56:06 -0600
In-Reply-To: <87d38wf008.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "Kristo, Tero" <t-kristo@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>

Hi Kevin,

On Fri, Mar 02, 2012 at 03:37:51, Hilman, Kevin wrote:
> > Thanks, will queue this with the CPUfreq changes for MPU DVFS.
> 
> Actually, not quite yet...
> 
> After some testing with the SMPS regulators, this won't quite work with
> the current SMPS regulators.  Does this actually work with the
> regulators you're using?

Yes, it works on AM335X (doesn't have VC/VP) using TPS65910, it always
sets voltage to lowest step possible within minus OPP tolerance range.

Regards
Afzal
