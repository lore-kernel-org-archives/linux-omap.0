From: Kalle Vahlman <kalle.vahlman@gmail.com>
Subject: Re: Diagnosing issues with OMAPDSS scaling of overlay 0
Date: Mon, 11 Apr 2011 15:11:04 +0300
Message-ID: <BANLkTimt6jkTzO=UXnGhhiyh-+9vtUcUCQ@mail.gmail.com>
References: <f49bfabe-ecf0-4e9e-89d5-1a6a5c00b4b3@zimbra.xlogic.pl> <1302518279.2198.65.camel@deskari>
Reply-To: zuh@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51099 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1DKMLY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Apr 2011 08:11:24 -0400
Received: by qyk7 with SMTP id 7so1200354qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Apr 2011 05:11:24 -0700 (PDT)
In-Reply-To: <1302518279.2198.65.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: =?UTF-8?Q?Tomasz_M=C5=82oduchowski?= <tomasz.mloduchowski@xlogic.pl>, linux-omap@vger.kernel.org

2011/4/11 Tomi Valkeinen <tomi.valkeinen@ti.com>
> But you are right that normal user shouldn't need to read the TRM if he
> just wants to use scaling =). So either the sysfs/ioctl interfaces
> should force the user to use things correctly, or he should get clear
> warnings/errors when he uses things incorrectly, or the documentation
> should say these things.

If the sysfs interface is not there, the questions will just turn from
"why does it not work" to "why is there no sysfs entry"...

Good, descriptive error messages are the best way to avoid confusion.
If there is no reason to suspect that future hardware revisions will
support scaling the gfx layer, then a documentation mention would be a
nice addition (but not replacement).

--
Kalle Vahlman, zuh@iki.fi
Powered by http://movial.com
Interesting stuff at http://sandbox.movial.com
