From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Date: Tue, 21 Aug 2018 14:57:25 +0200
Message-ID: <20180821145725.3b385399@bbrezillon>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
        <20180819184609.6dcdbb9a@bbrezillon>
        <20180821005327.0d312a85@tock>
        <20180821074404.23aaeb6b@bbrezillon>
        <20180821142716.0adcdd56@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821142716.0adcdd56@eos>
Sender: linux-kernel-owner@vger.kernel.org
To: Alban <albeu@free.fr>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 21 Aug 2018 14:27:16 +0200
Alban <albeu@free.fr> wrote:

> On Tue, 21 Aug 2018 07:44:04 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
> > On Tue, 21 Aug 2018 00:53:27 +0200
> > Alban <albeu@free.fr> wrote:
> >   
> > > On Sun, 19 Aug 2018 18:46:09 +0200
> > > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > >     
> > > > On Sun, 19 Aug 2018 13:31:06 +0200
> > > > Alban <albeu@free.fr> wrote:
> > > >       
> > > > > On Fri, 17 Aug 2018 18:27:20 +0200
> > > > > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > > >         
> > > > > > Hi Bartosz,
> > > > > > 
> > > > > > On Fri, 10 Aug 2018 10:05:03 +0200
> > > > > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > > > >           
> > > > > > > From: Alban Bedel <albeu@free.fr>
> > > > > > > 
> > > > > > > Allow drivers that use the nvmem API to read data stored on
> > > > > > > MTD devices. For this the mtd devices are registered as
> > > > > > > read-only NVMEM providers.
> > > > > > > 
> > > > > > > Signed-off-by: Alban Bedel <albeu@free.fr>
> > > > > > > [Bartosz:
> > > > > > >   - use the managed variant of nvmem_register(),
> > > > > > >   - set the nvmem name]
> > > > > > > Signed-off-by: Bartosz Golaszewski
> > > > > > > <bgolaszewski@baylibre.com>            
> > > > > > 
> > > > > > What happened to the 2 other patches of Alban's series? I'd
> > > > > > really like the DT case to be handled/agreed on in the same
> > > > > > patchset, but IIRC, Alban and Srinivas disagreed on how this
> > > > > > should be represented. I hope this time we'll come to an
> > > > > > agreement, because the MTD <-> NVMEM glue has been floating
> > > > > > around for quite some time...          
> > > > > 
> > > > > These other patches were to fix what I consider a fundamental
> > > > > flaw in the generic NVMEM bindings, however we couldn't agree
> > > > > on this point. Bartosz later contacted me to take over this
> > > > > series and I suggested to just change the MTD NVMEM binding to
> > > > > use a compatible string on the NVMEM cells as an alternative
> > > > > solution to fix the clash with the old style MTD partition.
> > > > > 
> > > > > However all this has no impact on the code needed to add NVMEM
> > > > > support to MTD, so the above patch didn't change at all.        
> > > > 
> > > > It does have an impact on the supported binding though.
> > > > nvmem->dev.of_node is automatically assigned to mtd->dev.of_node,
> > > > which means people will be able to define their NVMEM cells
> > > > directly under the MTD device and reference them from other nodes
> > > > (even if it's not documented), and as you said, it conflict with
> > > > the old MTD partition bindings. So we'd better agree on this
> > > > binding before merging this patch.      
> > > 
> > > Unless the nvmem cell node has a compatible string, then it won't be
> > > considered as a partition by the MTD code. That is were the clash
> > > is, both bindings allow free named child nodes without a compatible
> > > string.    
> > 
> > Except the current nvmem cells parsing code does not enforce that, and
> > existing DTs rely on this behavior, so we're screwed. Or are you
> > suggesting to add a new "bool check_cells_compat;" field to
> > nvmem_config?  
> 
> There is no nvmem cell parsing at the moment. The DT lookup just
> resolve the phandle to the cell node, take the parent node and search
> for the nvmem provider that has this OF node. So extending it in case
> the node has a *new* compatible string would not break users of the old
> binding, none of them has a compatible string.

But we want to enforce the compat check on MTD devices, otherwise old
MTD partitions (those defined under the MTD node) will be considered as
NVMEM cells by the NVMEM framework. Hence the bool check_cells_compat
field.

> 
> > >     
> > > > I see several options:
> > > > 
> > > > 1/ provide a way to tell the NVMEM framework not to use
> > > > parent->of_node even if it's != NULL. This way we really don't
> > > > support defining NVMEM cells in the DT, and also don't support
> > > > referencing the nvmem device using a phandle.      
> > > 
> > > I really don't get what the point of this would be. Make the whole
> > > API useless?    
> > 
> > No, just allow Bartosz to get his changes merged without waiting for
> > you and Srinivas to agree on how to handle the new binding. As I said
> > earlier, this mtd <-> nvmem stuff has been around for quite some time,
> > and instead of trying to find an approach that makes everyone happy,
> > you decided to let the patchset die.  
> 
> As long as that wouldn't prevent using DT in the future I'm fine with
> it.
> 
> > >     
> > > > 2/ define a new binding where all nvmem-cells are placed in an
> > > >    "nvmem" subnode (just like we have this "partitions" subnode
> > > > for partitions), and then add a config->of_node field so that the
> > > >    nvmem provider can explicitly specify the DT node representing
> > > > the nvmem device. We'll also need to set this field to
> > > > ERR_PTR(-ENOENT) in case this node does not exist so that the
> > > > nvmem framework knows that it should not assign
> > > > nvmem->dev.of_node to parent->of_node      
> > > 
> > > This is not good. First the NVMEM device is only a virtual concept
> > > of the Linux kernel, it has no place in the DT.    
> > 
> > nvmem-cells is a virtual concept too, still, you define them in the
> > DT.  
> 
> To be honest I also think that naming this concept "nvmem" in the DT was
> a bad idea. Perhaps something like "driver-data" or "data-cell" would
> have been better as that would make it clear what this is about, nvmem
> is just the Linux implementation of this concept.

I'm fine using a different name.

> 
> > > Secondly the NVMEM
> > > provider (here the MTD device) then has to manually parse its DT
> > > node to find this subnode, pass it to the NVMEM framework to later
> > > again resolve it back to the MTD device.    
> > 
> > We don't resolve it back to the MTD device, because the MTD device is
> > just the parent of the nvmem device.
> >  
> > > Not very complex but still a lot of
> > > useless code, just registering the MTD device is a lot simpler and
> > > much more inline with most other kernel API that register a
> > > "service" available from a device.    
> > 
> > I'm not a big fan of this option either, but I thought I had to
> > propose it.
> >   
> > >     
> > > > 3/ only declare partitions as nvmem providers. This would solve
> > > > the problem we have with partitions defined in the DT since
> > > >    defining sub-partitions in the DT is not (yet?) supported and
> > > >    partition nodes are supposed to be leaf nodes. Still, I'm not
> > > > a big fan of this solution because it will prevent us from
> > > > supporting sub-partitions if we ever want/need to.      
> > > 
> > > That sound like a poor workaround.    
> > 
> > Yes, that's a workaround. And the reason I propose it, is, again,
> > because I don't want to block Bartosz.
> >   
> > > Remember that this problem could
> > > appear with any device that has a binding that use child nodes.    
> > 
> > I'm talking about partitions, and you're talking about mtd devices.
> > Right now partitions don't have subnodes, and if we define that
> > partition subnodes should describe nvmem-cells, then it becomes part
> > of the official binding. So, no, the problem you mention does not
> > (yet) exist.  
> 
> That would add another binding that allow free named child nodes
> without compatible string although experience has repeatedly shown that
> this was a bad idea.

Yes, I agree. Just thought it was important to have this solution in
the list, even if it's just to reject it.

> 
> > >     
> > > > 4/ Add a ->of_xlate() hook that would be called if present by the
> > > >    framework instead of using the default parsing we have right
> > > > now.      
> > > 
> > > That is a bit cleaner, but I don't think it would be worse the
> > > complexity.    
> > 
> > But it's way more flexible than putting everything in the nvmem
> > framework. BTW, did you notice that nvmem-cells parsing does not work
> > with flashes bigger than 4GB, because the framework assumes
> > #address-cells and #size-cells are always 1. That's probably something
> > we'll have to fix for the MTD case.  
> 
> Yes, however that's just an implementation limitation which is trivial
> to solve.

Agree. I was just pointing it in case you hadn't noticed.

> 
> > > Furthermore xlate functions are more about converting
> > > from hardware parameters to internal kernel representation than to
> > > hide extra DT parsing.    
> > 
> > Hm, how is that different? ->of_xlate() is just a way for drivers to
> > have their own DT representation, which is exactly what we want here.  
> 
> There is a big difference. DT represent the hardware and the
> relationship between the devices in an OS independent format. We don't
> add extra stuff in there just to map back internal Linux API details.

And I'm not talking about adding SW information in the DT, I'm talking
about HW specific description. We have the same solution for pinctrl
configs (it's HW/driver specific).

> 
> > >     
> > > > 5/ Tell the nvmem framework the name of the subnode containing
> > > > nvmem cell definitions (if NULL that means cells are directly
> > > > defined under the nvmem provider node). We would set it to
> > > > "nvmem-cells" (or whatever you like) for the MTD case.      
> > > 
> > > If so please match on compatible and not on the node name.    
> > 
> > If you like.
> >   
> > > 
> > > 6/ Extend the current NVMEM cell lookup to check if the parent node
> > > of the cell has a compatible string set to "nvmem-cells". If it
> > > doesn't it mean we have the current binding and this node is the
> > > NVMEM device. If it does the device node is just the next parent.
> > > This is trivial to implement (literally 2 lines of code) and cover
> > > all the cases currently known.    
> > 
> > Except Srinivas was not happy with this solution, and this stalled the
> > discussion. I'm trying to find other options and you keep rejecting
> > all of them to come back to this one.  
> 
> Well, I think this is the best solution :/
> 
> > > 
> > > 7/ Just add a compatible string to the nvmem cell. No code change is
> > > needed,    
> > 
> > That's not true!!!  
> 
> What is not true in this statement? The current nvmem lookup don't care
> about compatible strings, so the cell lookup would just works fine. The
> MTD partition parser won't consider them as a partition because of the
> compatible string. Problem solved!

No because partitions defined the old way (as direct subnodes of the MTD
node) will be considered as NVMEM cells by the NVMEM framework, and I
don't want that. Plus, I don't want people to start defining their
NVMEM cells and forget the compat string (which would work just fine
because the NVMEM framework doesn't care).

> 
> > What forces people to add this compatible in their
> > DT? Nothing. I'll tell you what will happen: people will start
> > defining their nvmem cells directly under the MTD node because that
> > *works*, and even if the binding is not documented and we consider it
> > invalid, we'll be stuck supporting it forever.  
> 
> Do note that undocumented bindings are not allowed. DTS that use
> undocumented bindings (normally) just get rejected.

Except that's just in theory. In practice, if people can do something
wrong, they'll complain if you later fix the bug and break their setup.
So no, if we go for the "nvmem cells have an 'nvmem-cell' compat", then
I'd like the NVMEM framework to enforce that somehow.
