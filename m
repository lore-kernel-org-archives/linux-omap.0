From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: Update Phy supplies
Date: Wed, 16 Sep 2015 16:57:28 -0700
Message-ID: <20150916235727.GC4215@atomide.com>
References: <1441308226-26690-1-git-send-email-nm@ti.com>
 <55F98690.6070601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55F98690.6070601-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [150916 08:15]:
> Hi Tony,
> 
> On 09/03/2015 02:23 PM, Nishanth Menon wrote:
> > Originally, all the SoC PHY rails were supplied by LDO3. However, as a
> > result of characterization, it was determined that this posed a risk in
> > extreme load  conditions. Hence the PHY rails are split between two
> > different LDOs. Update the related node as a result
> > 
> > LDO3/VDDA_1V8_PHYA supplies vdda_usb1, vdda_usb2, vdda_sata, vdda_usb3
> > LDO4/VDDA_1V8_PHYB supplies vdda_pcie1, vdda_pcie0, vdda_hdmi, vdda_pcie
> > 
> > NOTE: We break compatibility with pre-production boards with this change
> > since, the PMIC LDO4 is disabled at OTP level.
> > 
> > The new configuration is the plan of record and all pre-production
> > boards are supposed to be replaced with the latest boards matching the
> > mentioned configuration.
> > 
> > Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> > ---
> 
> Gentle ping. Some very few 10 something boards have been created and
> stopped production till the latest modifications were done (PMIC USB
> interrupt, LDO4 etc) - and all of those boards are now getting
> scrapped.. If there are any (as per tracking information, there should
> not be any), TI should be contacted to have them replaced.

Sounds OK to me as they are TI internal protos.
 
> Is it possible for us to consider this patch in 4.3 cycle - given that
> we are this close, might have been great to see 4.3 vanilla function on
> the production platform.

Applying into omap-for-v4.3/fixes thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
