From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 2/2] ARM: omap: dmtimer: set non-posted mode if iclk less
 than 4*fck
Date: Wed, 6 Jun 2012 16:41:26 +0530
Message-ID: <CAC83ZvKv_kwvYLG3RfN-ttKXU8pg+yqRGa9S83BAJj6=yeVP2g@mail.gmail.com>
References: <1336744398-23803-1-git-send-email-tarun.kanti@ti.com>
	<1336744398-23803-3-git-send-email-tarun.kanti@ti.com>
	<87pq9mel9i.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:51777 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752590Ab2FFLLa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jun 2012 07:11:30 -0400
Received: by qaea16 with SMTP id a16so4251099qae.3
        for <linux-omap@vger.kernel.org>; Wed, 06 Jun 2012 04:11:27 -0700 (PDT)
In-Reply-To: <87pq9mel9i.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, santosh.shilimkar@ti.com, b-cousson@ti.com

On Wed, May 30, 2012 at 2:51 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> Timers in PER domain periodically report old time from TCRR in
>> posted mode if ick < 4*fck. Therefore, set timer to non-posted
>> whenever ick < 4*fck for all timers.
>
> Is there an erratum assocaited with this?
Yes, but it has not yet got into the document. Right now what we have
is a hardware defect.
>
> Does this problem affect every SoC?
Not quite sure about OMAP2 but it affects OMAP3+.
--
Tarun
>
> Kevin
