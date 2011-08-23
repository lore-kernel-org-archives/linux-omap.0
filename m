From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: tidspbridge issue with omap_dm_timer_free
Date: Tue, 23 Aug 2011 18:03:50 -0500
Message-ID: <CAB-zwWjtO1-cU+TYJ=z-s3qFUen62-dDOomdZEh1ou953ebp9A@mail.gmail.com>
References: <CAMP44s17O-g83Fte05=AmqBP24jqgLxiBHmO6+3fbtJjWV8Ufw@mail.gmail.com>
	<CAMP44s2Wou54d2UWkwebxO17=gaVoiXrB5Lk-q2g90x3ok8L7w@mail.gmail.com>
	<CAB-zwWhRxhdrtzNy6MK=xyj25J_1adWBELVi+X=32k76owuyRw@mail.gmail.com>
	<CAMP44s2MpAE09sa-ow0k6qUjUwd-4+z-czzNaO7mv+fu0zipeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:36916 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754221Ab1HWXDv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 19:03:51 -0400
Received: by mail-vx0-f172.google.com with SMTP id 29so531051vxi.3
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 16:03:50 -0700 (PDT)
In-Reply-To: <CAMP44s2MpAE09sa-ow0k6qUjUwd-4+z-czzNaO7mv+fu0zipeA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

Hi,

On Sun, Aug 14, 2011 at 2:44 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Yeah, but with the current approach it would be possible that
> everything works fine, and then the DSP goes to hibernation, a module
> is loaded that uses one dm timer, and then when the DSP wakes up, that
> timer would fail, there isn't even a check for that. If I follow the
> code correctly, when the DSP goes back to hibernation, there would be
> a crash, as a NULL timer would be freed. I think that's too error
> prone.

Yes, this scenario could trigger such error condition. So, FWIW, I'm
fine with just a check or your approach. If possible to apply the same
mechanism for the other clocks, so in the enable/disable functions all
the clocks are then enabled/disabled avoiding mixed behavior of
enable/request, disable/free between gpt and mcbsp clocks.

Regards,

Omar
