From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/3] OMAP3:zoom2: Add support for OMAP3 Zoom2 board
Date: Fri, 15 May 2009 11:44:31 -0700
Message-ID: <873ab6dx4g.fsf@deeprootsystems.com>
References: <1242409235-18834-1-git-send-email-mlc@ti.com>
	<1242409235-18834-2-git-send-email-mlc@ti.com>
	<87ljoydyyt.fsf@deeprootsystems.com>
	<E49DAF743FB3E9469ED423C0D3DB5F1CA9646AEA@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:62534 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbZEOSoc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 14:44:32 -0400
Received: by pxi29 with SMTP id 29so1180559pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 11:44:33 -0700 (PDT)
In-Reply-To: <E49DAF743FB3E9469ED423C0D3DB5F1CA9646AEA@dnce01.ent.ti.com> (Mikkel Christensen's message of "Fri\, 15 May 2009 20\:28\:57 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Christensen, Mikkel" <mlc@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

"Christensen, Mikkel" <mlc@ti.com> writes:

> Hi Kevin
>
> On Fri, May 15, 2009 at 13:04:42, Kevin Hilman wrote:
>> > ---
>> >  arch/arm/mach-omap2/board-zoom2-debugboard.c |  165
>> ++++++++++++++++++++++++++
>> >  arch/arm/mach-omap2/board-zoom2.c            |  109 
>> +++++++++++++++++
>> >  2 files changed, 274 insertions(+), 0 deletions(-)  create mode
>> > 100644 arch/arm/mach-omap2/board-zoom2-debugboard.c
>> >  create mode 100644 arch/arm/mach-omap2/board-zoom2.c
>> >
>> > diff --git a/arch/arm/mach-omap2/board-zoom2-debugboard.c
>> > b/arch/arm/mach-omap2/board-zoom2-debugboard.c
>> > new file mode 100644
>> > index 0000000..e89b3af
>> > --- /dev/null
>> > +++ b/arch/arm/mach-omap2/board-zoom2-debugboard.c
>> > @@ -0,0 +1,165 @@
>> > +/*
>> > + * arch/arm/mach-omap2/board-zoom2-debugboard.c
>> 
>> Can you drop the filename here, and in the other files as well.
>
> Sure I can do the change. Is this a new convention being used? I can see the file name in many other files as well.

Yes, it still exists in many files but is not needed for new files.

First, listing the filename is a bit redundant, but also those names
tend to get out of date as files move around and the names are not
updated.

Kevin
