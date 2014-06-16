From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am43x-epos-evm: Add Missing cpsw-phy-sel for
 am43x-epos-evm
Date: Mon, 16 Jun 2014 05:03:10 -0700
Message-ID: <20140616120310.GI17845@atomide.com>
References: <1402035454-25676-1-git-send-email-george.cherian@ti.com>
 <53916556.10608@ti.com>
 <53918F75.1050000@ti.com>
 <5391DE01.2080600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5391DE01.2080600-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [140606 08:30]:
> On 06/06/2014 04:52 AM, George Cherian wrote:
> > On 6/6/2014 12:23 PM, Nishanth Menon wrote:
> >> On 06/06/2014 01:17 AM, George Cherian wrote:
> >>> AM437x EPOS evm use external clock for RMII interface.
> >>> Enable the same in DT.
> >>>
> >>> Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
> >>> Reported-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> >>> ---
> >>>   arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
> >>>   1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
> >>> index 19f1f7e..90098f9 100644
> >>> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
> >>> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
> >>> @@ -319,6 +319,10 @@
> >>>   	phy-mode = "rmii";
> >>>   };
> >>>   
> >>> +&phy_sel {
> >>> +	rmii-clock-ext;
> >>> +};
> >>> +
> >>>   &i2c0 {
> >>>   	status = "okay";
> >>>   	pinctrl-names = "default";
> >>>
> >> Where does this apply on?
> >> With linux-next next-20140506 tag, and this patch applied, I get the
> > Is'nt next-20140506 a month old.
> 
> Uggh.. yeah - 1AM+migraine is not a good combination to try to do
> testing. :( Apologies on the noise
> 
> 
> > I tried the patch on next-20140604.
> 
> Tested on next-20140606 - applies clean, builds and works :)
> 
> am43xx-epos:  Boot PASS: http://slexy.org/raw/s2fT6zs45y
> 
> Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Applying into omap-for-v3.16/fixes thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
