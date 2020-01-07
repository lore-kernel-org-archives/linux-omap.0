From: Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCHv4 01/14] dt-bindings: remoteproc: Add OMAP
 remoteproc bindings
Date: Tue, 7 Jan 2020 09:48:36 -0600
Message-ID: <CAL_JsqJY8fzQ8=e=RHrtq1huucx6msqXJ+C6EcoaofBqRf9yLQ@mail.gmail.com>
References: <20200102131845.12992-2-t-kristo@ti.com> <20200102132512.13248-1-t-kristo@ti.com>
 <20200103233855.GA19897@bogus> <358abb44-7724-4e25-6a3d-6939ec82386a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <358abb44-7724-4e25-6a3d-6939ec82386a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Suman Anna <s-anna@ti.com>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 7, 2020 at 5:01 AM Tero Kristo <t-kristo@ti.com> wrote:
>
> On 04/01/2020 01:38, Rob Herring wrote:
> > On Thu, Jan 02, 2020 at 03:25:12PM +0200, Tero Kristo wrote:
> >> From: Suman Anna <s-anna@ti.com>
> >>
> >> Add the device tree bindings document for the IPU and DSP
> >> remote processor devices on OMAP4+ SoCs.
> >>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Cc: devicetree@vger.kernel.org
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> [t-kristo@ti.com: converted to schema]
> >> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >> ---
> >> v4: added ti,bootreg-shift and ti,autosuspend-delay properties
> >>
> >>   .../remoteproc/ti,omap-remoteproc.yaml        | 329 ++++++++++++++++++
> >>   1 file changed, 329 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml


> >> +  reg:
> >> +    description: |
> >> +      Address space for any remoteproc memories present on
> >> +      the SoC. Should contain an entry for each value in
> >> +      'reg-names'. These are mandatory for all DSP and IPU
> >> +      processors that have them (OMAP4/OMAP5 DSPs do not have
> >> +      any RAMs)
> >> +
> >> +  reg-names:
> >> +    description: |
> >> +      Required names for each of the address spaces defined in
> >> +      the 'reg' property. Should contain a string from among
> >> +      the following names, each representing the corresponding
> >> +      internal RAM memory region.
> >
> > The schema is more constrained than 'a string from among the following
> > names'. 'l2ram' is the only valid 1st entry for example.
>
> Right, I wasn't able to figure out a way to make the schema more
> flexible, so I will just modify the description above.

The goal is somewhat to not be flexible as we want the possible
combinations defined. If it is a manageable number of combinations,
just list them out under a 'oneOf'.

Not encouraged, but it is possible to define any length and order of
values (note 'items' is not a list here):

items:
  enum: [ ... ]

Rob
