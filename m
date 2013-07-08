From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: find real users and drivers of rpmsg
Date: Mon, 8 Jul 2013 16:01:33 +0200
Message-ID: <CAK=WgbYavJUg3WGU9gCF133kEsFF_1ViAT04SDE7Eps8B4h=tA@mail.gmail.com>
References: <CAGsJ_4z3-g_u5qHdoje=MASbRBoRMFjCU4jUfrrCc2836E_umQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:62629 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab3GHOBy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jul 2013 10:01:54 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so3689248lbv.41
        for <linux-omap@vger.kernel.org>; Mon, 08 Jul 2013 07:01:53 -0700 (PDT)
In-Reply-To: <CAGsJ_4z3-g_u5qHdoje=MASbRBoRMFjCU4jUfrrCc2836E_umQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>, Suman Anna <s-anna@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, pandaboard@googlegroups.com

Hi,

On Mon, Jul 8, 2013 at 10:31 AM, Barry Song <21cnbao@gmail.com> wrote:
> hi Ohad/all,
> i am trying to find some real users of rpmsg, here i only get
> samples/rpmsg/rpmsg_client_sample.c, does it mean other real drivers
> are out of mainline?

Yes

> where could i get them?

TI maintains them in internal trees, some of which might be public.
I'm looping in Suman from TI who might be able to refer you to some

> i am also trying to find source codes running in Cortex-M3 which use
> rpmsg and hope to find some Linux userspace codes which use rpmsg too.
> Thanks
> barry
