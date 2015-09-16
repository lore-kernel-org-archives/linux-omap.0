From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: mysterious crashes on OMAP5 uevm
Date: Wed, 16 Sep 2015 11:07:07 +0100
Message-ID: <20150916100706.GE21098@n2100.arm.linux.org.uk>
References: <CANOLnOODjTaBcL1QzAm7o4YOB=_P-s7JYovu6fhNSqJSV2Bq+Q@mail.gmail.com>
 <20150908210708.GH4215@atomide.com>
 <E0068B56-0DEE-4E2F-94CF-DB104AE16D63@goldelico.com>
 <20150910083026.GA21098@n2100.arm.linux.org.uk>
 <CANOLnOM-PYcAL=f4rgucfdWZ1+U3HkP34bfwrKP4Rob+J6iTfw@mail.gmail.com>
 <20150911140306.GB21098@n2100.arm.linux.org.uk>
 <20150914121248.GD21098@n2100.arm.linux.org.uk>
 <20150914190236.GV4215@atomide.com>
 <4A24D632-D980-4C37-B2C9-88D3E9D429D7@goldelico.com>
 <CANOLnOOgYh9vqU6Bq8VkRQ9Oe64NBkD8115T0iG-R6eoXHOe7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CANOLnOOgYh9vqU6Bq8VkRQ9Oe64NBkD8115T0iG-R6eoXHOe7w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Will Deacon <will.deacon@arm.com>, Marek Belisko <marek@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 15, 2015 at 08:31:44PM +0300, Grazvydas Ignotas wrote:
> On Mon, Sep 14, 2015 at 10:35 PM, Dr. H. Nikolaus Schaller
> <hns@goldelico.com> wrote:
> >
> > Am 14.09.2015 um 21:02 schrieb Tony Lindgren <tony@atomide.com>:
> >
> >> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150914 05:16]:
> >>> On Fri, Sep 11, 2015 at 03:03:07PM +0100, Russell King - ARM Linux wrote:
> >>>>
> >>>> Merely changing __LINUX_ARM_ARCH__ >= 7 to >= 6 should fix the problem,
> >>>> and I doubt there's any ARMv6 non-T2 systems out there that would be
> >>>> affected by clearing the IT state bits.
> >>>
> >>> Please test the following patch:
> >>
> >> While we're waiting for Grazvydas to test.. Looks good to me:
> >>
> >> Acked-by: Tony Lindgren <tony@atomide.com>
> >
> > I have tested on:
> > * GTA04 with DM3730 (OMAP3)
> > * Pyra prototype with OMAP5432
> > No X server crashes seen any more.
> >
> > Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> 
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> on OMAP5 uevm running v4.2 built with omap2plus_defconfig.
> On v4.3-rc1 hsmmc controller probe is deferred for whatever reason and
> never reprobes, so my rootfs is never mounted and I could not test,
> but that looks unrelated.

Thanks.

> I guess it's worth marking this one for stable.

Indeed.

Having looked closer at the ARM ARM, these bits on older CPUs are marked
as UNK/SBZP (unknown, should be zero or preserved).  So it's safe to get
rid of that #if entirely.  Removing that #if won't affect the validity
of your testing as you've only tested on ARMv7 platforms with ARMv6
included in the kernel.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
