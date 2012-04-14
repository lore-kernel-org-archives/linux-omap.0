From: Enrico <ebutera@users.sourceforge.net>
Subject: Re: linux-3.0: sporadic "illegal instruction" in init scripts
Date: Sat, 14 Apr 2012 13:49:00 +0200
Message-ID: <CA+2YH7vtGB_cXTxtb4Yimwi7_WT8P4aJAbhxt=eevi81wCeMPA@mail.gmail.com>
References: <4F886CD7.3060402@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54553 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab2DNLtC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Apr 2012 07:49:02 -0400
Received: by vcqp1 with SMTP id p1so2526051vcq.19
        for <linux-omap@vger.kernel.org>; Sat, 14 Apr 2012 04:49:00 -0700 (PDT)
In-Reply-To: <4F886CD7.3060402@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Apr 13, 2012 at 8:13 PM, Peter Barada <peter.barada@logicpd.com> wrote:
> I'm using linux-3.0 as released on ftp/kernel.org on an DM37x based
> board, and I've run into sporadic cases where the init scripts exit with
> "illegal instruction" when using a ramdisk as the rootfs:

Is it running at 1GHz? If yes, are you aware of smartreflex, abb,
hot/cold devices...?

Enrico
