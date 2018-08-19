From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Date: Sun, 19 Aug 2018 18:46:09 +0200
Message-ID: <20180819184609.6dcdbb9a@bbrezillon>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180819133106.0420df5f@tock>
Sender: linux-kernel-owner@vger.kernel.org
To: Alban <albeu@free.fr>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.com>, Florian Fainelli <f.fainelli@gmail.com>, Ivan
List-Id: linux-omap@vger.kernel.org

On Sun, 19 Aug 2018 13:31:06 +0200
Alban <albeu@free.fr> wrote:

> On Fri, 17 Aug 2018 18:27:20 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
> > Hi Bartosz,
> > 
> > On Fri, 10 Aug 2018 10:05:03 +0200
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >   
> > > From: Alban Bedel <albeu@free.fr>
> > > 
> > > Allow drivers that use the nvmem API to read data stored on MTD devices.
> > > For this the mtd devices are registered as read-only NVMEM providers.
> > > 
> > > Signed-off-by: Alban Bedel <albeu@free.fr>
> > > [Bartosz:
> > >   - use the managed variant of nvmem_register(),
> > >   - set the nvmem name]
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>    
> > 
> > What happened to the 2 other patches of Alban's series? I'd really
> > like the DT case to be handled/agreed on in the same patchset, but
> > IIRC, Alban and Srinivas disagreed on how this should be represented.
> > I hope this time we'll come to an agreement, because the MTD <-> NVMEM
> > glue has been floating around for quite some time...  
> 
> These other patches were to fix what I consider a fundamental flaw in
> the generic NVMEM bindings, however we couldn't agree on this point.
> Bartosz later contacted me to take over this series and I suggested to
> just change the MTD NVMEM binding to use a compatible string on the
> NVMEM cells as an alternative solution to fix the clash with the old
> style MTD partition.
> 
> However all this has no impact on the code needed to add NVMEM support
> to MTD, so the above patch didn't change at all.

It does have an impact on the supported binding though.
nvmem->dev.of_node is automatically assigned to mtd->dev.of_node, which
means people will be able to define their NVMEM cells directly under
the MTD device and reference them from other nodes (even if it's not
documented), and as you said, it conflict with the old MTD partition
bindings. So we'd better agree on this binding before merging this
patch.

I see several options:

1/ provide a way to tell the NVMEM framework not to use parent->of_node
   even if it's != NULL. This way we really don't support defining
   NVMEM cells in the DT, and also don't support referencing the nvmem
   device using a phandle.

2/ define a new binding where all nvmem-cells are placed in an
   "nvmem" subnode (just like we have this "partitions" subnode for
   partitions), and then add a config->of_node field so that the
   nvmem provider can explicitly specify the DT node representing the
   nvmem device. We'll also need to set this field to ERR_PTR(-ENOENT)
   in case this node does not exist so that the nvmem framework knows
   that it should not assign nvmem->dev.of_node to parent->of_node

3/ only declare partitions as nvmem providers. This would solve the
   problem we have with partitions defined in the DT since
   defining sub-partitions in the DT is not (yet?) supported and
   partition nodes are supposed to be leaf nodes. Still, I'm not a big
   fan of this solution because it will prevent us from supporting
   sub-partitions if we ever want/need to.

4/ Add a ->of_xlate() hook that would be called if present by the
   framework instead of using the default parsing we have right now.

5/ Tell the nvmem framework the name of the subnode containing nvmem
   cell definitions (if NULL that means cells are directly defined
   under the nvmem provider node). We would set it to "nvmem-cells" (or
   whatever you like) for the MTD case.

There are probably other options (some were proposed by Alban and
Srinivas already), but I'd like to get this sorted out before we merge
this patch.

Alban, Srinivas, any opinion?
