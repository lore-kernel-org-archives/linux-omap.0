From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: LCD blanking?
Date: Tue, 25 Aug 2009 16:42:17 -0400
Message-ID: <f96d234e0908251342q387e84cdsda6fc007d54a99d4@mail.gmail.com>
References: <4A93ED3E.4030505@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f183.google.com ([209.85.211.183]:48859 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114AbZHYUmQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Aug 2009 16:42:16 -0400
Received: by ywh13 with SMTP id 13so4436490ywh.15
        for <linux-omap@vger.kernel.org>; Tue, 25 Aug 2009 13:42:17 -0700 (PDT)
In-Reply-To: <4A93ED3E.4030505@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Tue, Aug 25, 2009 at 9:55 AM, Gary Thomas<gary@mlbassoc.com> wrote:
> I have a system with an LCD, running Tomi's DSS2 support.
> One problem I'm having is that after a while, the LCD blanks
> out (I do have fbcon support enabled so I can use it as a
> glass TTY - no keyboard)
>
> How can I keep this from happening?
> Once it does, is there any way to get it back on (remember,
> no keyboard)?

There are ways to do this from user space, but a quick hack I sometimes use is:

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 60359c3..eda7c14 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -172,7 +172,8 @@ int do_poke_blanked_console;
 int console_blanked;

 static int vesa_blank_mode; /* 0:none 1:suspendV 2:suspendH 3:powerdown */
-static int blankinterval = 10*60*HZ;
+//static int blankinterval = 10*60*HZ;
+static int blankinterval = 0;
 static int vesa_off_interval;

Cliff

=================
http://bec-systems.com
