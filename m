From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/6] Revert "ARM: OMAP2+: Provide alias to USB PHY
 clock"
Date: Tue, 22 Oct 2013 08:17:00 -0700
Message-ID: <20131022151659.GO15154@atomide.com>
References: <1381226799-29158-1-git-send-email-rogerq@ti.com>
 <1381226799-29158-6-git-send-email-rogerq@ti.com>
 <52550180.1000506@ti.com>
 <20131009151522.GA8313@atomide.com>
 <5256703F.1070806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5256703F.1070806@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: bcousson@baylibre.com, balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [131010 02:23]:
> On 10/09/2013 06:15 PM, Tony Lindgren wrote:
> > * Roger Quadros <rogerq@ti.com> [131009 00:19]:
> >> Hi Tony,
> >>
> >> On 10/08/2013 01:06 PM, Roger Quadros wrote:
> >>> This reverts commit 741532c4a995be11815cb72d4d7a48f442a22fea.
> >>>
> >>> The proper clock reference is provided in device tree so we
> >>> no longer need this.
> >>
> >> Could you please Ack this one? I think it is best if it goes through Benoit's tree.
> > 
> > I could queue this into my board removal series that will be
> > based on Benoit's branch if that works for you. And this
> > also seems to depend on the omap-for-v3.13/quirk branch
> > that moves all the legacy pdata handling into pdata-quirks.c.
> 
> OK Tony. Thanks.

Actually, can you please update this patch against branch
omap-for-v3.13/board-removal-take2 and check the
omap5_uevm_legacy_init() part as well?

Tony
