From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Wed, 27 Jun 2012 20:23:03 +0530
Message-ID: <CAJe_ZhdOiv8NgMB37h5_X_reK+urxVykW1tHDF9S50VVUvX=4g@mail.gmail.com>
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
	<CAJe_Zhdz5mAZbyer8fL4YfvcQ8xMF31cPG2zr3AbBNWv8nctnw@mail.gmail.com>
	<1340784821.2649.17.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38896 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821Ab2F0OxG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 10:53:06 -0400
Received: by lbbgm6 with SMTP id gm6so1720342lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 07:53:03 -0700 (PDT)
In-Reply-To: <1340784821.2649.17.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 27 June 2012 13:43, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> I don't like it at all that omapdss disables and enables the panels in
> omapdss's suspend/resume hooks. But I'm not sure how this should work...
> Should panel drivers each have their own suspend/resume hooks, and
> handle it themselves? Or should the call to suspend/resume come from
> upper layers, like omapfb or omapdrm.
>
> I made a prototype patch a few weeks ago to move the suspend to omapfb,
> and it feels better than the current one, but I'm still not sure...
>
IIUC, I have similar opinion.
Each panel having its own suspend/resume sounds like inter-dependency trouble.
I too would prefer suspend/resume propagating from omap-fb/drm, which
imho fits better with the notion of a linux device(omapdss is only
backend). Though I don't have strong feelings about how core then take
various panels up/down optimally.

BR.
