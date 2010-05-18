From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Tue, 18 May 2010 09:20:56 +0300
Message-ID: <AANLkTin8spHFJvWqA97lOcfzhnNq-lv3hulpZilNgG_h@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
	<r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
	<AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
	<AANLkTikxM8gISXO_wSVNOM6FKC8l5MbLy1nSMmgMB_4w@mail.gmail.com>
	<AANLkTikAkqatIMvdFPwVvwYV_4Tw3-SsUkBAjwK2Oa_P@mail.gmail.com>
	<AANLkTin0hfLWtD9BubW7ihUj2TriXyiXNMhP3IuXlcug@mail.gmail.com>
	<AANLkTin3y-RpOYfaa9rzK9HraeOAdkXsC3N0FDGo-iA9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:43814 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab0ERG2t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 02:28:49 -0400
Received: by ywh6 with SMTP id 6so3038193ywh.16
        for <linux-omap@vger.kernel.org>; Mon, 17 May 2010 23:28:48 -0700 (PDT)
In-Reply-To: <AANLkTin3y-RpOYfaa9rzK9HraeOAdkXsC3N0FDGo-iA9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Hi Felipe,

On Mon, May 17, 2010 at 3:05 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, May 17, 2010 at 2:25 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Out of curiosity, what board/environment do you use to play with
>> the code ? I'd like to run the same use cases you do, so I can
>> reproduce any issue you may bump into.
>
> I use a beagleboard, use the DSP firmware in L23.i3.3[1], do simple
> tests with dsp-test[2], and real tests with gst-dsp[3].
>
> I just pushed my latest changes of dsp-tools, which include an app
> called dsp-test that sends buffers back and forth (like TI's
> dmmcopy.out), but has options to trigger MMU faults, change buffer
> sizes, and number of iterations, along with a trivial DSP socket-node.
>
> The whole thing (app + socket-node) is 15K and you don't even need
> dynreg.out to load. Also, the code is really really simple. There are
> no dependencies, so you can just type 'make'.
>
> I'm not sure if you are familiar with GStreamer, but that's pretty
> much all you need to compile gst-dsp. If you have problems we have a
> relatively active mailing list.

Thanks for the detailed answer!

I'll surely look into this.
Ohad.

>
> Cheers.
>
> [1] http://www.omapedia.org/wiki/L23.i3.3_Release_Notes
> [2] http://github.com/felipec/dsp-tools
> [3] http://github.com/felipec/gst-dsp
>
> --
> Felipe Contreras
>
