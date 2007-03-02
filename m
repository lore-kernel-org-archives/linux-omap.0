From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: Basic N800 support
Date: Fri, 2 Mar 2007 09:44:51 +0900
Message-ID: <00a901c75c64$01b1e830$c7a3580a@swcenter.sec.samsung.co.kr>
References: <13020905.97851169452503947.JavaMail.weblogic@ep_ml23>
	<20070122171254.GD7382@atomide.com>
	<20070206213648.GH9311@atomide.com>
	<000101c74a77$39e94120$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070301134533.GA15801@angel.research.nokia.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <20070301134533.GA15801@angel.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Jarkko Lavinen' <jarkko.lavinen@nokia.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Jarkko Lavinen,

Looks good.

Tony, please add drivers/mtd/onenand/omap2.c first 

+
+static int n800_onenand_setup(void __iomem *onenand_base)
+{
+	struct omap_onenand_platform_data *datap = &n800_onenand_data;
+	struct device *dev = &n800_onenand_device.dev;
+
+	/* Force OneNAND to async mode */
+	omap2_onenand_writew(ONENAND_SYS_CFG1_BRL_4 | ONENAND_SYS_CFG1_RDY |
+			     ONENAND_SYS_CFG1_INT,
+			     onenand_base + ONENAND_REG_SYS_CFG1);

If you don't need async mode settings, it also don't need it.

+
+	/* Set sync timings in GPMC */
+	if (omap2_onenand_set_sync_mode(datap->cs, onenand_base) < 0) {
+		dev_err(dev, "Unable to set synchronous mode\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}

Thank you,
Kyungmin Park
 
 

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com 
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On 
> Behalf Of Jarkko Lavinen
> Sent: Thursday, March 01, 2007 10:46 PM
> To: linux-omap-open-source@linux.omap.com
> Cc: Kyungmin Park
> Subject: Re: Basic N800 support
> 
> On Wed, Feb 07, 2007 at 02:16:58PM +0900, Kyungmin Park wrote:
> > GPMC timings should be set in platform file such as 
> > board-n800-onenand.c or bootloader and don't need to configure the 
> > OneNAND system configuration in omap2.c
> 
> Attaches is a candidate patch which moves N800 OneNand sync 
> mode timing setup into platform specific file.
> 
> Regards
> Jarkko Lavinen
> 
