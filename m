From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 3/6] DSPBRIDGE: remove mapping information in
	proc_unmap
Date: Mon, 17 May 2010 02:02:48 +0300
Message-ID: <AANLkTikWGcHZMz3hXepsNDAKx5GzKR2ugHd6GJ9GKvhz@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<1272746671-13423-4-git-send-email-ohad@wizery.com> <AANLkTilsK1ItSbn2RgUd4xd_3Otd9mHve-_5_OZ-Q6tM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36802 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab0EPXDJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 19:03:09 -0400
Received: by gyg13 with SMTP id 13so1845675gyg.19
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 16:03:08 -0700 (PDT)
In-Reply-To: <AANLkTilsK1ItSbn2RgUd4xd_3Otd9mHve-_5_OZ-Q6tM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Hi Felipe,

On Sat, May 15, 2010 at 11:38 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, May 1, 2010 at 11:44 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Clean up all mapping information resources whenever
>> a buffer is unmapped.
>
> If I understand correctly the previous patch doesn't make sense on
> it's own because it will leak memory. Therefore it should be squashed
> with this one. Otherwise a git bisect might land on a very bad place.
> It's good for reviewing though.

Squashed it will be.

Thanks for your review,
Ohad.

>
> --
> Felipe Contreras
>
