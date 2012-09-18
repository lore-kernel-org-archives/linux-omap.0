From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP4: crypto acceleration (AES, SHA, ...)
Date: Tue, 18 Sep 2012 11:48:52 +0530
Message-ID: <CAMQu2gxMcobG0Eo145kvEbtjW8OUNxQDuc4YM_ud2rotc_26jw@mail.gmail.com>
References: <20120913215707.GA22825@earth.universe> <20120917203821.GX4521@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:44686 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753160Ab2IRGTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Sep 2012 02:19:14 -0400
Received: by vbbff1 with SMTP id ff1so3914415vbb.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Sep 2012 23:19:13 -0700 (PDT)
In-Reply-To: <20120917203821.GX4521@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@debian.org>, linux-omap@vger.kernel.org

On Tue, Sep 18, 2012 at 2:08 AM, Tony Lindgren <tony@atomide.com> wrote:
>
> * Sebastian Reichel <sre@debian.org> [120913 14:58]:
> > Hi,
> >
> > Are there plans to add crypto acceleration support to OMAP4? Has
> > this hardware component been removed from OMAP4? I tried to load the
> > code written for OMAP3 on my Pandaboard, but it just outputs
> > "platform not supported":
> >
> > [    0.370513] omap_init_sham: platform not supported
> > [    0.375488] omap_init_aes: platform not supported
>
> I recall hearing at some point that these are now available
> only in the secure mode? Maybe somebody from TI could
> check this?
>
Thats right. I will cross verify but at least for sure I know
that OMAP4 onwards, these blocks are not available for
non-secure software.

Regards
Santosh
