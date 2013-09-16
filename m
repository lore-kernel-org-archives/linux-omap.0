From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] drm: omap: Enable DT support for DMM
Date: Mon, 16 Sep 2013 07:56:49 -0400
Message-ID: <CAF6AEGsfeoQ2r1Km_ZeSrwHgBL7UzrhCY0TFzu9VeiWM3WxB0Q@mail.gmail.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
	<1379063679-4869-4-git-send-email-archit@ti.com>
	<CAF6AEGu7eRFhrQZUD-43AOHNQtRWeyxYga1dnir=qUo1mQ9ebA@mail.gmail.com>
	<5236A503.90507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5236A503.90507-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Valkeinen, Tomi" <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 16, 2013 at 2:28 AM, Archit Taneja <archit-l0cyMroinI0@public.gmane.org> wrote:
> On Friday 13 September 2013 07:44 PM, Rob Clark wrote:
>>
>> On Fri, Sep 13, 2013 at 5:14 AM, Archit Taneja <archit-l0cyMroinI0@public.gmane.org> wrote:
>>>
>>> Enable use of DT for DMM/Tiler.
>>>
>>> Originally worked on by Andy Gross.
>>
>>
>> looks good.. but do we want to get information about # of LUT's, etc,
>> from DT?  Or did we decide that we can reliably get this from the hw?
>> I lost track of that discussion (I guess Andy would remember)..
>
>
> I am not aware of the discussion either. But looks like we get the LUT info
> from the HW registers in omap_dmm_probe:

right.. I'm possibly mis-remembering, but I thought I remember Andy
worried that this was not reliable for some reason or another, but I
can't really remember the details.  The issue may have only been
related to a pre-Si simulation environment, so it could be nothing.

I suppose if it becomes an issue in the future we could always add DT
bindings to override what we would read from the hw, so I guess if
this works on all the current devices, maybe it isn't worth worrying
about right now.

BR,
-R

>         hwinfo = readl(omap_dmm->base + DMM_PAT_HWINFO);
>         omap_dmm->num_engines = (hwinfo >> 24) & 0x1F;
>         omap_dmm->num_lut = (hwinfo >> 16) & 0x1F;
>         omap_dmm->container_width = 256;
>         omap_dmm->container_height = 128;
>
>         atomic_set(&omap_dmm->engine_counter, omap_dmm->num_engines);
>
>         /* read out actual LUT width and height */
>         pat_geom = readl(omap_dmm->base + DMM_PAT_GEOMETRY);
>         omap_dmm->lut_width = ((pat_geom >> 16) & 0xF) << 5;
>         omap_dmm->lut_height = ((pat_geom >> 24) & 0xF) << 5;
>
>         /* increment LUT by one if on OMAP5 */
>         /* LUT has twice the height, and is split into a separate container
> */
>         if (omap_dmm->lut_height != omap_dmm->container_height)
>                 omap_dmm->num_lut++;
>
>
> Archit
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
