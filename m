From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Fri, 1 Apr 2016 17:17:53 -0700
Message-ID: <20160402001753.GR9329@atomide.com>
References: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com>
 <56EFB794.5010505@ti.com>
 <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
 <56FE407E.9030803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56FE407E.9030803@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, t-kristo@ti.com, jarkko.nikula@bitmer.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160401 02:34]:
> So what shall we do with the OMAP3 McBSP2/3 sidetone? It has been broken in DT
> boot since the first time we booted OMAP3 with DT... Only in legacy mode we
> can have properly working ST.

Grr.

> I have the second level of patches based on this set (I think I need to resend
> this series since I might have changed it, can not recall) for both arch/arm
> and ASoC to have working ST in legacy and DT boot. We will no longer have
> warning regarding to broken hwmod data in DT boot.
> But all is based on the assumption that we agree at some point that the ST
> block is part of the McBSP module ;)

The sidetone module is a separate target from the McBSP on the interconnect
but there are also direct lines between sidetone and McBSP devices :)
Here's what I'm seeing looking at the AP table on dm3730 hardware.

McBSP target module:
0x49022000, ap 5 06.0, McBSP2
0x49024000, ap 7 08.0, McBSP3

Sidetone target modules:
0x49028000, ap 39 0a.0, mcbsp2_sidetone
0x4902a000, ap 41 12.0, mcbsp3_sidetone

And that seems to match TRM "21.6.4 SIDETONE Register Description",
"Table 2-5. L4-Peripheral Memory Space Mapping", and "Table 9-114. Region
Allocation for L4-Per Interconnect".

> If I need to write separate driver for the McBSP module's ST block, it would
> mean some sort of API between the McBSP and ST driver. This is not straight
> forward since there are registers both in McBSP block and ST block that needs
> to be configured in specific order -> simple enable_st() would not work
> (probably enable_st_stage1(), enable_st_stage2()) and callbacks from McBSP to
> ST, ST to McBSP also going to be needed. As far as I can see it is going to be
> a huge mess.

The McBSP and sidetone don't have parent child relationship at the
interconnect level. So I think the best option would be to have the McBSP
driver implement mcbsp_sidetone_register/unregister() etc functions. That
can then set up the necessary callbacks. Then the sidetone driver can call
them on probe/exit and set up the necessary callbacks and whatever might
be needed.

If they are currently handled in a single driver, you you need to
pm_runtime_get both modules. So having two separate drivers might make
things a lot simpler.

If you don't treat the McBSP and sidetone as separate modules, things can
easily fail. For example, doing a read-back to flush of posted write to
sidetone registers flushes nothing for McBSP and the other way around.

> Other option would be to deprecate the ST support as such, but that would
> leave the n900 guys in trouble as they need ST to be functional...

That does not sound like a nice option at all :(

Regards,

Tony
