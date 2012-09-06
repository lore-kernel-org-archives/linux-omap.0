From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v7 1/7] drivers: usb: phy: add a new driver for omap usb2
 phy
Date: Thu, 6 Sep 2012 13:03:02 +0000
Message-ID: <201209061303.02454.arnd@arndb.de>
References: <1344258480-4304-1-git-send-email-kishon@ti.com>
 <1344258480-4304-2-git-send-email-kishon@ti.com>
 <CAAe_U6KBNZpT03xATmPTNTgxm5hj+wJdsShdnm08EmF4Q=hTCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAAe_U6KBNZpT03xATmPTNTgxm5hj+wJdsShdnm08EmF4Q=hTCw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 06 September 2012, ABRAHAM, KISHON VIJAY wrote:
> > diff --git a/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt b/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
> > index d2fe064..bb0c7f4 100644
> > --- a/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
> > +++ b/Documentation/devicetree/bindings/bus/omap-ocp2scp.txt
> > @@ -8,3 +8,6 @@ properties:
> >
> >  Sub-nodes:
> >  All the devices connected to ocp2scp are described using sub-node to ocp2scp
> > +- usb2phy :
> > +   The binding details of usb2phy can be found in:
> > +   Documentation/devicetree/bindings/usb/omap-usb.txt
> 
> The above two lines should be added in omap-ocp2scp.txt (this file was
> added as part of omap: add ocp2scp as a bus driver and is in
> linux-next). However this file is still not in Felipe's xceiv branch.
> So I'm not sure how I can get this patch merged in Felipe's tree
> without conflict.
> 

There are three possible ways to do that:

* Not add that text. Is is actually required? The ocp2scp bus driver 
doesn't actually care what is connected to it, does it?

* Ask Felipe to merge the drivers/ocp2scp branch from arm-soc into
his branch, then apply your patch on top. The branch is scheduled
for merging in 3.7 and is stable, so there is no harm merging it
into his tree, as long as Olof and I are aware of this.

* Split out this change and apply the patch to add this documentation
change on top of the drivers/ocp2scp branch in the arm-soc tree.
There is no strict dependency between this change and the others
you want to merge, so it does not matter which tree it is merged through.

	Arnd
