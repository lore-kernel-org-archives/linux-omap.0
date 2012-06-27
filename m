From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Wed, 27 Jun 2012 13:11:52 +0530
Message-ID: <CAJe_Zhdz5mAZbyer8fL4YfvcQ8xMF31cPG2zr3AbBNWv8nctnw@mail.gmail.com>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
	<CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	<1340616643.3395.19.camel@deskari>
	<CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	<1340628094.3395.63.camel@deskari>
	<CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
	<1340632161.3395.100.camel@deskari>
	<CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
	<1340695166.2093.22.camel@lappyti>
	<CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
	<1340701660.24530.17.camel@deskari>
	<CAJe_Zhd-LA67yO-H_7pacB_T8_z6=Zf47QuoHSJcsXDZ9S+byw@mail.gmail.com>
	<1340712213.24530.21.camel@deskari>
	<CAJe_ZhcxVAUuuMDZ8p1LVae4N2aZb_vFs_nRLfb7atJ2j6j=Sg@mail.gmail.com>
	<1340723296.24530.68.camel@deskari>
	<CAJe_ZheMN_sqaANSMepmhDDp2a2sQAVPYD1-owBWpwwbxqAtHQ@mail.gmail.com>
	<1340723514.24530.70.camel@deskari>
	<CAJe_ZheXSquxOtOD9iPyQjZ-jxWKzVGZHYkjM=wC37qgMZeJug@mail.gmail.com>
	<1340736243.24530.98.camel@deskari>
	<CAJe_ZheovnRsJ6opMPkMxwjLSv-OKBPCHu5rsAX_KNz1mb64ZQ@mail.gmail.com>
	<1340776683.1972.41.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42834 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756270Ab2F0Hlx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 03:41:53 -0400
Received: by bkcji2 with SMTP id ji2so650599bkc.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 00:41:52 -0700 (PDT)
In-Reply-To: <1340776683.1972.41.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 27 June 2012 11:28, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> It doesn't matter how omapdss is organized, -EACCES _is_ an error. It
> tells us that something unexpected happened, and we should react to it
> somehow.
>
  $ git show 5025ce070
Exactly how omapdss is organised is the reason -EBUSY isn't an error there :)
Otherwise, omapdss should panic that somehow 'imbalance' has been
introduced in rpm.


>
> Sure, in the current omapdss neither is a breaking problem, because 1)
> the matching dispc_runtime_put() is called also with runtime PM
> disabled, and thus we don't decrease the use count, and 2) the HW
> happens to be already enabled. But that's just by "luck", and tomorrow
> omapdss could be different.
>
It's no 'luck', but it's because today omapdss takes proper care of PM
enable/disable and get/put.
Rather, if tomorrow that stops working, it would hint that we managed
to screw up the balance.
Because if omapdss suspended and disabled PM on DISPC, and still HDMI
attempted to access dss regs, that clearly means HDMI hasn't been duly
made aware of the DISPC status.

Just as preemption and suspend/resume don't introduce any race in
locking, RPM won't introduce new imbalance in get/put of omapdss.

I am afraid, we won't reach any eureka moment on this, so I would
leave us to our conditions. This patch and discussion made me look
deep into rpm, I thank you for that and for your patience.

Cheers!
