From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] dt-bindings: gpu: pvrsgx: add initial bindings
Date: Tue, 22 Oct 2019 08:02:02 -0700
Message-ID: <20191022150202.GJ5610@atomide.com>
References: <cover.1571424390.git.hns@goldelico.com>
 <f0fb68dc7bc027e5e911721852f6bc6fa2d77a63.1571424390.git.hns@goldelico.com>
 <CAL_Jsq+obsTSU3iP1wm_3-FsAJ4Mxiz0NbMY1_h5NeFn67Sj+A@mail.gmail.com>
 <CEA29A3B-4116-4FE3-8E18-0C97353688DC@goldelico.com>
 <20191021172557.GB5610@atomide.com>
 <C6CD5A50-7F0A-4F56-ABB9-CAEDF7E47A5D@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C6CD5A50-7F0A-4F56-ABB9-CAEDF7E47A5D@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, dri-devel <dri-devel@lists.freedesktop.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [191021 18:08]:
> 
> > Am 21.10.2019 um 19:25 schrieb Tony Lindgren <tony@atomide.com>:
> > 
> > * H. Nikolaus Schaller <hns@goldelico.com> [191021 15:46]:
> >>> Am 21.10.2019 um 17:07 schrieb Rob Herring <robh+dt@kernel.org>:
> >>> On Fri, Oct 18, 2019 at 1:46 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >>>> +Optional properties:
> >>>> +- timer:       the timer to be used by the driver.
> >>> 
> >>> Needs a better description and vendor prefix at least.
> >> 
> >> I am not yet sure if it is vendor specific or if all
> >> SGX implementations need some timer.
> >> 
> >>> 
> >>> Why is this needed rather than using the OS's timers?
> >> 
> >> Because nobody understands the current (out of tree and
> >> planned for staging) driver well enough what the timer
> >> is doing. It is currently hard coded that some omap refer
> >> to timer7 and others use timer11.
> > 
> > Just configure it in the driver based on the compatible
> > value to keep it out of the dts. It's best to stick to
> > standard bindings.
> 
> IMHO leads to ugly code... Since the timer is not part of
> the SGX IPR module but one of the OMAP timers it is sort
> of hardware connection that can be chosen a little arbitrarily.
> 
> This is the main reason why I think adding it to a device tree
> source so that a board that really requires to use a timer
> for a different purpose, can reassign it. This is not possible
> if we hard-code that into the driver by scanning for
> compatible. In that case the driver must check board compatible
> names...
> 
> But if we gain a better understanding of its role in the driver
> (does it really need a dedicated timer and for what and which
> properties the timer must have) we can probably replace it.

Well how about just leave out the timer from the binding
for now, and just carry a patch for it until it is known
if/why it's really needed?

If it's needed, yeah I agree a timer property should be
used.

> >>>> +- img,cores:   number of cores. Defaults to <1>.
> >>> 
> >>> Not discoverable?
> >> 
> >> Not sure if it is. This is probably available in undocumented
> >> registers of the sgx.
> > 
> > This too, and whatever non-standrd other properities
> > you might have.
> 
> Here it is a feature of the SGX IPR of the SoC, i.e.
> describes that the hardware has one or two cores.

Here you can have a standard dts binding by putting this
into driver struct of_device_id match .data. Then when
somebody figures out how to read that from the hardware,
it can be just dropped.

Regards,

Tony
