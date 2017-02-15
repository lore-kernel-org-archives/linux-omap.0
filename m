From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Add dra7 iodelay configuration and use it for
 MMC
Date: Wed, 15 Feb 2017 07:50:02 -0800
Message-ID: <20170215155002.GN21809@atomide.com>
References: <20161230183732.5595-1-tony@atomide.com>
 <20161230183732.5595-3-tony@atomide.com>
 <20161230184914.GC3940@atomide.com>
 <20170214185120.GL21809@atomide.com>
 <932aa035-27c9-0bb4-ffe2-81959aea6662@ti.com>
 <58A44B02.10204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <58A44B02.10204-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Gary Bisson <gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [170215 04:36]:
> On Wednesday 15 February 2017 12:27 AM, Nishanth Menon wrote:
> > On 02/14/2017 12:51 PM, Tony Lindgren wrote:
> >> Nishanth,
> >>
> >> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161230 10:50]:
> >>> Add dra7 iodelay configuration and use it for MMC.
> >>
> >> I just noticed that this patch should probably be:
> >>
> >> From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> >>
> >> I think I just added the description to the patch.
> >>
> >> Can you please confirm and reply with your Signed-off-by
> >> if that's the case?
> >>
> > 
> > Though I had introduced the node [
> > http://git.ti.com/ti-linux-kernel/ti-linux-kernel/commit/34661cbccc679bb8d91768bc78495e94e6d40f1f
> > ], the x15 values were first introduced by Kishon.
> > 
> > http://git.ti.com/ti-linux-kernel/ti-linux-kernel/commit/1463b1e8facb7180f5679b373411b3fbeb1608fd
> > 
> > 
> > personally, From or not really does'nt matter as long as we can get the
> > solution in.
> > 
> > So, as long as it helps..
> > Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
...
> I had to remove the iodelay added here based on datasheet (patch [1]).

OK thanks for the info. So we have multiple authors and as Kishon added
the working values I suggest we credit the patch for Kishon.

> I also wanted to confirm if "MODE_SELECT" should be added in pinctrl values
> like [2] for adding manual mode iodelay because that seems to be missing in
> this patch.

Oh OK. If it's needed then yeah let's update it for that too. Can you
please check it? And then send an updated version of this patch with
"From" credited to you? Just update the description to say "Based on
earlier patches in TI Linux kernel tree done by Nishanth Menon and
Kishon Vijay Abraham I".

Regards,

Tony

> [1] ->
> http://git.ti.com/cgit/cgit.cgi/ti-linux-kernel/ti-linux-kernel.git/commit/?h=ti-linux-4.9.y&id=441f799d2d15a1ed2f0a89024bf3f2fd82816dbd
> 
> [2] ->
> http://git.ti.com/cgit/cgit.cgi/ti-linux-kernel/ti-linux-kernel.git/commit/?h=ti-linux-4.9.y&id=decd3b433d6485d9176ce069bd66b109fb82fe07
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
