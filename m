From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: USB on omap2430
Date: Mon, 5 Apr 2010 19:41:25 +0300
Message-ID: <20100405164125.GA17388@gandalf>
References: <70376CA23424B34D86F1C7DE6B997343017F5D5BE1@VSHINMSMBX01.vshodc.lntinfotech.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3@dbde02.ent.ti.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE3@VSHINMSMBX01.vshodc.lntinfotech.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE7@VSHINMSMBX01.vshodc.lntinfotech.com>
 <20100329204159.GC31402@nokia.com>
 <70376CA23424B34D86F1C7DE6B997343023C4E201B@VSHINMSMBX01.vshodc.lntinfotech.com>
 <3bd3371a3ea8aa8fb53b62dbe99169e0@secure211.sgcpanel.com>
 <70376CA23424B34D86F1C7DE6B9973430254343A36@VSHINMSMBX01.vshodc.lntinfotech.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57898 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468Ab0DEQkw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Apr 2010 12:40:52 -0400
Content-Disposition: inline
In-Reply-To: <70376CA23424B34D86F1C7DE6B9973430254343A36@VSHINMSMBX01.vshodc.lntinfotech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Viral Mehta <Viral.Mehta@lntinfotech.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, Apr 05, 2010 at 07:32:06PM +0530, Viral Mehta wrote:
> >>  static void __exit isp_exit(void)
> >>  {
> >>
> >>
> >>
> >> After adding the above code, isp1301's probe is called but that fails
> >> before it does otg_set_transceiver()
> >> And I am debugging further on that path.
> 
> >ok, cool. When you get that done, please send a cleaned up
> >diff with your signed-off-by line so it can be integrated.
> 
> I continued debugging further. It fails during USB initialisation.
> More specifically, in omap_otg_init() function in arch/arm/plat-omap/usb.c
> It gives a crash dump on the first line itself
> syscon = omap_readl(OTG_SYSCON_1) & 0xffff;

without the crash itself, it's pretty difficult to help. It could even
be just a missing clk_enable(). Although I believe that code shouldn't
be running for 2430, only for 2420.

Can you try the patch below:

> Apart from that, can I submit the 3 patches that we discussed earlier ?
> (http://www.mail-archive.com/linux-omap@vger.kernel.org/msg25932.html)
> These will not make FS USB functional on OMAP2430 but these changes are anyway necessary.

clean those patches first. And I'd like someone else with the 2430sdp
board to test it before I add my SOB.

-- 
balbi
