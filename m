From: Tony Lindgren <tony@atomide.com>
Subject: About to tag 2.6.18-omap1 (Was: Pending September patches)
Date: Thu, 19 Oct 2006 17:10:56 +0300
Message-ID: <20061019141054.GK9983@atomide.com>
References: <4523B6F8.3020800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4523B6F8.3020800@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I believe things are mostly working, except for the pending McBSP
without DSP compile issue. Most of the patches posted on this list
have been integrated, please notify if you feel something is still
missing. Also check that your patches got integrated properly.

Unless somebody knows of any showstoppers, I'll tag 2.6.18-omap1
tomorrow.

Below comments on Dirk's pending September patches list.

* Dirk Behme <dirk.behme@googlemail.com> [061004 16:28]:
> Hi,
> 
> my list of pending OMAP patches for September 2006:
> 
> 1. [PATCH] MTD patch, including the latest modifications an
> offical upgrades for MTD
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007889.html
> 
> Note: Is this still necessary or does 2.6.18 contain it
> automatically?

Skipped this one as only Ladis' driver patch was needed.
 
> 2.[PATCH 1/4] TSC2102 main SPI driver
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007929.html

Pushed.
 
> 3. [PATCH 2/4] TSC2102 Touchscreen
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007931.html

Pushed.
 
> Note: What's about "[PATCH 3/4] TSC2102 hwmon driver"?

Not needed any longer.
 
> 4. [PATCH 4/4] TSC2102 OMAP audio driver
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007930.html

Pushed.
 
> 5. [PATCH] Request OMAP MMC Write-protect pin
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007976.html

Not pushed, let's wait for a board-*.c solution.
 
> 6. LCD output from decompressor
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-September/007977.html
> 
> Note: Should this be applied or only stay on the list for
> interested people?

Skipped.
 
> Please correct if I missed anything, if any of above patches
> are already applied or if any has comments I overlooked and
> needs resend. Are there any older patches pending?

Well there's Dave's RTC patches, but I think those should be tested
first.

Regards,

Tony
