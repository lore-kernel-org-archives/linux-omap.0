From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/2] omap: rx51: Fix broken fb on RX51/N900
Date: Wed, 22 Dec 2010 08:56:38 +0200
Message-ID: <20101222085638.226a1269.jhnikula@gmail.com>
References: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
	<20101221202133.GJ5829@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:65427 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab0LVG4y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 01:56:54 -0500
Received: by bwz16 with SMTP id 16so5423007bwz.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Dec 2010 22:56:53 -0800 (PST)
In-Reply-To: <20101221202133.GJ5829@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Tue, 21 Dec 2010 12:21:33 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Jarkko Nikula <jhnikula@gmail.com> [101221 09:25]:
> > Hi
> > 
> > Commit 60d24ee "Added video data to support tvout on rx51" broke the
> > framebuffer on N900. Here are two patches where 1st one does a little cleanup
> > to be sync with the 2nd fixing the issue. I've tested that both tvout and lcd
> > are working.
> 
> Tomi, do you want to pick these three DSS/video related patches from Jarkko?
> 
> If so:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> else please ack and let me know if you want me to take them.
> 
I think these should go to linux-omap since the breakage is there and
anyway touch only the rx51 board files.

-- 
Jarkko
