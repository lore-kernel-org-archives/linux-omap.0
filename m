From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 3/3] CBUS: Make retu watchdog behave like a standard
	Linux watchdog
Date: Tue, 13 May 2008 03:46:49 +0300
Message-ID: <1210639609.20589.13.camel@mort>
References: retu-2008-05-12-173514 <1210638918-26644-1-git-send-email-tony@atomide.com>
	 <1210638918-26644-2-git-send-email-tony@atomide.com>
	 <1210638918-26644-3-git-send-email-tony@atomide.com>
	 <1210638918-26644-4-git-send-email-tony@atomide.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49630 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899AbYEMAz7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2008 20:55:59 -0400
In-Reply-To: <1210638918-26644-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,
On Mon, 2008-05-12 at 17:35 -0700, ext Tony Lindgren wrote:
> Make retu watchdog behave like a standard Linux watchdog.
>=20
> Let the kernel do the kicking until the watchdog device is opened.

This is not always the desidered behavior: the powerdown wd is used to
ensure that the whole sw stack is healty: doing the kicking in
kernelspace for free introduces the case where userspace can get stuck
and the device does not powerdown.

Also the unconditional loading of the maximum value during probe is not
aligned with the original reset logic, which was to have the powerdown
wd to allow for 2 boot attempts:

-cold boot -> load max value in retu wd (63s)
           -> load 30s in omap wd
-try to kick both wds

if fail, then omap reboots, but retu keeps counting down

-warm boot -> let the retu wd untouched=EF=BB=BF
           -> load 30s in omap wd=EF=BB=BF
-try to kick both wds

if fail, retu powers down

That was the original idea in 770 times and i still like it.

To conclude, i'd see inkernel kicking more as a debugging feature while
one is hacking at the kernel than a desirable quality of a stable
kernel.

--=20
Cheers, Igor

---

Igor Stoppa
Nokia Devices R&D - Helsinki
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
