From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98 breaks omapfb (old
	non-dss2)
Date: Tue, 15 Dec 2009 22:50:43 +0300
Message-ID: <48239d390912151150q1d66caafp672804f056f8bb63@mail.gmail.com>
References: <48239d390912150158xdf2999dr6b43f21c64456002@mail.gmail.com>
	 <1260890578.6017.11.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:63479 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760946AbZLOTup (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 14:50:45 -0500
Received: by ewy19 with SMTP id 19so233080ewy.21
        for <linux-omap@vger.kernel.org>; Tue, 15 Dec 2009 11:50:43 -0800 (PST)
In-Reply-To: <1260890578.6017.11.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>> Also - is there some guidelines on porting old RFBI-based driver to DSS2?
>
> No, and currently the DSS2 RFBI support may not work. I don't have
> hardware to test it, and the DSS driver has changed around it. Can
> anyone confirm that the RFBI support works, and does anyone have public
> RFBI drivers?
Well, in tree, drivers/video/omap/hwa742.c is driver for RFBI-based
display driver with hwa742 controller.
I think porting Nokia 770 to DSS2 could be nice example...
Actually, old RFBI driver is very limited comparing to OMAP3 features,
and supports
only 16bit color mode (hardcoded). I'd like to see OMAP3 features
there, some of them are trivial to add,
I have some patches for that, but they are simply bad approach because
they are based on old driver,
hardcode values, use hackish approaches. So, I'd like to see "the
right way", so I could move farther
with them and toss that messy junk.

Thanks a lot,
S.
