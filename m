From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] omap3: pandora: add DSS2 support and related regulators
Date: Wed, 13 Jan 2010 23:01:42 +0200
Message-ID: <6ed0b2681001131301v3e295a51g1d3177c51377356f@mail.gmail.com>
References: <1260559940-25103-1-git-send-email-notasas@gmail.com>
	 <1263394976.2087.106.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:53505 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787Ab0AMVBn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 16:01:43 -0500
Received: by fxm25 with SMTP id 25so645282fxm.21
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 13:01:42 -0800 (PST)
In-Reply-To: <1263394976.2087.106.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Wed, Jan 13, 2010 at 5:02 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> This doesn't apply, can you resend based on Linus' tree or my DSS2 tr=
ee?

ok, will resend shortly.

BTW, what about enabling vdds_dsi/vdds_sdi regulators we talked about
earlier? This patch already sets up those regulators in the board file
for DSS2 to get and enable them. I can come up with a patch for that
if you want (perhaps doing it somewhere in dss_init()).

>
> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
