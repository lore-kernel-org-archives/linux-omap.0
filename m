From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Fri, 14 May 2010 11:16:16 +0100
Message-ID: <20100514101615.GF10339@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk> <20100505150209.GC2606@n2100.arm.linux.org.uk> <20100513174023.GB13001@n2100.arm.linux.org.uk> <20100513211951.GH3428@atomide.com> <20100513215825.GC13001@n2100.arm.linux.org.uk> <20100513220139.GO3428@atomide.com> <20100513221229.GD13001@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02C54F0247@dbde02.ent.ti.com> <AANLkTikZvfvjY9e2QNWRwVcJcTvn58Ly_DgzrcXKu2iJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35725 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758956Ab0ENKQg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 06:16:36 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikZvfvjY9e2QNWRwVcJcTvn58Ly_DgzrcXKu2iJ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Fri, May 14, 2010 at 01:11:43PM +0300, Grazvydas Ignotas wrote:
> It seems you are using DSS2/CONFIG_FB_OMAP2, looks like this patch is
> for DSS1/CONFIG_FB_OMAP.
> 
> DSS2 does have a problem on linux-next after 'ARM: Prohibit ioremap()
> on kernel managed RAM'

I'm going to drop that patch out - but that's not to say it won't return
(it will.)

> because it also uses reserve_bootmem() in
> drivers/video/omap2/vram.c and later ioremap on RAM. Perhaps LMB can
> be used to fix that too?

WTF is reserve_bootmem doing in a driver?
