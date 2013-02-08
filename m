From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] dmaengine: OMAP: Register SDMA controller with Device
 Tree DMA driver
Date: Fri, 8 Feb 2013 12:52:43 -0600
Message-ID: <5115497B.3070106@ti.com>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
 <201302071439.13720.arnd@arndb.de> <5113CD6F.3060108@ti.com>
 <10081370.NaeII8M1Pj@wuerfel> <51144C3E.7070603@ti.com>
 <20130208014402.GA7556@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130208014402.GA7556-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Ujfalusi,
 Peter" <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 02/07/2013 07:44 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org> [130207 16:55]:
>>
>> Ugh, looks like linux-next is broken for omap2+ boards at the moment
>> and is panic'ing in the twl i2c code ... some else to look into ...
>>
>> Peter have you seen this on linux-next? I am seeing this on omap2-4 boards.
> 
> Does not happen with arm-soc/for-next, probably related to the
> drivers/mfd/*twl* changes?

Looks like it is caused by ...

commit 8a6aaa33bc6db516b7cb286c9b8d3ed90a0f06f9
Author: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Date:   Wed Jan 16 14:53:57 2013 +0100

    mfd: twl-core: Collect global variables behind one private structure (global)
    
    Gather the global variables under a single structure and allocate it with
    devm_kzalloc(). It is easier to see them and if in the future we try to add
    support for multiple instance of twl in the system it is going to be much
    simpler.
    
    Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
    Signed-off-by: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Here is a fix. I will send out for review later ...

>From 141fcbbdee6bdc14d5a444ff20fad6b3440215dc Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Date: Fri, 8 Feb 2013 12:42:20 -0600
Subject: [PATCH] ARM: OMAP2+: Fix kernel panic on boot

Commit 8a6aaa3 (mfd: twl-core: Collect global variables behind one
private structure (global)) removed the variable "inuse" that is used
to determine if the device has been initialised and now use the
twl_priv structure instead. This is causing the kernel to panic on all
OMAP2+ devices, because we try to access the twl_priv->ready member
before checking if twl_priv is initialised. Fix this and move this test
to the beginning of the twl_i2c_read/write function because
twl_get_last_module() also uses the twl_priv structure.

Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/twl-core.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 557f9ee..89ab4d9 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -316,12 +316,12 @@ int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 	int sid;
 	struct twl_client *twl;
 
-	if (unlikely(mod_no >= twl_get_last_module())) {
-		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
+	if (unlikely(!twl_priv || !twl_priv->ready)) {
+		pr_err("%s: not initialized\n", DRIVER_NAME);
 		return -EPERM;
 	}
-	if (unlikely(!twl_priv->ready)) {
-		pr_err("%s: not initialized\n", DRIVER_NAME);
+	if (unlikely(mod_no >= twl_get_last_module())) {
+		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
 		return -EPERM;
 	}
 
@@ -355,12 +355,12 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 	int sid;
 	struct twl_client *twl;
 
-	if (unlikely(mod_no >= twl_get_last_module())) {
-		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
+	if (unlikely(!twl_priv || !twl_priv->ready)) {
+		pr_err("%s: not initialized\n", DRIVER_NAME);
 		return -EPERM;
 	}
-	if (unlikely(!twl_priv->ready)) {
-		pr_err("%s: not initialized\n", DRIVER_NAME);
+	if (unlikely(mod_no >= twl_get_last_module())) {
+		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
 		return -EPERM;
 	}
 
-- 
1.7.10.4
