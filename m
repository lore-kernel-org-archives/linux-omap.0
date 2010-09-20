From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 0/5] Convert I2C driver to use omap_device/runtime PM
Date: Mon, 20 Sep 2010 11:15:43 -0700
Message-ID: <87tylkwab4.fsf@deeprootsystems.com>
References: <1284734229-16281-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58380 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab0ITSPq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 14:15:46 -0400
Received: by pzk34 with SMTP id 34so1231538pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Sep 2010 11:15:45 -0700 (PDT)
In-Reply-To: <1284734229-16281-1-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Fri, 17 Sep 2010 20:07:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra Nayak <rnayak@ti.com> writes:

> This series makes I2C device registration use hwmod
> and omap_device api's and converts the I2C driver to use
> runtime PM api's.
>
> Patches apply on the pm-core branch from Kevin's tree.
>
> v2 has minor review comment fixes over v1 and is additionally
> boot tested on a 2430sdp platform along with being tested on
> 3430sdp and 4430sdp.
>
> 4430sdp tests are done using the below series
> http://www.spinics.net/lists/linux-omap/msg36023.html

Hi Rajendra,

This series looks good to queue for 2.6.37.

Can you re-post one more time with linux-arm-kernel in CC as well as the
I2C list and Ben Dooks (MAINAINERS excerpt below for addresses.)

I will gladly merge patches 1-4, but I'll need an ack/signoff from Ben
to merge patch 5.

Thanks,

Kevin


I2C SUBSYSTEM
M:	"Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
M:	"Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
L:	linux-i2c@vger.kernel.org


