From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Configure omap5 AESS
Date: Tue, 14 Jan 2020 08:46:13 -0800
Message-ID: <20200114164613.GR5885@atomide.com>
References: <20200114150937.18304-1-tony@atomide.com>
 <52905C15-A2D1-4372-9781-D602D0B274B6@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52905C15-A2D1-4372-9781-D602D0B274B6-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [200114 16:38]:
> Hi Tony,
> 
> > Am 14.01.2020 um 16:09 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> > 
> > We are missing AESS for omap5. Looks like it's similar to what we have
> > for omap4, and this gets ti-sysc interconnect target module driver to
> > detect it properly.
> > 
> > Note that we currently have no child device driver available for it.
> 
> What I have is a non-working and no more compiling driver originally written by
> Peter Ujfalusi and reworked by Andrej Utkin. We did have it almost running on
> v4.14 or so except problems with firmware versions and headers...
> 
> There we used classical hwmods and I could revert them now to try your new patches.
> Unfortunately, I could only compile-test your two patches but nothing with AESS.
> 
> We had tried to follow kernel API changes in the sound subsystem but today it is
> not even compiling any more :(
> 
> So getting a working device driver is an even bigger task than SGX was.

OK. Well hopefully that's at least a little bit easier now though.

> > Cc: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> > Cc: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> > Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > ---
> > 
> > Note that this depends on "[PATCH] clk: ti: omap5: Add missing AESS clock".
> > 
> > arch/arm/boot/dts/omap5-l4-abe.dtsi | 16 ++++++++++++++--
> > 1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap5-l4-abe.dtsi b/arch/arm/boot/dts/omap5-l4-abe.dtsi
> > --- a/arch/arm/boot/dts/omap5-l4-abe.dtsi
> > +++ b/arch/arm/boot/dts/omap5-l4-abe.dtsi
> > @@ -426,8 +426,20 @@ target-module@c0000 {			/* 0x401c0000, ap 30 1e.0 */
> > 		};
> > 
> > 		target-module@f1000 {			/* 0x401f1000, ap 32 20.0 */
> 
> Here its may be good to have an "aess" label.

Care to clarify what you have in mind? The module is generic, aess
device will be the child node.

How about just a comment for aess?

Regards,

Tony
