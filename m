From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH] input: export gpio-keys driven switch status over gpiolib sysfs
Date: Fri, 12 Jun 2009 13:19:09 +0200
Message-ID: <200906121319.11005.jkrzyszt@tis.icnet.pl>
References: <200906050039.40050.jkrzyszt@tis.icnet.pl> <20090611061855.GA8035@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:59212 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755862AbZFLLTr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 07:19:47 -0400
In-Reply-To: <20090611061855.GA8035@dtor-d630.eng.vmware.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org

Hi Dmitry,

Thursday 11 June 2009 08:18:56 Dmitry Torokhov napisa=C5=82(a):
> Hi Janusz,
>
> On Fri, Jun 05, 2009 at 12:39:39AM +0200, Janusz Krzysztofik wrote:
> > This patch adds support for exporting status of GPIO switches, conf=
igured
> > as gpio-keys buttons that generate events of type EV_SW, over stand=
ard
> > gpiolib sysfs interface. That way, switch state can be easily acces=
sed
> > from userspace via a modern sysfs API in addition to traditional io=
clt
> > API, without the need for adding a new, usualy controversial entry =
to
> > sysfs interface.
>
> But this would make your application only work with devices using
> gpio-keys driver and nothing else. I don't think it's a good idea.

No, my patch wouldn't make that, neither to mine nor any other applicat=
ion.=20
It's an application developer, not my patch, who can make the applicati=
on=20
limited, and I think he should be free to do this at his will. My patch=
 would=20
only provide him with extra functionality, exposed by one of device dri=
vers,=20
designed for a specific group of devices, for his free use.

I think that providing extra functionality for free use, without breaki=
ng=20
anything, neither in kernel nor user space, not adding any overhead, mo=
reover,=20
using an already existing kernel API designed for that specific purpose=
, is a=20
good idea.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
