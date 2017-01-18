From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: dra7-evm: increase QSPI SPL partition size
Date: Wed, 18 Jan 2017 09:39:25 -0800
Message-ID: <20170118173925.GG7403@atomide.com>
References: <1484311234-21978-1-git-send-email-ravibabu@ti.com>
 <1484311234-21978-2-git-send-email-ravibabu@ti.com>
 <20170113181239.GC2630@atomide.com>
 <6C6B28D4DC342643927BEAFCE8707BF6C0A8C367@DBDE04.ent.ti.com>
 <20170117232743.GA7403@atomide.com>
 <b586537d-49b6-50a6-ae60-11faf25b26f9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <b586537d-49b6-50a6-ae60-11faf25b26f9@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "B, Ravi" <ravibabu@ti.com>
List-Id: linux-omap@vger.kernel.org

* Sekhar Nori <nsekhar@ti.com> [170118 03:59]:
> Hi Tony,
> 
> On Wednesday 18 January 2017 04:57 AM, Tony Lindgren wrote:
> > * B, Ravi <ravibabu@ti.com> [170117 00:15]:
> >> Hi Tony
> >>
> >>> * Ravi Babu <ravibabu@ti.com> [170113 04:41]:
> >>>> The SPL size for DRA74x platform has increased and is now more than 
> >>>> 64KB. Increase QSPI SPL partition size to 256KB for DRA74x EVM.
> >>>>
> >>>> QSPI partition numbering changes because of this.
> >>
> >>> And this will break the existing partitions potentially..
> >>> See what was discussed on the list few days ago in thread "[PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition table".
> >>
> >>> It's best to have these left empty or as they originally were and let u-boot configure the partitions.
> >>
> >> Agree with you. For dra7xx platform the SPL size has been increased to 256KB and hence the existing QSPI SPL partition in kernel (64K size) will break when latest mainline u-boot is used. 
> >> Here only SPL partition has been changed and other partition & size is NOT changed and kept intact. I feel it will not break the existing partitions for dra7xx platform.
> > 
> > What about the renumbering of partitions in your patch?
> 
> Thats true, partitions will get renumbered. But mtd numbering can change
> depending on probe order of devices anyway. So usespace which uses
> hardcoded mtd partition numbers is pretty fragile already, I guess.
> 
> > 
> > Probably just best to make the partition information empty in the
> > kernel as discussed.
> 
> Given that existing dtbs already have the partition information, wont
> this be treated as a regression for someone upgrading to new kernel?

Well these "flag day" type changes are not acceptable because they are
impossible to coordinate. You can't assume people update their bootloader
on regular basis, or update both bootloader and kernel to some specific
versions.

> Going forward, is the preference that new boards shall not have
> partition information in DT?

Yes or else it will have to stay as it was originally set because
of these issues.

Regards,

Tony
