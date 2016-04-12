From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] of: Add generic handling for hardware incomplete fail
 state
Date: Tue, 12 Apr 2016 15:27:32 -0700
Message-ID: <20160412222732.GL5995@atomide.com>
References: <1460486275-12256-1-git-send-email-tony@atomide.com>
 <570D56FE.2070408@gmail.com>
 <20160412203431.GU5995@atomide.com>
 <570D6B7A.3050203@gmail.com>
 <CAL_Jsq+B67np4qcwJ2m1yz3TOzYgb7ZQtRH+vhANm9Snw5QnzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+B67np4qcwJ2m1yz3TOzYgb7ZQtRH+vhANm9Snw5QnzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Tom Rini <trini@konsulko.com>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh+dt@kernel.org> [160412 15:22]:
> On Tue, Apr 12, 2016 at 4:41 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> >>> Status of "fail-sss" is meant to indicate an error was detected in
> >>> the device, and that the error might (or might not) be repairable.
> >>>
> >>> So the difference I see is state vs hardware description.
> 
> The question to ask is are we indicating the "operational status of a
> device"? If yes, that is the definition of status and using it would
> be appropriate.
> 
> IMO, I think we are.
> 
> >> OK thanks for the clarification. I don't see why "fail-hw-incomplete"
> >> could not be set dynamically during the probe in some cases based
> >> on the SoC revision detection for example. So from that point of
> >> view using status with the "fail-sss" logic would make more sense.
> >
> > If the probe detects that the device should only be power managed
> > based on the SoC revision, then it would simply be one more
> > test added at the top of probe.  The patch would change from:
> >
> >    if (of_device_is_incomplete(pdev->dev.of_node)) {
> >
> > to:
> >
> >    if (of_device_is_incomplete(pdev->dev.of_node) || socrev == XXX) {
> 
> I think Tony meant the bootloader or platform code would do this and
> tweak the DT. We don't have much of a standard API for revision
> checking, so drivers don't check SoC revisions generally.

Yes bootloader may need to set these based on the SoC revision.
There are already many boards with multiple SoC variants
available. Would like to hear Tom's comments on this one as
well from the u-boot point of view.

Regards,

Tony
