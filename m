From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] omap: mux: fix multipath gpio handling
Date: Tue, 6 Jul 2010 16:54:45 +0300
Message-ID: <AANLkTinoHVSoQ9bl448jgS-5jBDK2vgA2G3OcjpOaw_n@mail.gmail.com>
References: <1278360411-25797-1-git-send-email-notasas@gmail.com>
	<20100706132510.GS3192@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43558 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab0GFNyq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 09:54:46 -0400
Received: by pvc7 with SMTP id 7so2587219pvc.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Jul 2010 06:54:46 -0700 (PDT)
In-Reply-To: <20100706132510.GS3192@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, Jul 6, 2010 at 4:25 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Grazvydas Ignotas <notasas@gmail.com> [100705 23:00]:
>> OMAP3530 CBB package can have GPIO126 muxed on 2 pins: mmc1_dat4 and
>> cam_strobe. This causes a problem with current multipath GPIO mux
>> handling, which muxes both pins as GPIO126 and makes the GPIO unusable.
>>
>> Fix this by not muxing any pins if multipath GPIO is detected and
>> just print a warning instead. It's up to board files to set correct
>> mux using omap_mux_init_signal and pin name.
>
> This looks good to me. Are you OK if we merge it during the upcoming
> merge window? Kind of worried that we might break some other boards
> that rely on the first GPIO getting muxed..

Yeah that should be fine, no need to rush.
