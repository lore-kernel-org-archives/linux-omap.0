From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/9] ARM: at91: add at91sam9g20ek boards dt support
Date: Thu, 12 Apr 2012 13:45:59 +0200
Message-ID: <20120412114559.GM16641@game.jcrosoft.org>
References: <20120411153515.GK16641@game.jcrosoft.org>
 <1334160079-30831-3-git-send-email-plagnioj@jcrosoft.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C7B88@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317C7B88-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org" <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 07:06 Thu 12 Apr     , Mohammed, Afzal wrote:
> + omap ml
> 
> Hi Jean, Andrew, Nicolas,
> 
> On Wed, Apr 11, 2012 at 21:31:13, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > +	ahb {
> > +		apb {
> > +			dbgu: serial@fffff200 {
> > +				status = "okay";
> > +			};
> > +
> > +			usart0: serial@fffb0000 {
> > +				status = "okay";
> > +			};
> > +
> > +			usart1: serial@fffb4000 {
> > +				status = "okay";
> > +			};
> > +
> > +			macb0: ethernet@fffc4000 {
> > +				phy-mode = "rmii";
> > +				status = "okay";
> > +			};
> > +
> > +			usb1: gadget@fffa4000 {
> > +				atmel,vbus-gpio = <&pioC 5 0>;
> > +				status = "okay";
> > +			};
> > +		};
> > +
> > +		nand0: nand@40000000 {
> > +			nand-bus-width = <8>;
> > +			nand-ecc-mode = "soft";
> > +			nand-on-flash-bbt;
> > +			status = "okay";
> 
> I have a few queries about handling static memory controller (SMC) of ATMEL
> 
> 1. How is SMC configured when DT is used ?
> 2. With "d6a0166 atmel/nand: add DT support", ek_add_device_nand() is no more
> present (which was earlier configuring SMC), so is SMC configuration handled
> by Kernel on DT boot or is it done by bootloader when DT ?
> 3. How ek_add_device_dm9000() is going to be achieved with DT ?
> 4. Is there any plan to create a driver out of SMC code & use DT with it ?
> 
> Reason for bringing these queries is that TI OMAP chips have GPMC [1], SMC in ATMEL
> seems somewhat similar and currently GPMC is configured in platform code, &
> we are creating a driver out of that code [2]. There are different views on where
> GPMC driver should go, mfd, misc folders etc, but could not yet get concrete
> suggestions even with a loud cry.
put me in ccc I'll take a look
> 
> If ATMEL is also going driver way, then probably our voice together may be
> heard and hopefully it will expedite the matter.
I'm going to add it too  my idea was to create something similiar as the
pintrl
you register the ddifferent bank supported buy the SoC and then the driver
request the bank for the dev_name

at soc level you will set the default timings and then the drvier may
manipulate them

I already update the API of sam9_smc to abstract the access to the register.

I expect the code for the request to be generic but handling of the timing IP
specific

Evenif the GPMC is smiliar as the SMC I do not expect a generic API to manage
it easly (for the timings).

Best Regrds,
J
