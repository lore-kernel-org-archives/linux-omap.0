From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
Date: Mon, 09 Sep 2013 08:23:50 -0700
Message-ID: <87zjrm81dl.fsf@linaro.org>
References: <1378736961-21005-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1378736961-21005-1-git-send-email-koen@dominion.thruhere.net>
 (Koen Kooi's message of "Mon, 9 Sep 2013 16:29:21 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Koen Kooi <koen@dominion.thruhere.net>, bcousson@baylibre.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Koen Kooi <koen@dominion.thruhere.net> writes:

> The BeagleBone Black is basically a regular BeagleBone with eMMC and HDMI added,
> so create a common dtsi both can use.
>
> IMPORTANT: booting the existing am335x-bone.dts will blow up the HDMI transceiver
> after a dozen boots with an uSD card inserted because LDO will be at 3.3V instead
> of 1.8.
>
> MMC support for AM335x still isn't in, so only the LDO change has been added.
>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> Tested-by: Tom Rini <trini@ti.com>
> Tested-by: Matt Porter <matt.porter@linaro.org>

I guess the subject should've included v5?  Also, if this is to be
stable material, it will likely need rework since I don't think it will
apply cleanly to older trees due to DT churn.

Anyways, for this patch...

Acked-by: Kevin Hilman <khilman@linaro.org>

Even though I've probably already fried my HDMI transciever due to using
the original DTS a lot more than a dozen times.  (and to TI: yes, I'd
accept a new BB black as a sympathy gift.)  ;)

Also, I tested this on both BBW and BBW:

Tested-by: Kevin Hilman <khilman@linaro.org>

Benoit, assuming this looks good to you, can you queue this for v3.12-rc
please?   It applies to Linus' HEAD today (which has most of arm-soc
merged), so it should apply cleanly on top of all your stuff.

Kevin
