From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] omap3: pandora: add DSS2 support and related regulators
Date: Thu, 14 Jan 2010 22:37:48 +0200
Message-ID: <6ed0b2681001141237m2691037dsc7e84f8a70292a95@mail.gmail.com>
References: <1260559940-25103-1-git-send-email-notasas@gmail.com>
	 <1263394976.2087.106.camel@tubuntu.research.nokia.com>
	 <6ed0b2681001131301v3e295a51g1d3177c51377356f@mail.gmail.com>
	 <1263477920.2087.186.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:20023 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab0ANUhu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jan 2010 15:37:50 -0500
Received: by fg-out-1718.google.com with SMTP id e21so423700fga.1
        for <linux-omap@vger.kernel.org>; Thu, 14 Jan 2010 12:37:49 -0800 (PST)
In-Reply-To: <1263477920.2087.186.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jan 14, 2010 at 4:05 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Wed, 2010-01-13 at 22:01 +0100, ext Grazvydas Ignotas wrote:
>> On Wed, Jan 13, 2010 at 5:02 PM, Tomi Valkeinen
>> <tomi.valkeinen@nokia.com> wrote:
>> > Hi,
>> >
>> > This doesn't apply, can you resend based on Linus' tree or my DSS2=
 tree?
>>
>> ok, will resend shortly.
>>
>> BTW, what about enabling vdds_dsi/vdds_sdi regulators we talked abou=
t
>> earlier? This patch already sets up those regulators in the board fi=
le
>> for DSS2 to get and enable them. I can come up with a patch for that
>> if you want (perhaps doing it somewhere in dss_init()).
>
> It would be nice to get this clarified from TI's HW side, but I haven=
't
> had time to do that.
>
> However, it sure looks like your theory is correct, so a patch would =
be
> ok.
>
> I don't think dss_init is a proper place for it. The power only needs=
 to
> be enabled when the display is on, so perhaps
> dpi_display_enable/disable() would be better place to turn it on and =
off
> (and suspend/resume). Below is a quick patch I made to test this.
>
> But is the same code needed by RFBI and SDI also? And is it needed on=
ly
> when certain pins are in use? And only on OMAP3. I'm not sure what wo=
uld
> be the most elegant way for this, but perhaps for now it's good enoug=
h
> if we enable the power in dpi.c's enable/disable.

I can only test this on pandora (24bit parallel display), and your
patch works fine there.

Gra=C5=BEvydas

PS: I see some author names got mangled in your GIT (got prefixed with =
'ext').
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
