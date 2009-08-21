From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Oops on shutdown?
Date: Fri, 21 Aug 2009 13:33:30 -0700
Message-ID: <5e088bd90908211333x68f7487ax6a1a23b761eb9861@mail.gmail.com>
References: <5e088bd90908200834o5b816127offa6b592a99526ca@mail.gmail.com>
	 <bb2708720908211325t408ae640r34c72178aa0dcf26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:55504 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932441AbZHUUd3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 16:33:29 -0400
Received: by qyk3 with SMTP id 3so36045qyk.4
        for <linux-omap@vger.kernel.org>; Fri, 21 Aug 2009 13:33:30 -0700 (PDT)
In-Reply-To: <bb2708720908211325t408ae640r34c72178aa0dcf26@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Sarman <johnsarman@gmail.com>, linux-omap@vger.kernel.org

On Fri, Aug 21, 2009 at 1:25 PM, John Sarman<johnsarman@gmail.com> wrot=
e:

> Related to the Gumstix Overo
> How is the USB working on this version. =A0I am still stuck using the
> 2.6.20-rc8, with patches for the hwmod and mmc updates. =A0This is th=
e
> last version I can successfully use the USB host.

USB host works fine if you use my patch from last week: ARM: OMAP3:
Overo: Fix EHCI initialization

You will also need one other patch, see the comment in my patch
referenced above.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
