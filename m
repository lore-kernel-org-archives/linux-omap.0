From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Power management behavior of linux-2.6.14-omap2-v5
Date: Tue, 20 May 2008 06:48:00 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429045C506B@dlee13.ent.ti.com>
References: <c656a4d20805182349h66efb783pc3b3658a1935ba5@mail.gmail.com> <3B6D69C3A9EBCA4BA5DA60D913027429045555F3@dlee13.ent.ti.com> <c656a4d20805192146m5bece6e6lffd3a65a7c414a55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:57543 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbYETLsK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 07:48:10 -0400
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20805192146m5bece6e6lffd3a65a7c414a55@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>, linux-omap@vger.kernel.org

> On Mon, May 19, 2008 at 6:48 PM, Woodruff, Richard <r-woodruff2@ti.com>
> wrote:
> > You are just talking about your logo disappearing (usually tux)?
> 
> No not just tux.
> 
> If i run tslib (ts_test) and suspend& resume the
> board then also the same behavior is happening.
> ie. The normal ts_test screen disappears and
> blue screen comes.
> 
> Also if i do a cat of some image to /dev/fb0 then
> the same image disappears after a
> suspend&resume cycle, whether this behavior also
> linked to console layer?
> 
> Or a higher level mechanism (like X server)
> is required to save and restore the framebuffer
> after a PM cycle or it's the fb driver's responsibility
> to do so?

The only effect I recall not being restored was TUX.  The virtual console did save its current screen as part of its shut down then restore on restart.

Other UI things when VC was not driving the screen worked.  You may have more issues with which ever driver you are using.

Regards,
Richard W.

