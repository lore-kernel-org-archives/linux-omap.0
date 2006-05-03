From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH 0/3] aic23 sound driver fixes
Date: Wed, 03 May 2006 22:33:21 +0300
Message-ID: <44590581.6070108@cc.jyu.fi>
References: <4457C35D.4020700@cc.jyu.fi>
	<fd1e34b0605030420g68f908f7y447d6a4ed2001fc0@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000804010101070305030602"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <fd1e34b0605030420g68f908f7y447d6a4ed2001fc0@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: James Selvam <james.iisc@gmail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000804010101070305030602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

James Selvam wrote:

> Hi Mika/All,
>
> I am working on OMAP1510 Innovator (kernel 2.6.16.13+omap1). I applied
> the patches sent here, but the second hunk containing the change of
> function calls to "aic23_write_value" were not defined so I changed
> them back to "tlv320aic23_write_value". But the platform related patch
> was applied in toto.

Yes, the patch-set was meant for the linux-omap git head as the
drivers/i2c/chips/tlv320aic23.c used by the aic23 ALSA and OSS drivers
has changed in git repository after the 2.6.16 omap kernel version.

But if you are using 2.6.16 then you should just take the 3/3 of
patchset. From 1/3 and 2/3 patches you may consider for taking the
KConfig changes by hand as
the I2C, I2C-OMAP and tlv320aic23 i2c drivers must always be selected if
AIC23 alsa or oss driver is selected.
 

> The kernel then recognised the AIC23 codec at bootup (which it was not
> doing before). Also the I2C has set the MCBSP clocks 1 and 3. But ALSA
> did throw up an error:
>
> Clock enabled to MCBSP1 & 3
> tlv320aic23 powering up
> tlv320aic23_init_power() done
> TLV320AIC23 I2C version 1.8 (10-Feb-2006)
>
> Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
> 08:57:20 2006 UTC).
> Cannot set MCLK for AIC23 CODEC
> audio support initialized
> ALSA device list:
>   #0: OMAP Innovator AIC23
>
> Thereafter if we try to run an application it promts the same error
> "Cannot set MCLK for AIC23 CODEC" and fails to recognise the device
> present.

That's propaply because the clock rate is already ok, or the clock rate
is fixed and can not be changed.
Could you check whether the attached patch will work for you? If it
works, I will submit it in separate mail to be applied to
git repository.

>
> Certain clarifications are required:
> 1) Where is the definition of the function "aic23_write_value" -
> specified in the first two patches?

In OMAP git repository head following driver
drivers/i2c/chips/tlv320aic23.c

> 2) The MCLK not being set; the MCBSP clocks are set all right during
> the bootup. Why then does it crib now?

The attached patch should fix it, as it will check whether the clock is
already using the correct rate.
In future there may be need to change the alsa code a little bit more,
so that the clock rate can be defined in the board code instead of
hardcoding in the alsa driver as Menon Nishant suggested some time ago.

> 3) Are the MCLK and the MCBSP clocks one and the same?

It might help you to check arch/arm/mach-omap1/clock.h for seeing the
definition of different kind of clocks that are available for omap boards.

> We have cross-compiled the ALSA utils (aplay, arec & speaker-test) as
> also ALSA libraries separately & included the same in the file-system.
> Does ALSA require any configuration before we can use the utils?

I have only used the tsc2101 omap-alsa driver my self but there I do not
need any configuration for basic play testing.
I just use "alsamixer" for selecting the playback target and volume and
then "aplay music.wav" to play it. speaker-test should give some kind of
noice :-)

Mika

--------------000804010101070305030602
Content-Type: text/x-patch;
 name="aic23_omap_alsa_clock_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aic23_omap_alsa_clock_fix.patch"

diff -Naur ../1/sound/arm/omap/omap-alsa-aic23.c sound/arm/omap/omap-alsa-aic23.c
--- ../1/sound/arm/omap/omap-alsa-aic23.c	2006-05-03 21:44:17.000000000 +0300
+++ sound/arm/omap/omap-alsa-aic23.c	2006-05-03 22:12:42.000000000 +0300
@@ -212,6 +212,8 @@
  */
 int aic23_clock_on(void)
 {
+	uint	curRate;
+
 	if (clk_get_usecount(aic23_mclk) > 0) {
 		/* MCLK is already in use */
 		printk(KERN_WARNING
@@ -219,11 +221,13 @@
 		       (uint) clk_get_rate(aic23_mclk),
 		       CODEC_CLOCK);
 	}
-	
-	if (clk_set_rate(aic23_mclk, CODEC_CLOCK)) {
-		printk(KERN_ERR
-		       "Cannot set MCLK for AIC23 CODEC\n");
-		return -ECANCELED;
+	curRate	= (uint)clk_get_rate(aic23_mclk);
+	if (curRate != CODEC_CLOCK) {
+		if (clk_set_rate(aic23_mclk, CODEC_CLOCK)) {
+			printk(KERN_ERR
+			       "Cannot set MCLK for AIC23 CODEC\n");
+			return -ECANCELED;
+		}
 	}
 
 	clk_enable(aic23_mclk);

--------------000804010101070305030602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000804010101070305030602--
