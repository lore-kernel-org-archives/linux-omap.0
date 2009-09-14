From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] omapfb: Reorder Register_framebuffer call
Date: Mon, 14 Sep 2009 18:22:32 +0300
Message-ID: <94a0d4530909140822h59937984hae3dea70d52fff18@mail.gmail.com>
References: <1252773249-24444-1-git-send-email-saaguirre@ti.com>
	 <A24693684029E5489D1D202277BE89444C327E31@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:30649 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386AbZINPWa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Sep 2009 11:22:30 -0400
Received: by fg-out-1718.google.com with SMTP id 22so988816fge.1
        for <linux-omap@vger.kernel.org>; Mon, 14 Sep 2009 08:22:33 -0700 (PDT)
In-Reply-To: <A24693684029E5489D1D202277BE89444C327E31@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: Imre Deak <imre.deak@nokia.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Sep 14, 2009 at 5:43 PM, Aguirre Rodriguez, Sergio Alberto
<saaguirre@ti.com> wrote:
> Hi,
>
> This patch has been lying around for some weeks now, with just responses about successful testing (detailed in the description).
>
> Is there anything holding it for merge? Or should I try sending it to other ML?
>
> BTW, It applies cleanly on mainline aswell.

Try running 'get_maintainer' script to find other people that have
worked on this code:
Trilok Soni <soni.trilok@gmail.com>
Andrew Morton <akpm@linux-foundation.org>
Tony Lindgren <tony@atomide.com>
Russell King <rmk+kernel@arm.linux.org.uk>
Krzysztof Helt <krzysztof.h1@wp.pl>

My feedback is: please mention in the message how the bug can be triggered.

And watch your uppercases:
omapfb: reorder register_framebuffer call

-- 
Felipe Contreras
