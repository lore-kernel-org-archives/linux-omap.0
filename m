From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP2+: Grab reference to device nodes where needed
Date: Tue, 28 Feb 2017 09:52:47 -0800
Message-ID: <20170228175246.GE20572@atomide.com>
References: <1486853948-20978-1-git-send-email-linux@roeck-us.net>
 <20170227233405.GA16546@roeck-us.net>
 <20170228162315.GS21809@atomide.com>
 <20170228172637.GA13455@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170228172637.GA13455@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paul Walmsley <paul@pwsan.com>, Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Qi Hou <qi.hou@windriver.com>, linux-omap@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [170228 09:28]:
> On Tue, Feb 28, 2017 at 08:23:16AM -0800, Tony Lindgren wrote:
> > * Guenter Roeck <linux@roeck-us.net> [170227 15:36]:
> > > ping ... this problem is now seen in mainline.
> > 
> > Oops sorry I had accidentally tagged this with "next" instead of
> > "fixes".
> > 
> > Looking at the patch though, can't we make of_node_get/put local to
> > omap3xxx_hwmod_is_hs_ip_block_usable()?
> > 
> Not really.
> 
> Strictly speaking the patch fixes two problems:
> 1) of_find_node_by_name() gets a reference on "bus", thus of_node_put()
>    is necessary to release it. This is the change in omap3xxx_hwmod_init().
> 2) of_find_node_by_name() drops a reference to the passed device node,
>    thus it is necessary to call of_node_get(bus) in
>    omap3xxx_hwmod_is_hs_ip_block_usable().
> 
> I should have stated that more clearly in the description.

OK

> We could ignore 1) to get rid of the warning, but that would leave us with
> a dangling reference to the bus node. I could also improve the description,
> or split the patch in two. Let me know what you prefer.

Once patch is just fine with me.

> Another possible change would be to use of_get_child_by_name() instead of
> of_find_node_by_name(). That would, however, only search immediate children
> of the 'ocp' node, not all nodes. I  think that is what is actually intended
> here, but I am not entirely sure. Thoughts ?

Yes that would be better.

> Either case, turns out I'll have to re-submit the patch because, as mentioned
> above, of_find_node_by_name() gets a reference to the device node it returns,
> so a put on that node is necessary in omap3xxx_hwmod_is_hs_ip_block_usable().

OK

Thanks,

Tony
