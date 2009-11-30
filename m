From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] [OMAP1] use gen_nand
Date: Mon, 30 Nov 2009 11:38:47 -0800
Message-ID: <a55d774e0911301138l7a80de4dx911d73c33962559e@mail.gmail.com>
References: <20091123124545.GA31420@localhost.localdomain>
	 <20091123172416.GG15580@atomide.com>
	 <20091130202258.GA18203@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:5185 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZK3Tis (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 14:38:48 -0500
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id nAUJcq5g021821
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 19:38:53 GMT
Received: from pxi17 (pxi17.prod.google.com [10.243.27.17])
	by wpaz29.hot.corp.google.com with ESMTP id nAUJcmiw012219
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 11:38:48 -0800
Received: by pxi17 with SMTP id 17so4704461pxi.30
        for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 11:38:48 -0800 (PST)
In-Reply-To: <20091130202258.GA18203@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Kevin Hilman <kjh@hilman.org>

On Mon, Nov 30, 2009 at 12:23 PM, Ladislav Michl
<Ladislav.Michl@seznam.cz> wrote:
> On Mon, Nov 23, 2009 at 09:24:16AM -0800, Tony Lindgren wrote:
>> * Ladislav Michl <Ladislav.Michl@seznam.cz> [091123 03:45]:
>> > Since omapnand driver never find its way into mainline, switch to gen_nand instead.
>> > Following patch is compile tested only, but it is based on code I wrote for
>> > NetStar board and runtime tested it there.
>>
>> Nice patch, and totally the way to go!
>
> Well, after one week of silence... Anything else I could do to get it merged?
> Btw, these boards could probably use physmap-flash, so we could get rid of
> omap_nor as well.

No objections here.  We haven't used f-sample boards since 2005, so
there's no side-effects to cleanup that I'm worried about.

Brian
