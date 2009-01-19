From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 14:27:34 +0200
Message-ID: <1232368054.6481.110.camel@tubuntu>
References: <1232360583.6481.92.camel@tubuntu>
	 <20090119110116.GA15007@n2100.arm.linux.org.uk>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48882 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbZASM2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 07:28:20 -0500
In-Reply-To: <20090119110116.GA15007@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hi,

On Mon, 2009-01-19 at 11:01 +0000, ext Russell King - ARM Linux wrote:
> On Mon, Jan 19, 2009 at 12:23:03PM +0200, Tomi Valkeinen wrote:
> > Hi,
> > 
> > Running with latest linux-omap kernel on OMAP3 SDP board, I have problem
> > with iounmap(). It looks like iounmap() does not properly free large
> > areas. Below is a test which fails for me in 6-7 loops.
> > 
> > OMAP spesific ioremap code doesn't do much, so I think it's somewhere in
> > generic ARM code. I looked at the ioremap code and for larger areas the
> > code uses area sections, and I believe the bug is somewhere there. 
> 
> In unmap_area_sections(), try changing:
> 
>         unsigned long addr = virt, end = virt + (size & ~SZ_1M);
> 
> to
> 
>         unsigned long addr = virt, end = virt + (size & ~(SZ_1M - 1));

This didn't help. I Added two debug prints, not sure if it means
anything but the size on the second unmap is not the same as in the
previous ones.

remap_area_sections(virt=d2000000, size=1000000, end=d3000000, pfn=70000)
unmap_area_sections(virt=d2000000, size=1000000, end=d3000000)
ioremapped to d2000000
unmap_area_sections(virt=d2000000, size=1001000, end=d3000000)

 Tomi

