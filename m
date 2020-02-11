From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: dts: am437x-gp/epos-evm: drop unused panel
 timings
Date: Tue, 11 Feb 2020 19:22:14 +0200
Message-ID: <d7e51d54-ffb3-2792-8bdb-73fc627fd675@ti.com>
References: <20191211165331.GC43123@atomide.com>
 <45dae8f7-2f5e-6948-5a05-dc8a09ace1fa@ti.com>
 <20191212203550.GB4892@pendragon.ideasonboard.com>
 <add3d8af-6977-68e6-fb77-2fa748c4714a@ti.com>
 <b39e52f1-3e73-5f26-6206-0956cf482631@ti.com>
 <20200211110712.GB28355@pendragon.ideasonboard.com>
 <3b4d10c6-7cb2-af53-3a39-31eef441bfdd@ti.com>
 <98da360f-880b-af56-b285-4d9b39f8a342@wizzup.org>
 <20200211160524.GE64767@atomide.com>
 <87b1111e-af06-1e2a-8baa-c3f9a15f1874@ti.com>
 <20200211162719.GF64767@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200211162719.GF64767-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Merlijn Wajer <merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/02/2020 18:27, Tony Lindgren wrote:

>> We are still missing DSI command mode support, and moving it to the common DRM model.
> 
> Nope, DSI command mode support has been working just fine for
> a while now :) And Sebastian has a WIP git tree of the common DRM

Indeed... It had been going on for so long that now my mind is stuck at dsi-command-mode-not-yet-in =).

> model changes for it. I don't think we have devices with DSI
> command mode working for omapfb but not for omapdrm?

Yes, I think that is true.

> What got missed for v5.6-rc1 is the LCD backlight patch though,
> I think the only issue there is default-brightness vs more common
> default-brightness-value usage if you have any input to that.

At least for some boards a power supply is needed, and I think there was no conclusion on who should 
enable that. It didn't seem to fit in anywhere...

But need to check on the latest status. I wasn't following that work closely, as JJ was working on it.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
