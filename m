From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: TWL6040 fails to initialize
Date: Tue, 25 Feb 2014 11:30:11 +0100
Message-ID: <530C70B3.4010103@epfl.ch>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Peter,

I got recently to work on the DT support for an OMAP4 board [1], and I
encountered some troubles with the probe of the twl6040 audio codec on
3.14-rc kernels. On 3.13, things were working correctly. So I somewhat
managed to bisect this down to [c7f9129 mfd: twl6040: reg_defaults
support for regmap]. But looking more into it, things are less obvious.

When the init fails, here is what happens:

[    2.455749] twl6040 0-004b: Looking up vio-supply from device tree
[    2.456359] twl6040 0-004b: Looking up v2v1-supply from device tree
[    2.457061] twl6040 0-004b: Failed to set masks in 0x4: -121
[    2.463043] twl6040: probe of 0-004b failed with error -121

logically resulting in

[    2.770050] omap-abe-twl6040 sound.4: ASoC: CODEC twl6040-codec not
registered
[    2.777770] omap-abe-twl6040 sound.4: snd_soc_register_card() failed:
-517
[    2.785095] platform sound.4: Driver omap-abe-twl6040 requests probe
deferral

We get a EREMOTEIO when calling regmap_add_irq_chip() from
twl6040_probe(). regmap_add_irq_chip() will try to perform non-cached
i2c writes, where the omap-i2c driver get a NACK from the remote chip.
Strange enough, the non-cached read just before (i.e.
twl6040_reg_read(twl6040, TWL6040_REG_ASICREV)) succeeds.

After some fiddling around, I could find that delaying the call to
regmap_add_irq_chip(), let's say by msleep(1), will "solve" the problem.

As the TRM for TWL6040 is not public, and I cannot physically access the
i2c bus on the board, I ran out of hypothesis. I first suspected a
concurrent access from the McPDM bus, but the mcpdm driver does not seem
to perform command (write) access.

As the regulators are enabled just before, could it be the twl6040 IP
which is not yet initialized, and NACK'ing writes but not reads? The
commit c7f9129 changed the regmap logic by reducing the number of
non-cached accesses, and thus changed the access timings, so it may have
trigged this behaviour. But this is pure supposition, as I cannot hack
the i2c bus :( And adding any kind of tracing before
regmap_add_irq_chip() usually delays enough to make the probe succeeds.

Any ideas?

Regards,
Florian

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/110801
