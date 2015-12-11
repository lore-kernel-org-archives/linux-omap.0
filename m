From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v4 01/58] mtd: nand: denali: add missing nand_release()
 call in denali_remove()
Date: Fri, 11 Dec 2015 16:15:35 +0100
Message-ID: <20151211161535.60a96ec2@bbrezillon>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449734442-18672-2-git-send-email-boris.brezillon@free-electrons.com>
 <20151211004008.GQ144338@google.com>
 <20151211145320.1560fac3@bbrezillon> <20151211143947.GL5284@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20151211143947.GL5284@mwanda>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Stefan Agner <stefan@agner.ch>, linux-sunxi@googlegroups.com, linux-mtd@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Jason Cooper <jason@lakedaemon.net>, devel@driverdev.osuosl.org, Jesper Nilsson <jesper.nilsson@axis.com>, linux-samsung-soc@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Marek Vasut <marek.vasut@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Alexander Clouter <alex@digriz.org.uk>, Wan ZongShun <mcuos.com@gmail.com>, Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

Hi Dan,

On Fri, 11 Dec 2015 17:39:47 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Fri, Dec 11, 2015 at 02:53:20PM +0100, Boris Brezillon wrote:
> > Hi Brian,
> > 
> > On Thu, 10 Dec 2015 16:40:08 -0800
> > Brian Norris <computersforpeace@gmail.com> wrote:
> > 
> > > On Thu, Dec 10, 2015 at 08:59:45AM +0100, Boris Brezillon wrote:
> > > > Unregister the NAND device from the NAND subsystem when removing a denali
> > > > NAND controller, otherwise the MTD attached to the NAND device is still
> > > > exposed by the MTD layer, and accesses to this device will likely crash
> > > > the system.
> > > > 
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > Cc: <stable@vger.kernel.org> #3.8+
> > > 
> > > Does this follow these rules, from
> > > Documentation/stable_kernel_rules.txt?
> > > 
> > >  - It must be obviously correct and tested.
> > > 
> > >  - It must fix a real bug that bothers people (not a, "This could be a
> > >    problem..." type thing).
> > 
> > As you wish, I'll remove those Cc and Fixes tags, or just drop the
> > patch if you think it's useless...
> 
> The fixes tag is a separate thing from CCing stable.  It's useful on by
> itself.  I always put the person who wrote the original patch in the To:
> header so they can review and comment if I have made a mistake.

Noted. I added back the Fixes tag and added Dinh Nguyen (the commit
author) in the loop.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
