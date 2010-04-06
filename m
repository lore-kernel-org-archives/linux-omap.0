From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: USB on omap2430
Date: Tue, 6 Apr 2010 14:05:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032241880F@dbde02.ent.ti.com>
References: <70376CA23424B34D86F1C7DE6B997343017F5D5BE1@VSHINMSMBX01.vshodc.lntinfotech.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3@dbde02.ent.ti.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE3@VSHINMSMBX01.vshodc.lntinfotech.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE7@VSHINMSMBX01.vshodc.lntinfotech.com>
 <20100329204159.GC31402@nokia.com>
 <70376CA23424B34D86F1C7DE6B997343023C4E201B@VSHINMSMBX01.vshodc.lntinfotech.com>
 <3bd3371a3ea8aa8fb53b62dbe99169e0@secure211.sgcpanel.com>
 <70376CA23424B34D86F1C7DE6B9973430254343A36@VSHINMSMBX01.vshodc.lntinfotech.com>
 <20100405164125.GA17388@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48926 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab0DFIf1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 04:35:27 -0400
In-Reply-To: <20100405164125.GA17388@gandalf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>, Viral Mehta <Viral.Mehta@lntinfotech.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe Balbi wrote:
> On Mon, Apr 05, 2010 at 07:32:06PM +0530, Viral Mehta wrote:
> > >> After adding the above code, isp1301's probe is called but that fails
> > >> before it does otg_set_transceiver()
> > >> And I am debugging further on that path.
> > 
> > >ok, cool. When you get that done, please send a cleaned up
> > >diff with your signed-off-by line so it can be integrated.
> > 
> > I continued debugging further. It fails during USB initialisation.
> > More specifically, in omap_otg_init() function in arch/arm/plat-omap/usb.c
> > It gives a crash dump on the first line itself
> > syscon = omap_readl(OTG_SYSCON_1) & 0xffff;
> 
> without the crash itself, it's pretty difficult to help. It could even
> be just a missing clk_enable(). Although I believe that code shouldn't
> be running for 2430, only for 2420.
> 
> Can you try the patch below:
> 
> > Apart from that, can I submit the 3 patches that we discussed earlier ?
> > 
> (http://www.mail-archive.com/linux-omap@vger.kernel.org/msg25932.html)
> > These will not make FS USB functional on OMAP2430 but these changes are anyway necessary.
> 
> clean those patches first. And I'd like someone else with the 2430sdp
> board to test it before I add my SOB.

I dug up a 2430 board (VG5.0.1 - a later version than Viral's) , but
these patches don't work for me.

I also found the board schematics. Looks like there are different
versions of the 2430 SDP, each with different layouts and components
for the USBtransceivers. I believe there's no one-size fits all.

I think the best bet is to go with Viral's patch series, as long as they
work for him - don't think anyone else is using the 2430SDP these days.

We can fix up as and when required.

- Anand
