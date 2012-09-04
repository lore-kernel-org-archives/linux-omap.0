From: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 0/3] gpio-twl4030: add new device tree properties
Date: Tue, 4 Sep 2012 04:51:36 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAA073E@DBDE01.ent.ti.com>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
 <5044BE79.4040100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5044BE79.4040100-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
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
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 03, 2012 at 19:58:09, Cousson, Benoit wrote:
> + Vaibhav for the omap3-evm
> 

Reviewing and testing it now...

Thanks,
Vaibhav


> Hi Florian,
> 
> On 09/03/2012 03:54 PM, Florian Vaussard wrote:
> > A number of platform data are missing when using twl4030/gpio from a
> > device tree.
> 
> Yeah, I know, I was too lazy when I did the DT conversion at that time :-)
> 
> Many thanks for completing the work.
> 
> >  This patchset adds the missing properties, updates
> > existing device trees and updates the documentation of bindings.
> > It mainly enables LEDA and LEDB outputs, as well as pullups /
> > pulldowns on GPIOs.
> > 
> > The 1st patch changes the device driver.
> > The 2nd patch updates the device trees for BeagleBoard and omap3-evm.
> > The 3rd patch updates the documentation of bindings.
> 
> OK, that's a nit, but in general, you'd better introduce the binding
> before using it.
> 
> The binding documentation could/should be updated along with the driver
> change that does introduce the binding. You could just merged patch #1
> and #3.
> 
> > Tested:
> > - Boot tested on Gumstix Overo for "ti,use-leds". Corresponding
> >   patch is not provided, as the device tree is not yet merged.
> >   The support can be found in the git tree [1], branch
> >   omap3-devel-dt-overo.
> > - Device trees for BeagleBoard and omap3-evm were compiled, but not
> >   tested on hardware.
> > 
> > Would someone be willing to test on BeagleBoard / omap3-evm?
> 
> I'll try to do it on Beagle. This is the least I can do since I did not
> do the job myself :-)
> 
> I added vaibhav as well since I do not have any omap3-evm board.
> 
> > 
> > Regards,
> > Florian
> > 
> > [1] https://github.com/vaussard/linux.git (not safe for merge)
> > 
> > 
> > Florian Vaussard (3):
> >   gpio-twl4030: get platform data from device tree
> >   gpio-twl4030: new dt properties for BeagleBoard and omap3-EVM
> 
> Nit #2: the DTS file does not belong to the gpio subsystem. So you
> should prefix them using the *convention* for ARM DTS patches:
> 
> arm/dts: omap3: Add gpio-twl4030 properties for BeagleBoard and omap3-EVM
> 
> Or maybe "ARM: dts: " because it looks like most people are using that
> nowadays.
> 
> The convention for the gpio directory is similar:
> gpio/twl4030: get platform data from device tree
> 
> >   gpio-twl4030: updates the bindings for new dt properties
> > 
> >  .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 ++
> >  arch/arm/boot/dts/omap3-beagle.dts                 |   20 +++++
> >  arch/arm/boot/dts/omap3-evm.dts                    |   13 +++
> >  drivers/gpio/gpio-twl4030.c                        |   86 +++++++++++++------
> >  4 files changed, 98 insertions(+), 27 deletions(-)
> 
> Thanks,
> Benoit
> 
> 
