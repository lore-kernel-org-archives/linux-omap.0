From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH v8 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Fri, 18 Jan 2013 19:12:00 -0300
Message-ID: <CALF0-+V81LXXMGGum45=SvZUN55iNYf3THGcdGFhn85BgEe0Vw@mail.gmail.com>
References: <1355481404-27695-1-git-send-email-zonque@gmail.com>
	<1355481404-27695-6-git-send-email-zonque@gmail.com>
	<CALF0-+UbqFF17X1Ok1s1AGKg6SBmvMc1mvjVuZb=Ej7xo+qcmA@mail.gmail.com>
	<20130114180602.GV14149@atomide.com>
	<CACTFLAMT2-6VRkNSO3OF6X=afTYKRz=JcDkYqqyZ4VNT5xBVkw@mail.gmail.com>
	<20130115180324.GZ14149@atomide.com>
	<CALF0-+WnkH-xH0_SfXU89a7bt+HaAH73a03zBbM=i5ugTEE3ww@mail.gmail.com>
	<20130118211121.GU14149@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:60068 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148Ab3ARWMB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 17:12:01 -0500
Received: by mail-ia0-f174.google.com with SMTP id o25so1867497iad.33
        for <linux-omap@vger.kernel.org>; Fri, 18 Jan 2013 14:12:00 -0800 (PST)
In-Reply-To: <20130118211121.GU14149@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Daniel Mack <zonque@gmail.com>, Paul Walmsley <paul@pwsan.com>, x0148406@ti.com, Enric Balletbo Serra <eballetbo@gmail.com>, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, avinashphilip@ti.com, jon-hunter@ti.com, rob.herring@calxeda.com, Javier Martinez Canillas <martinez.javier@gmail.com>, linux-arm-kernel@lists.infradead.org, jacmet@sunsite.dk, grant.likely@secretlab.ca, linux-omap@vger.kernel.org

On Fri, Jan 18, 2013 at 6:11 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ezequiel Garcia <elezegarcia@gmail.com> [130118 11:43]:
>> Tony,
>>
>> On Tue, Jan 15, 2013 at 3:03 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Daniel Mack <zonque@gmail.com> [130114 15:30]:
>> >> On Jan 15, 2013 2:06 AM, "Tony Lindgren" <tony@atomide.com> wrote:
>> >> >
>> >> > * Ezequiel Garcia <elezegarcia@gmail.com> [121223 13:49]:
>> >> > > On Fri, Dec 14, 2012 at 7:36 AM, Daniel Mack <zonque@gmail.com> wrote:
>> >> > > > +
>> >> > > > +Example for an AM33xx board:
>> >> > > > +
>> >> > > > +       gpmc: gpmc@50000000 {
>> >> > > > +               compatible = "ti,am3352-gpmc";
>> >> > > > +               ti,hwmods = "gpmc";
>> >> > > > +               reg = <0x50000000 0x1000000>;
>> >> > > > +               interrupts = <100>;
>> >> > > > +               gpmc,num-cs = <8>;
>> >> > > > +               gpmc,num-waitpins = <2>;
>> >> > > > +               #address-cells = <2>;
>> >> > > > +               #size-cells = <1>;
>> >> > > > +               ranges = <0 0 0x08000000 0x2000>;       /* CS0: NAND
>> >> */
>> >> > > > +
>> >> > > > +               nand@0,0 {
>> >> > > > +                       reg = <0 0 0>; /* CS0, offset 0 */
>> >> > >
>> >> > > I'm a bit confused by this: what are the other two values in "reg"?
>> >> > > I see you've only added a binding for CS.
>> >> > >
>> >> > > I've extended a bit on your work and added a binding to enable OneNAND
>> >> > > device on my IGEP board.
>> >> > >
>> >> > > I might send some patches in case anyone wants to give it a try.
>> >> >
>> >> > Daniel, should this be updated to just pass the CS?
>> >>
>> >> No, as Rob pointed out earlier in a thread about this topic, the 'ranges'
>> >> feature will help doing the math for the offset calculation eventually, so
>> >> we need to pass all three values.
>> >
>> > OK thanks. Applying this set into omap-for-v3.9/gpmc.
>> >
>> > Also sounds like Ezequiel needs to update his follow up patches accordingly.
>> >
>>
>> The patches for OneNAND that were posted on the ML apply cleanly
>> on top omap-for-v3.9/gpmc.
>>
>> What do you want me to update?
>
> Oh I though you need to update the binding for the reg for your patches
> based on the comments above?
>

Mmm... I believe there isn't anything to update (feel free to correct me).
Actually, if you take a look at my patches you'll see they're almost
identical to Daniel's NAND patches, adapted for OneNAND.

I'll re-send them, to fix a tiny typo in the added Documentation.

Thanks,

-- 
    Ezequiel
