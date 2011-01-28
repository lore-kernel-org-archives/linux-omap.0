From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [PATCH 1/5] omap2+: mux: Seperate the pads of a hwmod as static
 and dynamic.
Date: Sat, 29 Jan 2011 02:19:05 +0530
Message-ID: <d52d24e46279799c2019f7c297a4e627@mail.gmail.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com> <1296191298-17545-2-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39816 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752681Ab1A1U4J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 15:56:09 -0500
Received: by mail-ww0-f52.google.com with SMTP id 20so4148802wwd.21
        for <linux-omap@vger.kernel.org>; Fri, 28 Jan 2011 12:56:08 -0800 (PST)
In-Reply-To: <1296191298-17545-2-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, paul@pwsan.com

sricharan wrote:
>
> 1) All the pads of a hwmod for the device are classified
>    as static/dynamic. If a pad requires remuxing during
>    the device transitions between enable/idle transitions
>    then it is added to the dynamic list, static otherwise.
>
> 2) Both the static/dynamic pads of a hwmod are initialised
>    when the device gets enabled. When the device transitions
>    between enable/idle the dynamic pads are remuxed and
>    static pads are skipped.
>
> 3) When the driver gets removed both the static and the
>    dynamic pads are muxed to safe mode as default.
>

I haven't taken a look at the code. I do have a few
concerns (which may really be non-issues, but I'm
pointing them out anyway):

- Not all pads have a safe mode.
--- And why would you want statically muxed pads to be remuxed
into safe mode anyway? What is the advantage of such a change,
as against leaving them in a functional mode?

- Many signals are muxed on more than one pad.
- Many peripherals need pads to be configured in different
  mux modes depending on the way a board is wired up.


With this, moving pad info to hwmod databases does not sound
useful to me. Maybe I do not understand the need for this
change, in place of what we have today.

- Anand
