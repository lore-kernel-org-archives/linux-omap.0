From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git tree updated
Date: Tue, 8 May 2007 11:19:25 -0700
Message-ID: <20070508181924.GF32547@atomide.com>
References: <20070508175857.GE32547@atomide.com>
	<9C23CDD79DA20A479D4615857B2E2C47DCC7A3@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47DCC7A3@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Syed Mohammed, Khasim <x0khasim@ti.com> [070508 11:02]:
> >Yeah, I thought Trilok's patch fixed this, but it seems it not the
> >case, 24xx still does not boot.
> 
> I applied Trilok's patch, but still it doesn't boot on 2430 SDP. Need to debug more. 

Found it, see below.

Tony


--AhhlLboLdkugWU4S
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fix-24xx-boot.patch"

Fix booting of 24xx

Looks like automerge again...

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -42,6 +42,12 @@ static struct map_desc omap2_io_desc[] __initdata = {
 		.length		= L3_24XX_SIZE,
 		.type		= MT_DEVICE
 	},
+	{
+		.virtual	= L4_24XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_24XX_PHYS),
+		.length		= L4_24XX_SIZE,
+		.type		= MT_DEVICE
+	},
 #ifdef CONFIG_ARCH_OMAP2430
 	{
 		.virtual	= L4_WK_243X_VIRT,

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--AhhlLboLdkugWU4S--
