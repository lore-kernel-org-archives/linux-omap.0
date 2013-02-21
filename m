From: Wolfgang Denk <wd@denx.de>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 18:37:07 +0100
Message-ID: <20130221173707.76A7D200671@gemini.denx.de>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54992 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab3BURhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 12:37:16 -0500
In-reply-to: <20130221134656.GC17852@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Joel A Fernandes <agnel.joel@gmail.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Dear Russell,

In message <20130221134656.GC17852@n2100.arm.linux.org.uk> you wrote:
>
> > Note that FIT images are relatively old (docs date back to March
> > 2008).  This is more of another effort to try and update what the
> > kernel uses.
> 
> So it's five years old and people haven't been that interested in it so
> far.  That speaks volumes...

Well, your attitude to (not) accept anything like that is well known;
there have been few previews attempts, which have all been rejected in
basicly the same way.

But now the situation has changed - multiplatform support adds a
number of use cases where this feature comes in handy, so it pops up
again.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The aim of science is not to open the door to everlasting wisdom  but
to set a limit on everlasting error.                 - Bertolt Brecht
