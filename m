From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/11] OMAP: GPIO: Implement GPIO in HWMOD way
Date: Thu, 03 Jun 2010 11:21:44 -0700
Message-ID: <87typkrn7r.fsf@deeprootsystems.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
	<20100518234222.GV5818@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5666371@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51760 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405Ab0FCSVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 14:21:50 -0400
Received: by pvg16 with SMTP id 16so193944pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 11:21:48 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5666371@dbde02.ent.ti.com> (Charulatha Varadarajan's message of "Wed\, 19 May 2010 13\:00\:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:

>> * Charulatha V <charu@ti.com> [100518 07:44]:
>> > This patch series implements GPIO module in platform device model.
>> > It also makes OMAP2PLUS specific GPIO implemented in HWMOD FW way.
>> >
>> > This patch series is created on "origin/pm-wip/runtime".
>> >
>> > This patch series is tested on OMAP3430 SDP board. It would be of
>> > great help if someone could test the same on OMAP1 and OMAP2 boards.
>> 
>> Great, thanks. Let's give review these, and then if no more comments,
>> let's test them in the linux-omap master branch. Too late to get
>> these merged for this merge window for sure.
>
> GPIO uses pm_runtime APIs and unless all pm_runtime related patches are 
> upstreamed, we cannot test this patch series on linux-omap master branch. 

FYI... The runtime PM patches have now been posted[1] for review and
for upstream.

Kevin

[1] http://marc.info/?l=linux-omap&m=127499480300445&w=2

