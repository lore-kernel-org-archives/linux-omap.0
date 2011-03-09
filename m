From: Steve Sakoman <steve@sakoman.com>
Subject: Re: [PATCH] omap: overo: Add regulator for ads7846
Date: Tue, 8 Mar 2011 16:15:59 -0800
Message-ID: <AANLkTi=3D+fnZsFaYqFf1xeCBwuDHT4vv9S4ySH3k9Tf@mail.gmail.com>
References: <1299341546-17289-1-git-send-email-steve@sakoman.com>
	<20110308231615.GH26463@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47581 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719Ab1CIAQA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 19:16:00 -0500
Received: by qwd7 with SMTP id 7so3898qwd.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 16:15:59 -0800 (PST)
In-Reply-To: <20110308231615.GH26463@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com

On Tue, Mar 8, 2011 at 3:16 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Steve Sakoman <steve@sakoman.com> [110305 08:10]:
>> The ads7846 driver now requires a regulator. =A0This patch adds the
>> necessary regulator to the overo board file. =A0Without it, the
>> following error occurs (and the touchscreen will not function):
>>
>> ads7846 spi1.0: unable to get regulator: -19
>>
>> Signed-off-by: Steve Sakoman <steve@sakoman.com>
>> ---
>> Note: this patch should be applied after the "[PATCH v3 0/2] Add DSS=
2
>> support on Overo" series.
>
> Tomi can you please take this one to avoid merge conflicts?

Tomi: if it helps, I have this patch in my for-tomba branch (including
Tony's ack):

http://www.sakoman.com/cgi-bin/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dsh=
ortlog;h=3Drefs/heads/for-tomba

Tony: I have a couple more patches queued up to add gpio-led and
gpio-keys support to Overo.  I've been holding off submitting because
I haven't been quite sure what branch to base them on to minimize
merge conflicts. For the moment they are based on Tomi's branch and
sitting in the for-tomba branch.  Any suggestions?

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
