From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] omap: mailbox: fix detection for previously supported chips
Date: Fri, 24 Sep 2010 12:49:25 +0300
Message-ID: <AANLkTikGzx09Zp-oKAYnZOhoZ02iExfZ3d3+byRnJJdA@mail.gmail.com>
References: <1285201299-18306-1-git-send-email-omar.ramirez@ti.com>
	<A24693684029E5489D1D202277BE894472802A7F@dlee02.ent.ti.com>
	<27F9C60D11D683428E133F85D2BB4A530450E3FBEF@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34388 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab0IXJt0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 05:49:26 -0400
Received: by iwn5 with SMTP id 5so2265813iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 02:49:26 -0700 (PDT)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A530450E3FBEF@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "Aguirre, Sergio" <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Anna, Suman" <s-anna@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Sep 23, 2010 at 7:11 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
> Code is not the same, it is 2 line which apply for both but couldn't find an easy way of making them share the request for dsp mailbox without changing more code, perhaps a macro to detect if omap2 and then a nested if for the 2420 case, but since HWMOD should handle it better, I left it as is.

I sent some patches to migrate to hwmod, at least it was working on
OMAP3, somebody would need to fill the values for OMAP2. Would you
like me to rebase and send them again?

-- 
Felipe Contreras
