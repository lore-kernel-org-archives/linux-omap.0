From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ARM: dts: omap3-devkit8000: fix NAND memory binding
Date: Tue, 11 Jun 2013 22:54:27 +0100
Message-ID: <20130611215427.F07583E0D8D@localhost>
References: <1369296697-22495-1-git-send-email-florian.vaussard@epfl.ch> <51A8AA6B.6010608@epfl.ch> <51B739DF.6080802@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37641 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048Ab3FKVyc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jun 2013 17:54:32 -0400
Received: by mail-wi0-f169.google.com with SMTP id c10so2924360wiw.4
        for <linux-omap@vger.kernel.org>; Tue, 11 Jun 2013 14:54:31 -0700 (PDT)
In-Reply-To: <51B739DF.6080802@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>florian.vaussard@epfl.ch
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org

On Tue, 11 Jun 2013 16:53:19 +0200, Florian Vaussard <florian.vaussard@epfl.ch> wrote:
> Hello,
> 
> On 05/31/2013 03:49 PM, Florian Vaussard wrote:
> > Hello,
> >
> > Gentle ping. Does someone has any comments on this fix? Can someone
> > tests on the real hardware?
> >
> 
> Nobody has this hardware somewhere in a drawer? :-)

I've just gone ahead and applied it. As you say it's broken anyway, so
if this is also broken, then at least it is /less/ broken. :)

g.

> 
> Regards,
> 
> Florian
> 
> > Regards,
> >
> > Florian
> >
> > On 05/23/2013 10:11 AM, Florian Vaussard wrote:
> >> Commit d36b4cd 'ARM: OMAP2+: Add additional GPMC timing parameters'
> >> updated GPMC binding, but omap3-devkit8000 was not updated accordingly,
> >> resulting in a broken configuration.
> >>
> >> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> >> ---
> >>   arch/arm/boot/dts/omap3-devkit8000.dts |   29
> >> +++++++++++++++--------------
> >>   1 files changed, 15 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts
> >> b/arch/arm/boot/dts/omap3-devkit8000.dts
> >> index 8a5cdcc..e5b35f5 100644
> >> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
> >> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> >> @@ -123,20 +123,21 @@
> >>           reg = <0 0 0>; /* CS0, offset 0 */
> >>           nand-bus-width = <16>;
> >>
> >> -        gpmc,sync-clk = <0>;
> >> -        gpmc,cs-on = <0>;
> >> -        gpmc,cs-rd-off = <44>;
> >> -        gpmc,cs-wr-off = <44>;
> >> -        gpmc,adv-on = <6>;
> >> -        gpmc,adv-rd-off = <34>;
> >> -        gpmc,adv-wr-off = <44>;
> >> -        gpmc,we-off = <40>;
> >> -        gpmc,oe-off = <54>;
> >> -        gpmc,access = <64>;
> >> -        gpmc,rd-cycle = <82>;
> >> -        gpmc,wr-cycle = <82>;
> >> -        gpmc,wr-access = <40>;
> >> -        gpmc,wr-data-mux-bus = <0>;
> >> +        gpmc,device-nand;
> >> +        gpmc,sync-clki-ps = <0>;
> >> +        gpmc,cs-on-ns = <0>;
> >> +        gpmc,cs-rd-off-ns = <44>;
> >> +        gpmc,cs-wr-off-ns = <44>;
> >> +        gpmc,adv-on-ns = <6>;
> >> +        gpmc,adv-rd-off-ns = <34>;
> >> +        gpmc,adv-wr-off-ns = <44>;
> >> +        gpmc,we-off-ns = <40>;
> >> +        gpmc,oe-off-ns = <54>;
> >> +        gpmc,access-ns = <64>;
> >> +        gpmc,rd-cycle-ns = <82>;
> >> +        gpmc,wr-cycle-ns = <82>;
> >> +        gpmc,wr-access-ns = <40>;
> >> +        gpmc,wr-data-mux-bus-ns = <0>;
> >>
> >>           #address-cells = <1>;
> >>           #size-cells = <1>;
> >>
> >
> 
> -- 
> Florian Vaussard
> EPFL - STI - IMT - LSRO1
> MEB330 - Station 9
> 1015 Lausanne / Switzerland
> 
> tel: +41 21 693 78 39
> fax: +41 21 693 78 07
> http://lsro.epfl.ch
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
