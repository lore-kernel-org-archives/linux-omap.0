From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] ARM: omapfb: Add early framebuffer memory allocator
Date: Wed, 17 Feb 2016 09:31:31 +0200
Message-ID: <56C421D3.5080101@gmail.com>
References: <52A062A0.3070005@ti.com>
 <1388013159-3036-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201601011301.27415@pali> <568A5970.2000201@ti.com>
 <568A6DD1.5050700@gmail.com> <5693F5B7.8040608@ti.com>
 <56BEDA57.4030300@gmail.com> <56C32966.9020105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56C32966.9020105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

Hi,

On 16.02.2016 15:51, Tomi Valkeinen wrote:
>
> Does it work for you? I haven't used DT reserved-memory, do you have an
> example .dts change?
>

Yes, it does work, I tested it on n900:

diff --git a/arch/arm/boot/dts/omap3-n900.dts 
b/arch/arm/boot/dts/omap3-n900.dts
index 1e94237..863d547 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -59,6 +59,18 @@
                 reg = <0x80000000 0x10000000>; /* 256 MB */
         };

+       reserved-memory {
+               #address-cells = <1>;
+               #size-cells = <1>;
+               ranges;
+
+               omapfb_reserved: omapfb {
+                       size = <0x700000>;
+                       alignment = <0x100000>;
+                       compatible = "ti,omapfb-memsize";
+               };
+       };
+
         gpio_keys {
                 compatible = "gpio-keys";

@@ -1083,6 +1095,8 @@

         vdds_sdi-supply = <&vaux1>;

+       memory-region = <&omapfb_reserved>;
+
         ports {
                 #address-cells = <1>;
                 #size-cells = <0>;

> Now, having to support DT bindings is not any better than supporting
> cmdline options. But with a quick read of reserved-memory.txt I like the
> idea. However we should have "reserved memory for display", not for
> omapfb, so that the same reserved area could be used by omapdrm too.

Sounds reasonable and I don't really care how it is to be called or who 
does the actual reservation, as long as there is some reserved memory we 
can use for omapfb :)

Keep in mind that the changes I did were just a quick-n-dirty hack to 
see if it will work and if you will accept something like that. A better 
approach is maybe to move RESERVEDMEM_OF_DECLARE() and co to display.c 
and pass base and size to whoever needs them (be it omapfb or omapdrm). 
Also, compatible could be called "ti,dss-memsize" or the like, but those 
are cosmetics IMO.

>
> Another thing, with v4.5, omapfb has moved into maintenance mode. I
> don't want to merge new features there. Are you planning to move to
> omapdrm, and if not, why? I'd rather see all this done for omapdrm only.

I don't see a reason to not merge a small change like that in omapfb if 
there is reserved display memory used by omapdrm, but still, I am not 
the maintainer.

Pali already explained the situation with PVR driver we use to boot 
maemo UI. Honestly, I have no idea what it takes to move from omapfb to 
omapdrm. Any hints?

Ivo
