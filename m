From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: Monitoring uevents at the user space
Date: Wed, 20 Apr 2011 11:02:52 -0500
Message-ID: <BANLkTineAU1zFyP+v=X4QXKaJj-Ep0+OaA@mail.gmail.com>
References: <BANLkTi=eYr8u_-BhEJibj6dek0Luo=DnvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:47033 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754456Ab1DTQDT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 12:03:19 -0400
Received: by mail-wy0-f181.google.com with SMTP id 11so984579wyi.40
        for <linux-omap@vger.kernel.org>; Wed, 20 Apr 2011 09:03:12 -0700 (PDT)
In-Reply-To: <BANLkTi=eYr8u_-BhEJibj6dek0Luo=DnvA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, Apr 20, 2011 at 07:04, J, KEERTHY <j-keerthy@ti.com> wrote:
> Hello All,
>
> I am writing a driver for OMAP4460 thermal sensor. I have a requirement
> to send events to the user space from the driver on some condition.
>
> I am using kobject_uevent(&temp_sensor->dev->kobj, KOBJ_ADD) as
> part of initialization.
>
> On the occurrence of the event i am notifying via
> kobject_uevent(&temp_sensor->dev->kobj, KOBJ_CHANGE).
>
> I am using busybox file system. What is the recommended way
> to actually verify whether the uevent has been propagated to the
> user space or not from the driver?

does this help?
http://wildanm.wordpress.com/2007/08/21/mdev-mini-udev-in-busybox/

Regards,
Nishanth Menon
