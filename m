From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Fri, 2 Jul 2010 15:08:02 +0300
Message-ID: <20100702150802.b5347000.Hiroshi.DOYU@nokia.com>
References: <AANLkTikNX09s4xflcOax3Ry3o5XgJZF0JbbZXSGeKryR@mail.gmail.com>
	<20100615.110449.27786947.Hiroshi.DOYU@nokia.com>
	<AANLkTimC8xdQeuRRA5x7GomNfJjC5H_5YfqQBmSBAa50@mail.gmail.com>
	<20100616.085056.189711722.Hiroshi.DOYU@nokia.com>
	<AANLkTinA-iPGHPSbbw5XZdMeDW0T4ltbhQ-LANDry9h9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47248 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595Ab0GBMIS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 08:08:18 -0400
In-Reply-To: <AANLkTinA-iPGHPSbbw5XZdMeDW0T4ltbhQ-LANDry9h9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ohad Ben-Cohen <ohad@wizery.com>
Cc: "fernando.lugo@ti.com" <fernando.lugo@ti.com>, "deepak.chitriki@ti.com" <deepak.chitriki@ti.com>, "omar.ramirez@ti.com" <omar.ramirez@ti.com>, "h-kanigeri2@ti.com" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rene.sapiens@ti.com" <rene.sapiens@ti.com>

On Wed, 23 Jun 2010 02:29:00 +0200
ext Ohad Ben-Cohen <ohad@wizery.com> wrote:

> On Wed, Jun 16, 2010 at 8:50 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> > From: ext Ohad Ben-Cohen <ohad@wizery.com>
> >> Thanks, I'll prepare them and resubmit
> >
> > You can use the following branch which has accumulateed unmerged
> > mailbox patches.
> >
> > git://gitorious.org/~doyu/lk/mainline.git v2.6.35-rc3-mailbox
> 
> 
> Done.

Thansk.
[PATCH 1-3/4] are queued on the above branch and will be pulled soon.

The following should be taken care of dspbridge:

"[PATCH 4/4] dspbridge: use mailbox API to set rx callback"
