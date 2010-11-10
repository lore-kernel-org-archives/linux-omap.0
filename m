From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/5] omap: mailbox: initial hwmod support for omap3
Date: Tue, 9 Nov 2010 21:08:43 -0600
Message-ID: <AANLkTikgTauasO4noxWcNWh+bSgFYyKhLxY=88OKuDUY@mail.gmail.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
	<1288129984-22957-2-git-send-email-omar.ramirez@ti.com>
	<87k4kmgj92.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:55362 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752202Ab0KJDIp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Nov 2010 22:08:45 -0500
Received: by mail-iw0-f169.google.com with SMTP id 9so210406iwn.14
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 19:08:44 -0800 (PST)
In-Reply-To: <87k4kmgj92.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Suman Anna <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, C A Subramaniam <subramaniam.ca@ti.com>, linux-omap@vger.kernel.org

On Tue, Nov 9, 2010 at 5:38 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>> ---
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0100=
 ++++-----------------------
>> =A0arch/arm/mach-omap2/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 +
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 54 +++++++++++++=
++
>
> please separate out the addition of hwmod_data into it's own patch th=
at
> comes before this. =A0As mentioned by Charu, all the hwmod data could=
 be
> added early in the series, before this conversion is done.

Yes, this was changed in v2 [1], thanks for your comments, they will
be addressed in the next version.

Regards,

Omar

---
[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38171.htm=
l
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
