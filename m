From: Steve Sakoman <steve@sakoman.com>
Subject: Re: [PATCH v2 1/2] OMAP: DSS2: Add support for LG Philips LB035Q02 panel
Date: Sat, 5 Mar 2011 04:44:45 -0800
Message-ID: <AANLkTinH2jxnBJT8JePNp7Ckw8Gd+9HKS33pUQ50fDGZ@mail.gmail.com>
References: <1299271940-4286-1-git-send-email-steve@sakoman.com>
	<1299271940-4286-2-git-send-email-steve@sakoman.com>
	<1299316682.2311.0.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40407 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab1CEMoq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 07:44:46 -0500
Received: by qwd7 with SMTP id 7so2273571qwd.19
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 04:44:45 -0800 (PST)
In-Reply-To: <1299316682.2311.0.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Mar 5, 2011 at 1:18 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> Hi,
>
> On Fri, 2011-03-04 at 14:52 -0600, Steve Sakoman wrote:
>> This patch adds support for the Gumstix Palo35 expansion board
>> which utilizes the 320 x 240 pixel LG.Philips LB035Q02 LCD Panel
>>
>> Signed-off-by: Steve Sakoman <steve@sakoman.com>
>> ---
>> =A0drivers/video/omap2/displays/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A06 +
>> =A0drivers/video/omap2/displays/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 +
>> =A0.../omap2/displays/panel-lgphilips-lb035q02.c =A0 =A0 =A0| =A0278=
 ++++++++++++++++++++
>> =A03 files changed, 285 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/video/omap2/displays/panel-lgphilips-l=
b035q02.c
>
> This doesn't compile.

Sigh, that is because I am an idiot and sent from the wrong branch!  I
am really sorry to have wasted your time -- version 3 from the right
branch on the way.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
