From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: ARM: OMAP2+: Grab reference to device nodes where needed
Date: Tue, 28 Feb 2017 09:26:37 -0800
Message-ID: <20170228172637.GA13455@roeck-us.net>
References: <1486853948-20978-1-git-send-email-linux@roeck-us.net>
 <20170227233405.GA16546@roeck-us.net>
 <20170228162315.GS21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170228162315.GS21809@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh@kernel.org>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Qi Hou <qi.hou@windriver.com>, linux-omap@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 28, 2017 at 08:23:16AM -0800, Tony Lindgren wrote:
> * Guenter Roeck <linux@roeck-us.net> [170227 15:36]:
> > ping ... this problem is now seen in mainline.
> 
> Oops sorry I had accidentally tagged this with "next" instead of
> "fixes".
> 
> Looking at the patch though, can't we make of_node_get/put local to
> omap3xxx_hwmod_is_hs_ip_block_usable()?
> 
Not really.

Strictly speaking the patch fixes two problems:
1) of_find_node_by_name() gets a reference on "bus", thus of_node_put()
   is necessary to release it. This is the change in omap3xxx_hwmod_init().
2) of_find_node_by_name() drops a reference to the passed device node,
   thus it is necessary to call of_node_get(bus) in
   omap3xxx_hwmod_is_hs_ip_block_usable().

I should have stated that more clearly in the description.

We could ignore 1) to get rid of the warning, but that would leave us with
a dangling reference to the bus node. I could also improve the description,
or split the patch in two. Let me know what you prefer.

Another possible change would be to use of_get_child_by_name() instead of
of_find_node_by_name(). That would, however, only search immediate children
of the 'ocp' node, not all nodes. I  think that is what is actually intended
here, but I am not entirely sure. Thoughts ?

Either case, turns out I'll have to re-submit the patch because, as mentioned
above, of_find_node_by_name() gets a reference to the device node it returns,
so a put on that node is necessary in omap3xxx_hwmod_is_hs_ip_block_usable().

Guenter
