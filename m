From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: MMC not working reliably for Gumstix Overo Tide
Date: Sat, 10 Dec 2011 03:24:16 +0200
Message-ID: <CAMP44s27Omkuhy9RUi-TfhjoWUr37XEYiSKnCcC=5Tk9UKpT9A@mail.gmail.com>
References: <jbua2s$8qq$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36729 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab1LJBYQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 20:24:16 -0500
Received: by dajs34 with SMTP id s34so191358daj.19
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 17:24:16 -0800 (PST)
In-Reply-To: <jbua2s$8qq$1@dough.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Cc: linux-omap@vger.kernel.org

On Sat, Dec 10, 2011 at 2:45 AM, Andre Puschmann
<andre.puschmann@tu-ilmenau.de> wrote:
> I've got a Gumstix Overo Tide (OMAP 3530) based board here which doesn't
> have NAND and therefore needs the MMC to boot.
>
> I've successfully built a kernel using Tony's master branch. The system
> boots fine up to the point where the MMC driver loads (well, I guess
> that is where the problem lies). I am using omap2plus_defconfig. The
> weird thing is that sometimes the system hangs after printing "Waiting
> for root device /dev/mmcblk0p2..." and sometimes after mounting the
> rootfs. Any ideas? I've seen some probelms with MMC in the recent past,
> could that be the cause?

Have you tried this in the command line? rootwait rootdelay=1

-- 
Felipe Contreras
