From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V4 0/5] ARM: OMAP: HOST: TLL driver implementation
Date: Sat, 22 Sep 2012 00:07:20 +0200
Message-ID: <20120921220720.GY28670@sortiz-mobl>
References: <CAP05o4+rdtsXKV9U0MrLyu7Ce8zJ4uUEcZOJ5yfarpF42gSogA@mail.gmail.com>
 <20120723140830.GA8155@arwen.pp.htv.fi>
 <CAP05o4JDa5WH14SLkFswEqx6jWyr94VfxtEBsbmaiQ+5kT_abQ@mail.gmail.com>
 <CAP05o4+dOH6tDXU4bs5ubh8rqjpjumZjfu4zM1G6MupE0T4fhQ@mail.gmail.com>
 <CAP05o4LRS=svfTsNV45CcToKT7XcZ+et3+fmYzJ7xMLhidtCOA@mail.gmail.com>
 <20120813140928.GH14781@arwen.pp.htv.fi>
 <CAP05o4K1J_ZzUT7PtKb6ZK-DzxJogLZ+hFUv65qKE2zFFNFbGg@mail.gmail.com>
 <CAP05o4K5f5xUdfT2V7m+Jp9D74btPMz1bB6eYCnkBBpsZqP9tA@mail.gmail.com>
 <CAP05o4KaQFvOBwQoVy_-Ve=T_fwDw-SEyO8DCtfuX-r5ryiOeA@mail.gmail.com>
 <alpine.DEB.2.00.1209192030270.5264@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209192030270.5264-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux USB Devel <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Wed, Sep 19, 2012 at 08:39:40PM +0000, Paul Walmsley wrote:
> 
> Hi Samuel,
> 
> I've queued patch 1 of this series for 3.7, which should go upstream via 
> the OMAP -> arm-soc path.  Also asked Keshava to re-send patch 5 to me 
> once patches 2-4 have been merged.
> 
> It's up to you how to handle patches 2-4.  The series is a good step 
> forward for us in terms of cleanup.  But what is probably worthwhile at 
> some point is for that USB TLL "phy" code (added in patch 2) to be moved 
> into some place like drivers/usb/phy, since it's not MFD-related.
That would be ideal, yes. I kept patches 2-4 as they're alreeady going in the
right direction (I dropped patches 1 and 5).

Thanks for the heads up.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
