From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: add DT nodes for ov2659 sensor
Date: Mon, 16 Mar 2015 19:23:44 -0700
Message-ID: <20150317022344.GB31346@atomide.com>
References: <1426203501-32115-1-git-send-email-prabhakar.csengg@gmail.com>
 <20150316221740.GQ12397@atomide.com>
 <CA+V-a8uWqjze32ukOGonQAACByPmW6WDbpFrA9EFipnNJeD58A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+V-a8uWqjze32ukOGonQAACByPmW6WDbpFrA9EFipnNJeD58A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, LAK <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Lad, Prabhakar <prabhakar.csengg@gmail.com> [150316 18:20]:
> Hi Tony,
> 
> On Mon, Mar 16, 2015 at 10:17 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Lad Prabhakar <prabhakar.csengg@gmail.com> [150312 16:38]:
> >> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> >>
> >> this patch does the following:
> >> 1: adds DT node for fixed oscillator.
> >> 2: adds DT node entries for ov2659 sensor
> >> 3: adds remote-endpoint entry for VPFE.
> >>
> >> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> >
> > Applying into omap-for-v4.1/dt thanks.
> >
> I would like to get this one in via media tree to avoid dependency
> as I am still waiting for Acks from DT maintainers for the sensor
> driver.

OK dropping it.
 
> If I can get your Ack on this I'll queue it up along with sensor
> driver via media tree.

Sorry the chances are too big for pointless merge conflicts with
these files with constant patching going on.

Please just resend this patch alone again to me later on once the
driver changes are merged into Linux next and on their way to the
mainline kernel.

Regards,

Tony
