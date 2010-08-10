From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/3] omap: n8x0: Audio update to N810
Date: Tue, 10 Aug 2010 15:43:46 +0300
Message-ID: <20100810154346.a23e0341.jhnikula@gmail.com>
References: <1281340740-10823-1-git-send-email-jhnikula@gmail.com>
	<20100810120733.GI32480@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45662 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757142Ab0HJMoB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 08:44:01 -0400
Received: by ewy23 with SMTP id 23so3799879ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 05:44:00 -0700 (PDT)
In-Reply-To: <20100810120733.GI32480@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, 10 Aug 2010 15:07:34 +0300
Tony Lindgren <tony@atomide.com> wrote:

> > With this set and a fix [1] it is possible to get ALSA SoC on N810 working.
> > 
> > This set is generated against mainline commit e320cea but applies also to
> > linux-omap (board-n8x0.c has cbus patches in linux-omap).
> 
> I've added these into omap for-next for 2.6.37. Let me know if these should
> go in along with other ASoC patches.
> 
Ok, good. This is independent set so no need for any special
procedure :-)


-- 
Jarkko
