From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Wed, 21 Nov 2012 16:08:06 -0800
Message-ID: <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55681 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432Ab2KVTNr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Nov 2012 14:13:47 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so8354787obb.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Nov 2012 11:13:47 -0800 (PST)
In-Reply-To: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>

On Thu, Oct 11, 2012 at 8:58 AM, Enric Balletbo Serra
<eballetbo@gmail.com> wrote:

> I see that commit dac8eb5f (OMAPDSS: TFP410: rename dvi files to
> tfp410) and commit 2e6f2ee7 (OMAPDSS: TFP410: rename dvi -> tfp410)
> changes the panel driver used on some boards. I tested current
> linux-next-20101011 kernel with my IGEPv2 board and DSS fails with
> following error (see http://pastebin.com/VjPGCQDt for full log) :
>
>    [   21.222808] omapdss OVERLAY error: check_overlay: paddr cannot be 0
>    [   21.229583] omapdss OVERLAY error: check_overlay: paddr cannot be 0
>    [   21.236236] omapfb omapfb: setup_plane failed

Was there ever any resolution to this issue?

I am seeing the same errors on Overo.  The video output actually
works, but it appears that this error causes X to close and then
restart repeatedly.

I'll add the printk's to omapfb_setup_plane() that were requested by
Tomi and report back.

Regards,

Steve
