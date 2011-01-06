From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v8 0/11] dmtimer adaptation to platform_driver
Date: Thu, 6 Jan 2011 19:04:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F5FA@dbde02.ent.ti.com>
References: <1294228127-11549-1-git-send-email-tarun.kanti@ti.com>
 <87bp3uu9lx.fsf@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F357@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45582 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab1AFNfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 08:35:03 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p06DYxR1025816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 6 Jan 2011 07:35:02 -0600
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F357@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,
[...]
> >
> > Also, testing with PM on 34xx/n900, I noticed that this series prevents
> > PER and CORE from hitting retention during suspend.  I haven't debugged
> > why yet.
> I have not done power testing. I will try this out right away and confirm.
>
Here is a brief update on pm test.

(1) Without dmtimer patch series:
[  305.641204] Powerdomain (core_pwrdm) didn't enter target state 1
[  305.647491] Could not enter target state in pm_suspend

(2) With dmtimer patch series:
[   25.291503] Powerdomain (core_pwrdm) didn't enter target state 1
[   25.297790] Powerdomain (per_pwrdm) didn't enter target state 1
[   25.303985] Could not enter target state in pm_suspend

I will debug further.

--
Tarun
