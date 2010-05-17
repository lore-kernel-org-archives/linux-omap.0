From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Mon, 17 May 2010 03:05:07 +0300
Message-ID: <AANLkTin3y-RpOYfaa9rzK9HraeOAdkXsC3N0FDGo-iA9@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
	 <r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
	 <AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
	 <AANLkTikxM8gISXO_wSVNOM6FKC8l5MbLy1nSMmgMB_4w@mail.gmail.com>
	 <AANLkTikAkqatIMvdFPwVvwYV_4Tw3-SsUkBAjwK2Oa_P@mail.gmail.com>
	 <AANLkTin0hfLWtD9BubW7ihUj2TriXyiXNMhP3IuXlcug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:57785 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab0EQAFK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 20:05:10 -0400
Received: by ewy8 with SMTP id 8so1604729ewy.28
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 17:05:09 -0700 (PDT)
In-Reply-To: <AANLkTin0hfLWtD9BubW7ihUj2TriXyiXNMhP3IuXlcug@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Mon, May 17, 2010 at 2:25 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Out of curiosity, what board/environment do you use to play with
> the code ? I'd like to run the same use cases you do, so I can
> reproduce any issue you may bump into.

I use a beagleboard, use the DSP firmware in L23.i3.3[1], do simple
tests with dsp-test[2], and real tests with gst-dsp[3].

I just pushed my latest changes of dsp-tools, which include an app
called dsp-test that sends buffers back and forth (like TI's
dmmcopy.out), but has options to trigger MMU faults, change buffer
sizes, and number of iterations, along with a trivial DSP socket-node.

The whole thing (app + socket-node) is 15K and you don't even need
dynreg.out to load. Also, the code is really really simple. There are
no dependencies, so you can just type 'make'.

I'm not sure if you are familiar with GStreamer, but that's pretty
much all you need to compile gst-dsp. If you have problems we have a
relatively active mailing list.

Cheers.

[1] http://www.omapedia.org/wiki/L23.i3.3_Release_Notes
[2] http://github.com/felipec/dsp-tools
[3] http://github.com/felipec/gst-dsp

-- 
Felipe Contreras
