From: Jan Blunck <jblunck@infradead.org>
Subject: Re: [APPLIED] [PATCH] omapfb: Reorder Register_framebuffer call
Date: Tue, 22 Sep 2009 16:59:41 +0200
Message-ID: <4de7f8a60909220759g63b592eek85a2bca04b264d2e@mail.gmail.com>
References: <1252773249-24444-1-git-send-email-saaguirre@ti.com>
	 <notify-1253583118@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:14412 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828AbZIVO7j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 10:59:39 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1225905fge.1
        for <linux-omap@vger.kernel.org>; Tue, 22 Sep 2009 07:59:42 -0700 (PDT)
In-Reply-To: <notify-1253583118@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, Sep 22, 2009 at 3:31 AM, Tony Lindgren <tony@atomide.com> wrote:
> This patch has been applied to the linux-omap
> by youw fwiendly patch wobot.
>
> Branch in linux-omap: omap-fixes
>
> Initial commit ID (Likely to change): 9aef1066fb5ca8506068eaab1c552ecca4c85475
>
> PatchWorks
> http://patchwork.kernel.org/patch/47089/
>

Is it actually safe to do this? The framebuffer can be used directly
after it is registered. In this case it would mean it is used before
it is even fully initialized (set_fb_var(), set_fb_fix(), ... are
being called).

Thanks,
Jan
