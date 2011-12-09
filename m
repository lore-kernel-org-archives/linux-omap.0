From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: It looks like snd-soc-rx51 only works as built-in, not as a module
Date: Sat, 10 Dec 2011 01:04:49 +0200
Message-ID: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40382 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab1LIXEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 18:04:50 -0500
Received: by dajs34 with SMTP id s34so117238daj.19
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 15:04:49 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Hi,

Pretty much $subject. Any ideas about why?

# cat /proc/asound/cards
--- no soundcards ---

There's no error message or anything, and rx51_soc_init() exists properly.

Cheers.

-- 
Felipe Contreras
