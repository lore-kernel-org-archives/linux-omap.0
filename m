From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] dspbridge: deh: fix corruption on MMU fault
Date: Fri, 14 May 2010 01:42:47 +0300
Message-ID: <AANLkTimJ0La59QijKT07GCZocapSZMmMg-OFT3m7sG0F@mail.gmail.com>
References: <1273783601-13472-1-git-send-email-felipe.contreras@gmail.com>
	 <1273783601-13472-2-git-send-email-felipe.contreras@gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB6CABC3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57987 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756003Ab0EMWmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 18:42:50 -0400
Received: by fxm6 with SMTP id 6so921775fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 15:42:48 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CB6CABC3@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>

On Fri, May 14, 2010 at 12:21 AM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
> dump_dsp_stack is waiting DSP for dumping the stack, I don't think that you
> are getting the complete dump with this patch.

I'm not getting it anyway. Besides, that feature should be
configurable so we can disable it on production systems. If this patch
indeed prevents that feature from working, then all that code should
be somehow configurable. Probably all the GPT8 code is not really
needed either and can be enabled only when
CONFIG_OMAP_BRIDGE_BACKTRACE.

In the meantime, getting rid of memory corruption > having dump stack
functionality.

Are you using the public L23.i3.3 baseimage?

-- 
Felipe Contreras
