From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: Re: [PATCH] usb: musb: use put_sync_suspend instead of put_sync
Date: Fri, 12 Aug 2011 11:53:34 -0500
Message-ID: <CAEgRx2xA4Vp5K8KE=4TGmVeM3o3Fpr5CFKfeT45-g1Ec1OFUdQ@mail.gmail.com>
References: <1312494011-18745-1-git-send-email-m-sonasath@ti.com>
	<87fwlgww0y.fsf@ti.com>
	<20110812090106.GH19467@legolas.emea.dhcp.ti.com>
	<CAFm5wm3vsOye4uMA3f5f6u5emGb2fk4n3Yc+aRUGHJM8PJ+DnA@mail.gmail.com>
	<CAFm5wm2x_kpsgMJSo8J+Q0=CvfdpPvxzfdOPjbFzZ6AQq0QpZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:53569 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751651Ab1HLQxh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Aug 2011 12:53:37 -0400
In-Reply-To: <CAFm5wm2x_kpsgMJSo8J+Q0=CvfdpPvxzfdOPjbFzZ6AQq0QpZg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: balbi@ti.com, Kevin Hilman <khilman@ti.com>, linux-usb@vger.kernel.org, ccross@google.com, linux-omap@vger.kernel.org, gregkh@suse.de, Axel Haslam <axelhaslam@ti.com>

=46elipe,

On Fri, Aug 12, 2011 at 9:40 AM, Pandita, Vikram <vikram.pandita@ti.com=
> wrote:
>
> On Fri, Aug 12, 2011 at 6:55 AM, Pandita, Vikram <vikram.pandita@ti.c=
om> wrote:
> > On Fri, Aug 12, 2011 at 2:01 AM, Felipe Balbi <balbi@ti.com> wrote:
> >> Hi,
> >>
> >> (sorry for top-posting)
> >>
> >> Moiz, are we going to have another set of this ?
> >
> > The problem was with pm_runtime() functions getting called from ato=
mic
> > context and we did a work around by calling the runtime functions f=
rom
> > a work queue.
> > That seems to fix the issue. We will post that out as an alternativ=
e
> > to marking the irq_safe and thus causing the parent to never idle.
> >
>
> Here is the new post:
> https://patchwork.kernel.org/patch/1061282/

The patch was posted because of the runtime calls inside
musb_gadget_pullup() within interrupt-disable context. This was
actually fixed by syncing with a patch in open-source whering actually
these calls were done outside the irq_save() calls.

https://lkml.org/lkml/2011/7/20/357

Similar problem was also for the run-time pm calls done from the
musb_otg_notifications() which is in atomic context.  This has been
fixed by Vikrams patch.

>
> [.....]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--
Regards
Moiz Sonasath
Android Kernel Team
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
