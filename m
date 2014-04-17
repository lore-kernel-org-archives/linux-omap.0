From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Do not reset gpio5
Date: Thu, 17 Apr 2014 09:34:07 -0700
Message-ID: <20140417163407.GB23385@atomide.com>
References: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com>
 <53319A7D.1060904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53319A7D.1060904-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [140325 08:05]:
> On 03/21/2014 12:20 AM, Lokesh Vutla wrote:
> > From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> > 
> > Do not reset GPIO5 at boot-up because GPIO5_7 is used
> > on AM437x GP-EVM to control VTT regulators on DDR3.
> > Without this some GP-EVM boards will fail to boot because
> > of DDR3 corruption.

How funny :)

Ideally we would be able to specify which GPIO pins should
maintain their state during the boot.

AFAIK, this patch currently means that the kernel has no idea
what state the whole GPIO bank is in. At minimum we should
parse the GPIO bank state so the kernel knows it and then it
should be safe to set the no reset flag.

So for the workaround, can you guys please try to see test
if the old mux trick in the bootloader works to mux the pin
into something PIN_INPUT_PULLUP | MUX_MODE7? Or a PULLDOWN
depending on the direction naturally. That would allow
leaving out the GPIO completely from this.

Regards,

Tony
 
> > Reported-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> > Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> > ---
> > This is applied on top of current linux-next.
> > git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > 
> >  arch/arm/boot/dts/am437x-gp-evm.dts |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
> > index df8798e..a055f7f 100644
> > --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> > +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> > @@ -117,6 +117,11 @@
> >  	status = "okay";
> >  };
> >  
> > +&gpio5 {
> > +	status = "okay";
> > +	ti,no-reset-on-init;
> > +};
> > +
> >  &mmc1 {
> >  	status = "okay";
> >  	vmmc-supply = <&vmmcsd_fixed>;
> > 
> 
> 
> Tony,
> any chance of having this in 3.15 cycle?
> 
> as of today's linux-next tag, the only platform I have that does not
> boot is due to the lack of this patch.
> 
> 
> next-20140325-omap2plus_defconfig
>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s20o6CfGL8
>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2Ogu1zPtD
>  3: am3517-evm:  Boot PASS: http://slexy.org/raw/s2m2WhHYO8
>  4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2jOybaVno
>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21tt52N4b
>  6: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s21eDQmFWJ
>  7: beagleboard:  Boot PASS: http://slexy.org/raw/s2q7vzrZHb
>  8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2HCAJVz0H
>  9: beaglebone:  Boot PASS: http://slexy.org/raw/s2NioACYsM
> 10: craneboard:  Boot PASS: http://slexy.org/raw/s2s7jyo52c
> 11:       dra7:  Boot PASS: http://slexy.org/raw/s2OQ1BMerx
> 12:        ldp:  Boot PASS: http://slexy.org/raw/s2cWgQrdjb
> 13: pandaboard-es:  Boot PASS: http://slexy.org/raw/s2lOaznVLO
> 14:    sdp2430:  Boot PASS: http://slexy.org/raw/s21RCJlUDU
> 15:    sdp3430:  Boot PASS: http://slexy.org/raw/s2181J9eWO
> 16:    sdp4430:  Boot PASS: http://slexy.org/raw/s20UumAiXK
> 17: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s21ypXvTNc
> TOTAL = 17 boards, Booted Boards = 16, No Boot boards = 1
> 
> -- 
> Regards,
> Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
