From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: U-boot: ARM: OMAP3/4: proposal: Cleanup MUX
Date: Fri, 05 Nov 2010 15:59:40 -0400
Message-ID: <4CD4622C.1060000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36891 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab0KET7q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 15:59:46 -0400
Received: by gyh4 with SMTP id 4so2458977gyh.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 12:59:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Folks,

Might be slightly off topic, hence posting separately instead of cross 
posting.

I just posted a proposal to mainline u-boot for cleaning up mux 
framework there - does any supported platform find this impossible to 
live with? I know for sure that OMAP4 muxing will be broken as a result 
- but we ought to get this fixed at some point.


Regards,
Nishanth Menon

-------- Original Message --------
Subject: ARM: OMAP3/4: proposal: Cleanup MUX
Date: Fri, 05 Nov 2010 15:56:46 -0400
From: Nishanth Menon <menon.nishanth@gmail.com>
To: U-Boot@lists.denx.de

Folks,
I would like to work on the following: Cleanup mux configurations done
in OMAP3 and 4 platforms. includes the following:
a) have isolate mux configurations per IP configuration, e.g. for EHCI,
we have a mux array definition for EHCI etc..
b) remove ALL mux configurations that are not relevant for u-boot
functionality - currently we do all muxing in u-boot(including stuff
like camera which obviously we dont use in u-boot).

any kernel breakages as a result of "assumptions" of muxing already done
is to be fixed in kernel itself - kernel *has* a mux framework for OMAP
and platforms files *should* be using that for kernel functionality that
they need. no point in carrying that burden in u-boot.

I would like to post this patches so that for the next merge window we
could pull this in and notify the linux-omap kernel guys to fix their
stuff if they depend on u-boot for mux configurations - it is high time
they stop being closely tied to U-boot and have capability to deal with
other bootloaders which may or maynot have capability for doing muxing -
it also saves us to add and maintain mux configurations for linux kernel
booting -> u-boot is supposed to support multiple operating systems (not
just linux kernel).

-- 
Regards,
Nishanth Menon
