From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [RFC] omap: mailbox: fix detection for previously supported
 chips
Date: Fri, 24 Sep 2010 09:11:58 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530450EDDEFB@dlee03.ent.ti.com>
References: <1285201299-18306-1-git-send-email-omar.ramirez@ti.com>
	<A24693684029E5489D1D202277BE894472802A7F@dlee02.ent.ti.com>
	<27F9C60D11D683428E133F85D2BB4A530450E3FBEF@dlee03.ent.ti.com>
 <AANLkTikGzx09Zp-oKAYnZOhoZ02iExfZ3d3+byRnJJdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58899 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514Ab0IXOMG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 10:12:06 -0400
In-Reply-To: <AANLkTikGzx09Zp-oKAYnZOhoZ02iExfZ3d3+byRnJJdA@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Aguirre, Sergio" <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Anna, Suman" <s-anna@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe Contreras wrote:
> On Thu, Sep 23, 2010 at 7:11 PM, Ramirez Luna, Omar
> <omar.ramirez@ti.com> wrote: 
>> Code is not the same, it is 2 line which apply for both but couldn't
>> find an easy way of making them share the request for dsp mailbox
>> without changing more code, perhaps a macro to detect if omap2 and
>> then a nested if for the 2420 case, but since HWMOD should handle it
>> better, I left it as is.    
> 
> I sent some patches to migrate to hwmod, at least it was working on
> OMAP3, somebody would need to fill the values for OMAP2. Would you
> like me to rebase and send them again?  
> 

Yes, I just found them, I can take care of the rebase if you don't beat me to it.

Regards,

Omar
