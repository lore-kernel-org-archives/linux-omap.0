From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: Re: [alsa-devel] Audio suspend/resume status on OMAP3 based platforms
Date: Tue, 12 Jan 2010 23:19:26 +0530
Message-ID: <2ee9e08d1001120949l5b1e5b8dhd96c09faabcea91d@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7807@dbde02.ent.ti.com>
	<20100112161109.GC17092@sirena.org.uk>
Reply-To: anuj.aggarwal@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:47467 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0ALRtr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 12:49:47 -0500
Received: by pzk1 with SMTP id 1so6399485pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 09:49:46 -0800 (PST)
In-Reply-To: <20100112161109.GC17092@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jan 12, 2010 at 9:41 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>
> On Tue, Jan 12, 2010 at 09:35:15PM +0530, Aggarwal, Anuj wrote:
>
> > b) same command, when audio loopback is running in
> > background
>
> It'd be helpful to specify what you mean by audio loopback here - I
> think you mean something along the lines of 'arecord | aplay -' but
> it'd be good to confirm since there's multiple meanings people use for
> the term.
Thanks for pointing it out, I meant the same:
arecord -f cd | aplay &
echo mem > /sys/power/state
