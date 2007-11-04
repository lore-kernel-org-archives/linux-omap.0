From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH 04/14] MMC: OMAP: Power functions modified to
 MMC	multislot support
Date: Sun, 04 Nov 2007 18:54:39 -0400
Message-ID: <472E4DAF.4010701@indt.org.br>
References: <46F28BB7.7050203@indt.org.br>
	<20071009152914.GC7784@atomide.com>	<470BBEC8.2010906@indt.org.br>
	<4714E35F.3090106@indt.org.br>	<20071021234917.GB6984@atomide.com>
	<471E1219.2060007@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010505090202020809000608"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <471E1219.2060007@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------010505090202020809000608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ext Carlos Aguiar wrote:
> ext Tony Lindgren wrote:
>   
>> Hi,
>>
>> * Carlos Aguiar <carlos.aguiar@indt.org.br> [071016 09:17]:
>>   
>>     
>>> From: Juha Yrjola <juha.yrjola@solidboot.com>
>>>
>>> Modifications at power functions to MMC multislot support. This patch
>>> also move board-specific code out of MMC OMAP driver.
>>>     
>>>       
>> <snip>
>>
>>   
>>     
>>> @@ -1090,23 +1063,30 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>  	int i, dsor;
>>>  
>>>  	dsor = mmc_omap_calc_divisor(mmc, ios);
>>> -	host->bus_mode = ios->bus_mode;
>>> -	host->hw_bus_mode = host->bus_mode;
>>> +
>>> +	mmc_omap_select_slot(slot, 0);
>>> +
>>> +	if (ios->vdd != slot->vdd)
>>> +		slot->vdd = ios->vdd;
>>>  
>>>  	switch (ios->power_mode) {
>>>  	case MMC_POWER_OFF:
>>> -		mmc_omap_power(host, 0);
>>> +		mmc_omap_set_power(slot, 0, ios->vdd);
>>>  		break;
>>>  	case MMC_POWER_UP:
>>>  		/* Cannot touch dsor yet, just power up MMC */
>>> -		mmc_omap_power(host, 1);
>>> -		return;
>>> +		mmc_omap_set_power(slot, 1, ios->vdd);
>>>  	case MMC_POWER_ON:
>>>  		dsor |= 1 << 11;
>>>  		break;
>>>  	}
>>>  
>>> -	clk_enable(host->fclk);
>>> +	if (slot->bus_mode != ios->bus_mode) {
>>> +		if (slot->pdata->set_bus_mode != NULL)
>>> +			slot->pdata->set_bus_mode(mmc_dev(mmc), slot->id,
>>> +						  ios->bus_mode);
>>> +		slot->bus_mode = ios->bus_mode;
>>> +	}
>>>  
>>>  	/* On insanely high arm_per frequencies something sometimes
>>>  	 * goes somehow out of sync, and the POW bit is not being set,
>>>     
>>>       
>>   
>>     
> Hi Tony,
>
> Sorry for my late response. In fact, I'm in sick leave.
>
>
>   
>> The above still changes behaviour, you've left out return after
>> MMC_POWER_UP. That is not supposed to do anything except power
>> up the slot and return as mentioned in the comment.
>>   
>>     
> Well, the first option I tried was of course return after MMC_POWER_UP. But, unexpectedly, such return is broken on N800. 
>
> I'm working and investigating this today.
>
> BR,
>
> Carlos.
>
>   
>> Tony
>>
>>   
>>     
>
>
>   
Hi Tony,

As I mentioned on previous mail, the return after MMC_POWER_UP unexpectedly is broken on N800. So, I was investigating such problem and I'm resending the patch with a new solution, that I aim to don't revert MMC_POWER_UP vs MMC_POWER_ON.

This solution was tested on N800 and H3 and works fine with multislot patch series on top of previous commit (47c7785083ea67a7be90c7ace22ea639fa2e48f4). The patch is attached to this mail.

As Linux-OMAP tree was updated last days and merged with linus tree, some modifications must be updated to multislot series and tested. I'd already start this task.

So, I'm going to resend the whole series until next Wed (Nov,7).

BR,

Carlos.


-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br


--------------010505090202020809000608
Content-Type: text/x-patch;
	name*0="0004-MMC-OMAP-Power-functions-modified-to-MMC-multislot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0004-MMC-OMAP-Power-functions-modified-to-MMC-multislot.patc";
	filename*1="h"

>From e22e4723f6ba673dc938be09ea096474c00c1e72 Mon Sep 17 00:00:00 2001
From: Juha Yrjola <juha.yrjola@solidboot.com>
Date: Mon, 17 Sep 2007 11:32:17 -0400
Subject: [PATCH 04/17] MMC: OMAP: Power functions modified to MMC multislot support

Modifications at power functions to MMC multislot support. This patch
also move board-specific code out of MMC OMAP driver.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 drivers/mmc/host/omap.c |   90 +++++++++++++++++++---------------------------
 1 files changed, 37 insertions(+), 53 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 4cc5265..02f4463 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1004,54 +1004,27 @@ static void mmc_omap_request(struct mmc_host *mmc, struct mmc_request *req)
 	mmc_omap_start_request(host, req);
 }
 
-static void innovator_fpga_socket_power(int on)
+static void mmc_omap_set_power(struct mmc_omap_slot *slot, int power_on,
+				int vdd)
 {
-#if defined(CONFIG_MACH_OMAP_INNOVATOR) && defined(CONFIG_ARCH_OMAP15XX)
-	if (on) {
-		fpga_write(fpga_read(OMAP1510_FPGA_POWER) | (1 << 3),
-		     OMAP1510_FPGA_POWER);
-	} else {
-		fpga_write(fpga_read(OMAP1510_FPGA_POWER) & ~(1 << 3),
-		     OMAP1510_FPGA_POWER);
-	}
-#endif
-}
+	struct mmc_omap_host *host;
 
-/*
- * Turn the socket power on/off. Innovator uses FPGA, most boards
- * probably use GPIO.
- */
-static void mmc_omap_power(struct mmc_omap_host *host, int on)
-{
-	if (machine_is_sx1())
-		sx1_setmmcpower(on);
-	else if (on) {
-		if (machine_is_omap_innovator())
-			innovator_fpga_socket_power(1);
-		else if (machine_is_omap_h2())
-			tps65010_set_gpio_out_value(GPIO3, HIGH);
-		else if (machine_is_omap_h3())
-			/* GPIO 4 of TPS65010 sends SD_EN signal */
-			tps65010_set_gpio_out_value(GPIO4, HIGH);
-		else if (cpu_is_omap24xx()) {
-			u16 reg = OMAP_MMC_READ(host, CON);
-			OMAP_MMC_WRITE(host, CON, reg | (1 << 11));
-		} else
-			if (host->power_pin >= 0)
-				omap_set_gpio_dataout(host->power_pin, 1);
-	} else {
-		if (machine_is_omap_innovator())
-			innovator_fpga_socket_power(0);
-		else if (machine_is_omap_h2())
-			tps65010_set_gpio_out_value(GPIO3, LOW);
-		else if (machine_is_omap_h3())
-			tps65010_set_gpio_out_value(GPIO4, LOW);
-		else if (cpu_is_omap24xx()) {
-			u16 reg = OMAP_MMC_READ(host, CON);
-			OMAP_MMC_WRITE(host, CON, reg & ~(1 << 11));
-		} else
-			if (host->power_pin >= 0)
-				omap_set_gpio_dataout(host->power_pin, 0);
+	host = slot->host;
+
+	if (slot->pdata->set_power != NULL)
+		slot->pdata->set_power(mmc_dev(slot->mmc), slot->id, power_on,
+					vdd);
+
+	if (cpu_is_omap24xx()) {
+		u16 w;
+
+		if (power_on) {
+			w = OMAP_MMC_READ(host, CON);
+			OMAP_MMC_WRITE(host, CON, w | (1 << 11));
+		} else {
+			w = OMAP_MMC_READ(host, CON);
+			OMAP_MMC_WRITE(host, CON, w & ~(1 << 11));
+		}
 	}
 }
 
@@ -1090,23 +1063,31 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	int i, dsor;
 
 	dsor = mmc_omap_calc_divisor(mmc, ios);
-	host->bus_mode = ios->bus_mode;
-	host->hw_bus_mode = host->bus_mode;
+
+	mmc_omap_select_slot(slot, 0);
+
+	if (ios->vdd != slot->vdd)
+		slot->vdd = ios->vdd;
 
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
-		mmc_omap_power(host, 0);
+		mmc_omap_set_power(slot, 0, ios->vdd);
 		break;
 	case MMC_POWER_UP:
 		/* Cannot touch dsor yet, just power up MMC */
-		mmc_omap_power(host, 1);
-		return;
+		mmc_omap_set_power(slot, 1, ios->vdd);
+		goto exit;
 	case MMC_POWER_ON:
 		dsor |= 1 << 11;
 		break;
 	}
 
-	clk_enable(host->fclk);
+	if (slot->bus_mode != ios->bus_mode) {
+		if (slot->pdata->set_bus_mode != NULL)
+			slot->pdata->set_bus_mode(mmc_dev(mmc), slot->id,
+						  ios->bus_mode);
+		slot->bus_mode = ios->bus_mode;
+	}
 
 	/* On insanely high arm_per frequencies something sometimes
 	 * goes somehow out of sync, and the POW bit is not being set,
@@ -1114,6 +1095,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 * Writing to the CON register twice seems to do the trick. */
 	for (i = 0; i < 2; i++)
 		OMAP_MMC_WRITE(host, CON, dsor);
+	slot->saved_con = dsor;
 	if (ios->power_mode == MMC_POWER_ON) {
 		/* Send clock cycles, poll completion */
 		OMAP_MMC_WRITE(host, IE, 0);
@@ -1122,7 +1104,9 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		while ((OMAP_MMC_READ(host, STAT) & 1) == 0);
 		OMAP_MMC_WRITE(host, STAT, 1);
 	}
-	clk_disable(host->fclk);
+
+exit:
+	mmc_omap_release_slot(slot);
 }
 
 static int mmc_omap_get_ro(struct mmc_host *mmc)
-- 
1.5.3.GIT


--------------010505090202020809000608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010505090202020809000608--
