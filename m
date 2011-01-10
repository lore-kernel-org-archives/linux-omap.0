From: Marc Zyngier <maz@misterjones.org>
Subject: Re: [PATCH 2/3] omap3: igep3: Fix IGEP module second MMC channel power
	supply.
Date: Mon, 10 Jan 2011 15:18:10 +0100
Message-ID: <2a90cfc8fdf83d0adb67c16d2be97784@localhost>
References: <1294665974-10590-1-git-send-email-eballetbo@gmail.com>
	<1294665974-10590-3-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1294665974-10590-3-git-send-email-eballetbo@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


On Mon, 10 Jan 2011 14:26:13 +0100, Enric Balletbo i Serra
<eballetbo@gmail.com> wrote:
> The second MMC channel (used by the WLAN/BT module) is not linked to
> power regulator. This causes the WLAN/BT module to fail being detected
if
> CONFIG_REGULATOR_DUMMY is not set.
> 
> This patch adds the two regulators that actually feed the WLAN/BT module
> (1v8 from the TWL4030 VIO LDO, and a fixed 3v3). With that patch, the
> second channel is properly detected.
> 
> Also change vmmc1 to use symbolic names instead of direct device
> reference.
> 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>

Acked-by: Marc Zyngier <maz@misterjones.org>
-- 
Who you jivin' with that Cosmik Debris?
