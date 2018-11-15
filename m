From: Tony Lindgren <tony@atomide.com>
Subject: Regression in next with spi return from transfer_one()
Date: Thu, 15 Nov 2018 13:14:51 -0800
Message-ID: <20181115211451.GH53235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lubomir Rintel <lkundrak@v3.sk>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Commit 810923f3bf06 ("spi: Deal with slaves that return from
transfer_one() unfinished") causes a regression at least on
droid 4 with SPI PMIC and regulators on the PMIC. During boot
the device just hangs there waiting for rootfs to appear on
MMC. Reverting 810923f3bf06 makes things work again.

Any ideas why this might be?

Regards,

Tony
