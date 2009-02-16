From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: omap24xxvout alloc DMA page failed when using openMAX
Date: Mon, 16 Feb 2009 12:03:49 +0200
Message-ID: <94a0d4530902160203m489098b2sd9bda7322a564a1a@mail.gmail.com>
References: <87fxien3ph.fsf@redflag-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:37219 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbZBPKDx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 05:03:53 -0500
Received: by fg-out-1718.google.com with SMTP id 16so203233fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2009 02:03:49 -0800 (PST)
In-Reply-To: <87fxien3ph.fsf@redflag-linux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Diancheng <dcwang@redflag-linux.com>
Cc: linux-omap@vger.kernel.org, =?UTF-8?B?RGFuaWVsIETDrWF6?= <ddiaz@ti.com>

On Mon, Feb 16, 2009 at 11:14 AM, Wang Diancheng
<dcwang@redflag-linux.com> wrote:
> Hey, I posted this independently, and someone suggested I should send
> it to this mailing list.
> I don't read the list, so I'm not sure if this is useful or on-topic
> or what.  My apologies in advance if this is noise.
> omap24xxvout alloc DMA page failed when I use openMAX on ZOOM2 board,
> following is my test command and output:
>
>  gst-launch videotestsrc ! goosink_pp
> Setting pipeline to PAUSED ...
> Pipeline is PREROLLING ...
> ^CVIDIOC_STREAMON: Cannot allocate memory
> Caught interrupt -- handling interrupt.

I'm cc'ing Daniel D=C3=ADaz, who should know about gst-goo.

Also, you can try gst-omapfb instead:
http://github.com/felipec/gst-omapfb

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
