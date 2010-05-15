From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/6] DSPBRIDGE: remove mapping information in
	proc_unmap
Date: Sat, 15 May 2010 11:38:32 +0300
Message-ID: <AANLkTilsK1ItSbn2RgUd4xd_3Otd9mHve-_5_OZ-Q6tM@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <1272746671-13423-4-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:4425 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab0EOIie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 May 2010 04:38:34 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1997413fga.1
        for <linux-omap@vger.kernel.org>; Sat, 15 May 2010 01:38:32 -0700 (PDT)
In-Reply-To: <1272746671-13423-4-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Sat, May 1, 2010 at 11:44 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Clean up all mapping information resources whenever
> a buffer is unmapped.

If I understand correctly the previous patch doesn't make sense on
it's own because it will leak memory. Therefore it should be squashed
with this one. Otherwise a git bisect might land on a very bad place.
It's good for reviewing though.

-- 
Felipe Contreras
