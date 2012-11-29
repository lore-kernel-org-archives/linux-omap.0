From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Thu, 29 Nov 2012 06:18:52 -0800
Message-ID: <CAGDS+n=oQYr+24mX6bdgtW=fzvfvfX5rAvNXXpxM4YKPxHDodQ@mail.gmail.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
	<CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
	<50ADE6A5.3030001@ti.com>
	<CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com>
	<50AF37EA.3080400@ti.com>
	<CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com>
	<50B4A4D7.2070203@ti.com>
	<CAGDS+nmaGK1igkYnz0EQEycUU=LsD5yz9wxmipSnWohKvAPTXA@mail.gmail.com>
	<50B74592.3020308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60410 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab2K2OSy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 09:18:54 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so14510414oag.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Nov 2012 06:18:54 -0800 (PST)
In-Reply-To: <50B74592.3020308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

On Thu, Nov 29, 2012 at 3:22 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2012-11-27 21:15, Steve Sakoman wrote:
>> It seems that dss_mgr_check_timings is being called with a null dssdev->manager.
>>
>> Other than the fact that there should be a null pointer check in the
>> code, it seems that this is a regression since it used to be possible
>> to switch the default display in this fashion.  Is this no longer
>> allowed?
>
> It is allowed. Which kernel is that? I tried v3.7-rc4 and the current
> omapdss master, both work for me with overo + lcd43 add on.

It is stock Linux 3.6 (i.e. commit a0d271cbfed1dd50278c6b06bead3d00ba0a88f9)

Steve
