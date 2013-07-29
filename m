From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/2] arm: omap: remove *.auto* from device names given
 in usb_bind_phy
Date: Mon, 29 Jul 2013 20:59:26 +0530
Message-ID: <51F68A56.8060805@ti.com>
References: <1374829418-27503-1-git-send-email-kishon@ti.com>
 <1374829418-27503-3-git-send-email-kishon@ti.com>
 <20130729150638.GD3063@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130729150638.GD3063@radagast>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: linux@arm.linux.org.uk, tony@atomide.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, eballetbo@gmail.com, javier@dowhile0.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 29 July 2013 08:36 PM, Felipe Balbi wrote:
> Hi,
> =

> On Fri, Jul 26, 2013 at 02:33:38PM +0530, Kishon Vijay Abraham I wrote:
>> Previously MUSB wrapper (OMAP) device used PLATFORM_DEVID_AUTO while cre=
ating
>> MUSB core device. So in usb_bind_phy (binds the controller with the PHY)=
, the
>> device name of the controller had *.auto* in it. Since with using
>> PLATFORM_DEVID_AUTO, there is no way to know the exact device name in ad=
vance,
>> the data given in usb_bind_phy became obsolete and usb_get_phy was faili=
ng.
>> So MUSB wrapper was modified not to use PLATFORM_DEVID_AUTO. Correspondi=
ng
>> change is done in board file here.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
>>  arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
>>  arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
>>  arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
>>  arch/arm/mach-omap2/board-igep0020.c         |    2 +-
>>  arch/arm/mach-omap2/board-ldp.c              |    2 +-
>>  arch/arm/mach-omap2/board-omap3beagle.c      |    2 +-
>>  arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
>>  arch/arm/mach-omap2/board-omap3logic.c       |    2 +-
>>  arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
>>  arch/arm/mach-omap2/board-omap3stalker.c     |    2 +-
>>  arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
>>  arch/arm/mach-omap2/board-overo.c            |    2 +-
>>  arch/arm/mach-omap2/board-rm680.c            |    2 +-
>>  arch/arm/mach-omap2/board-rx51.c             |    2 +-
>>  arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
>>  16 files changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/b=
oard-2430sdp.c
>> index 244d8a5..17bb076 100644
>> --- a/arch/arm/mach-omap2/board-2430sdp.c
>> +++ b/arch/arm/mach-omap2/board-2430sdp.c
>> @@ -233,7 +233,7 @@ static void __init omap_2430sdp_init(void)
>>  	omap_hsmmc_init(mmc);
>>  =

>>  	omap_mux_init_signal("usb0hs_stp", OMAP_PULL_ENA | OMAP_PULL_UP);
>> -	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
>> +	usb_bind_phy("musb-hdrc.0", 0, "twl4030_usb");
> =

> how about moving usb_bind_phy() calls to omap2430.c ?
> =

> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index f44e8b5..b6abc1a 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -544,6 +544,9 @@ static int omap2430_probe(struct platform_device *pde=
v)
>  =

>  		pdata->board_data	=3D data;
>  		pdata->config		=3D config;
> +	} else {
> +		/* bind the PHY */
> +		usb_bind_phy(dev_name(&musb->dev), 0, "twl4030_usb");

This looks like a hack IMHO to workaround the usb phy library. otherwise it=
 is
similar to get_phy_by_name.
>  	}
>  =

>  	if (pdata->has_mailbox) {
> =

> The only problem is if some board comes with a PHY other than
> twl4030_usb, but in that case we can add a separate compatible flag and
> treat it properly. We only need to bind the phy in non-DT case anyway,

right.
> so that's temporary. It might be better than to reintroduce the IDR in
> musb_core.c.

that=92s needed for generic phy framework anyway :-s

Thanks
Kishon
