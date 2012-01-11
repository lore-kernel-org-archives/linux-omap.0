From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 1/2] arm:omap:am33xx: Add voltage domain data
Date: Wed, 11 Jan 2012 16:26:39 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317A10A8@DBDE01.ent.ti.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
	<1324803628-16790-2-git-send-email-hvaibhav@ti.com> <87ipkjpg0o.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36996 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab2AKQ0s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 11:26:48 -0500
In-Reply-To: <87ipkjpg0o.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

On Tue, Jan 10, 2012 at 23:59:59, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > Currently dummy voltage domain data is being created
> > in order to succeed boot process, nothing has been done
> > w.r.t actual hardware (voltage control).
> >
> > Also, hook up the AM33XX voltage domain to OMAP framework.
> >
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Data looks OK, but why the dummy voltage domains?   Does this device not
> support voltage scaling? 
> 
It does support voltage scaling.

Kevin,
This is part of initial baseport patches and complete PM support 
along with voltage scaling will follow slowly as-n-when it is ready for submission.
We still haven't got full power management working internally which we can submit immediately.


> Also, I think it was my idea in an earlier review to add the 
> '.scalable = false', but it's not really necessary since the default is
> false.  Sorry 'bout that.
> 

Sorry it's my miss as well, I should have conformed it before submission.
I will correct it in next version.

Thanks,
Vaibhav

> Kevin
> 

