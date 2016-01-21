From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Remove legacy mailbox device
 instantiation
Date: Thu, 21 Jan 2016 13:57:45 -0800
Message-ID: <20160121215744.GQ19432@atomide.com>
References: <1442273833-25013-1-git-send-email-s-anna@ti.com>
 <1442273833-25013-2-git-send-email-s-anna@ti.com>
 <562918D7.6020202@ti.com> <56943936.4020003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56943936.4020003@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [160111 15:23]:
> Hi Tony,
> 
> On 10/22/2015 12:11 PM, Suman Anna wrote:
> > Hi Tony,
> > 
> > On 09/14/2015 06:37 PM, Suman Anna wrote:
> >> The legacy-style mailbox device creation is supported currently
> >> only for OMAP3, as all other SoCs are DT-boot only. Even on this
> >> SoC, there are no client drivers that utilize these mailbox devices.
> >> So, clean up the legacy-style mailbox device instantiation logic.
> >> The mailbox devices are already present and supported for the DT
> >> boot on OMAP3.
> >>
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/devices.c | 28 ----------------------------
> >>  1 file changed, 28 deletions(-)
> >>
> > 
> > Ping, can you pick up this patch for your cleanup branch? FYI, Paul is
> > queueing Patch 2.
> 
> Just checking your staged branches and linux-next, looks like this was
> missed. Let me know if you want me to repost this patch.

OK thanks applying into omap-for-v4.5/fixes.

Tony
