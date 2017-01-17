From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: dra7-evm: increase QSPI SPL partition size
Date: Tue, 17 Jan 2017 15:27:44 -0800
Message-ID: <20170117232743.GA7403@atomide.com>
References: <1484311234-21978-1-git-send-email-ravibabu@ti.com>
 <1484311234-21978-2-git-send-email-ravibabu@ti.com>
 <20170113181239.GC2630@atomide.com>
 <6C6B28D4DC342643927BEAFCE8707BF6C0A8C367@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <6C6B28D4DC342643927BEAFCE8707BF6C0A8C367@DBDE04.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "B, Ravi" <ravibabu@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "nsekhar@list.ti.com" <nsekhar@list.ti.com>, "Nori, Sekhar" <nsekhar@ti.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* B, Ravi <ravibabu@ti.com> [170117 00:15]:
> Hi Tony
> 
> >* Ravi Babu <ravibabu@ti.com> [170113 04:41]:
> >> The SPL size for DRA74x platform has increased and is now more than 
> >> 64KB. Increase QSPI SPL partition size to 256KB for DRA74x EVM.
> >> 
> >> QSPI partition numbering changes because of this.
> 
> >And this will break the existing partitions potentially..
> >See what was discussed on the list few days ago in thread "[PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition table".
> 
> >It's best to have these left empty or as they originally were and let u-boot configure the partitions.
> 
> Agree with you. For dra7xx platform the SPL size has been increased to 256KB and hence the existing QSPI SPL partition in kernel (64K size) will break when latest mainline u-boot is used. 
> Here only SPL partition has been changed and other partition & size is NOT changed and kept intact. I feel it will not break the existing partitions for dra7xx platform.

What about the renumbering of partitions in your patch?

Probably just best to make the partition information empty in the
kernel as discussed.

Regards,

Tony
