From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Date: Tue, 21 Aug 2018 16:26:44 +0200
Message-ID: <20180821162644.5a1d7799@bbrezillon>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
        <20180819184609.6dcdbb9a@bbrezillon>
        <20180821005327.0d312a85@tock>
        <20180821074404.23aaeb6b@bbrezillon>
        <20180821142716.0adcdd56@eos>
        <20180821145725.3b385399@bbrezillon>
        <20180821155706.2adf3b4c@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821155706.2adf3b4c@eos>
Sender: linux-kernel-owner@vger.kernel.org
To: Alban <albeu@free.fr>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 21 Aug 2018 15:57:06 +0200
Alban <albeu@free.fr> wrote:

> 
> That would only be needed if the NVMEM framework would do "forward"
> parsing, creating data structure for each NVMEM cell found under an
> NVMEM provider. However currently it doesn't do that and only goes
> "backward", starting by resolving a phandle pointing to a cell, then
> finding the provider that the cell belongs to.

Yes, I missed that when briefly looking at the code.

> 
> This also has the side effect that nvmem cells defined in DT don't
> appear in sysfs, unlike those defined from board code.

Wow, that's not good. I guess we'll want to make that consistent at
some point.

 
> > > > > Furthermore xlate functions are more about converting
> > > > > from hardware parameters to internal kernel representation than
> > > > > to hide extra DT parsing.        
> > > > 
> > > > Hm, how is that different? ->of_xlate() is just a way for drivers
> > > > to have their own DT representation, which is exactly what we
> > > > want here.      
> > > 
> > > There is a big difference. DT represent the hardware and the
> > > relationship between the devices in an OS independent format. We
> > > don't add extra stuff in there just to map back internal Linux API
> > > details.    
> > 
> > And I'm not talking about adding SW information in the DT, I'm talking
> > about HW specific description. We have the same solution for pinctrl
> > configs (it's HW/driver specific).  
> 
> For pinctrl I do understand, these beast can be very different from SoC
> to SoC, having a single biding for all doesn't make much sense.
> 
> However here we are talking about a simple linear storage, nothing
> special at all. I could see the need for an xlate to for example
> support a device with several partitions, but not to just allow each
> driver to have slightly incompatible bindings.

Maybe, but I guess that's up to the subsystem maintainer to decide what
he prefers.
> > 
> > No because partitions defined the old way (as direct subnodes of the
> > MTD node) will be considered as NVMEM cells by the NVMEM framework,
> > and I don't want that.  
> 
> As I explained above that is not currently the case. If the NVMEM,
> framework is ever changed to explicitly parse NVMEM cells in advance
> we can first update the few existing users to add the compatible string.

We're supposed to be backward compatible (compatible with old DTs), so
that's not an option, though we could add a way to check the compat
string afterwards.

> 
> > Plus, I don't want people to start defining their NVMEM cells and
> > forget the compat string (which would work just fine because the
> > NVMEM framework doesn't care).  
> 
> A review of a new DTS should check that it use each binding correctly,
> AFAIK the DT people do that. We could also add a warning when there is
> no compatible string, that would also help pushing people to update
> their DTS.

Yes, but I'd still prefer if we were preventing people from referencing
mtd-nvmem cells if the node does not have an "nvmem-cell" compat.

> 
> > >     
> > > > What forces people to add this compatible in their
> > > > DT? Nothing. I'll tell you what will happen: people will start
> > > > defining their nvmem cells directly under the MTD node because
> > > > that *works*, and even if the binding is not documented and we
> > > > consider it invalid, we'll be stuck supporting it forever.      
> > > 
> > > Do note that undocumented bindings are not allowed. DTS that use
> > > undocumented bindings (normally) just get rejected.    
> > 
> > Except that's just in theory. In practice, if people can do something
> > wrong, they'll complain if you later fix the bug and break their
> > setup. So no, if we go for the "nvmem cells have an 'nvmem-cell'
> > compat", then I'd like the NVMEM framework to enforce that somehow.  
> 
> That should be trivial to implement.

Exactly, and that's why I'm insisting on this point.
