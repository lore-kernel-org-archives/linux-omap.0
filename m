From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver
Date: Wed, 20 Feb 2019 13:01:27 -0800
Message-ID: <20190220210127.GU15711@atomide.com>
References: <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
 <20190220.112244.1206973642383679896.davem@davemloft.net>
 <20190220203326.GT15711@atomide.com>
 <20190220.124155.2226787912266109280.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190220.124155.2226787912266109280.davem@davemloft.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Miller <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, grygorii.strashko@ti.com, netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, kishon@ti.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* David Miller <davem@davemloft.net> [190220 20:42]:
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 20 Feb 2019 12:33:26 -0800
> 
> > * David Miller <davem@davemloft.net> [190220 19:23]:
> >> From: Grygorii Strashko <grygorii.strashko@ti.com>
> >> Date: Wed, 20 Feb 2019 17:25:19 +0200
> >> 
> >> > Deprecate cpsw-phy-sel driver as it's been replaced with new
> >> > TI phy-gmii-sel PHY driver.
> >> > 
> >> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >> 
> >> Acked-by: David S. Miller <davem@davemloft.net>
> > 
> > Thanks for the ack, but actually I'd prefer you to pick
> > this patch at some future date. I suggest Grygorii just
> > repost this one after v5.1-rc1.
> 
> It's so much easier if you group this with those DT changes, they
> logically belong together as well and it helps someone reading
> the changes in the tree also if they are side by side.

I agree that a group of patches should go together in
most cases.

> Why don't you want to integrate this with them?

Because the arm-soc tree wants dts changes separately in
general. The dts changes are considered firmware describing
hardware. And it makes it possible to split the arm-soc pile
of patches into multiple pull requests. In theory there
should be no dependency between dts changes and driver
changes, but in reality that's not always the case :)

What I can do is set up a separate branch with just this
patch on top of the dts changes that the arm-soc guys can
then merge towards the end of the merge cycle. If that
works for you, let me know and I'll do it.

Regards,

Tony
