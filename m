From: "Suresh Rajashekara" <suresh@mistralsolutions.com>
Subject: Audio Click Issue on OMAP
Date: Tue, 11 Mar 2008 16:01:22 +0530
Message-ID: <cd1b82be0803110331m18c8ab9cq7e457fd26f34106e@mail.gmail.com>
Reply-To: suresh@mistralsolutions.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:60546 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbYCKKb2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2008 06:31:28 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2184279fkz.5
        for <linux-omap@vger.kernel.org>; Tue, 11 Mar 2008 03:31:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Khasim <khasim@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>

Hi,

I am using the ALSA SoC driver on the OMAP2430 SDP. The codec
initialization is being done in the soc->startup and uninitialized in
the soc->shutdown routine. Since these routines gets executed every
time some audio sample is played, there is a click noise heard just
before the sample starts playing. Any idea how this can be resolved?

One idea that I have thought of is to move this initialization of the
codec stuff to bootup time so that click is heard only during the
bootup and never again. The codec is kept initialized until the board
is switched off. I am not sure, but I think this might affect the
battery life of the device. Please let me know if I am incorrect?

Thanks in advance

Best Regards,
Suresh
