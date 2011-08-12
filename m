From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: musb: fix pm_runtime calls while atomic
Date: Fri, 12 Aug 2011 13:04:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108121302070.15086-100000@netrider.rowland.org>
References: <CAFm5wm1W03BbjNV4uZLGNjFZLKvfiLLQyP3M01r83EQ47724wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:59900 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751189Ab1HLREg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 13:04:36 -0400
In-Reply-To: <CAFm5wm1W03BbjNV4uZLGNjFZLKvfiLLQyP3M01r83EQ47724wQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: linux-usb@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, axelhaslam@ti.com, ccross@google.com, Moiz Sonasath <m-sonasath@ti.com>

On Fri, 12 Aug 2011, Pandita, Vikram wrote:

> On Fri, Aug 12, 2011 at 8:50 AM, Alan Stern <stern@rowland.harvard.ed=
u> wrote:
> > On Fri, 12 Aug 2011, Vikram Pandita wrote:
> >
> >> From: Vikram Pandita <vikram.pandita@ti.com>
> >>
> >> musb pm_runtime_get_sync call happens in intrrupt context on cable=
 attach case
> >> That can result in re-enabling the interrupts and cause side affec=
ts.
> >>
> >> So move the code to a work queue.
> >
> > Instead of creating your own, new work queue, just use the pre-exis=
ting
> > PM work queue. =A0In other words, replace pm_runtime_get_sync() wit=
h
> > pm_runtime_get().
>=20
> In this case it may not work, because immediately after a
> pm_runtime_get_sync(),
> we are going to access MUSB registers and xxx_sync()  call ensures we
> will not abort.

I don't understand.  Why not just access those registers from within=20
the runtime_resume callback?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
