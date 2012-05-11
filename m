From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/4] ARM: OMAP2+: Introduce CONFIG_SOC_HAS_OMAP_DPLL
 macro
Date: Fri, 11 May 2012 06:22:20 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA220F3@DBDE01.ent.ti.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
	<1336669615-16454-2-git-send-email-r.sricharan@ti.com>
	<79CD15C6BA57404B839C016229A409A83EA217D2@DBDE01.ent.ti.com>
 <CAJ7qFSf9=h-hjSwrcd+n=zK4HyB+=DXGrqsgsMvaL_f1xyQQog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57134 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757962Ab2EKGXd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 02:23:33 -0400
In-Reply-To: <CAJ7qFSf9=h-hjSwrcd+n=zK4HyB+=DXGrqsgsMvaL_f1xyQQog@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Sricharan" <r.sricharan@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pswan.com" <paul@pswan.com>

On Fri, May 11, 2012 at 11:46:32, R, Sricharan wrote:
> Vaibhav,
> [snip]
> > Waiting for Paul to conform here.
> >
>  Thanks for pointing that out. Will check on this and Paul's PRCM series
>  cleanup series then.
> 

Sricharan,

Yesterday, Paul confirmed that, removing ifdef is the way to go. So
just few mins back I had submitted patch for the same.

http://permalink.gmane.org/gmane.linux.ports.arm.omap/76972


Thanks,
Vaibhav

