From: Ben Gamari <bgamari.foss@gmail.com>
Subject: GPIO chip select support
Date: Tue, 30 Aug 2011 09:50:53 -0400
Message-ID: <1314712254-27199-1-git-send-email-bgamari.foss@gmail.com>
References: <CA+dZkakw9COsETWZkvMzp2v-ymfQdDEqp3jJuhWbrRTTTjpbGQ@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:53785 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab1H3NvQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 09:51:16 -0400
Received: by qyk34 with SMTP id 34so4495864qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 06:51:15 -0700 (PDT)
In-Reply-To: <CA+dZkakw9COsETWZkvMzp2v-ymfQdDEqp3jJuhWbrRTTTjpbGQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raju Sana <venkat.rajuece@gmail.com>
Cc: beagleboard@googlegroups.com, linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net


Thanks for the poke. I've been meaning to send this set out again anyways.

This is the patch I am currently using (on top of v3.0). Conceptually it's
quite similar to the first patches I sent out but some implementation details
were slightly reworked to account for the generalization of the McSPI driver to
other silicon.

I would say that the patch is close to mergable save the fact that there is
currently no clean way to set up GPIO CS pins from a board file. I'll send the
horrible hack I currently use shortly. If anyone has any ideas on how this
might be done cleanly please let me know. It's sad that the mere lack of a
configuration interface is the reason this isn't upstream.

Cheers,

- Ben

