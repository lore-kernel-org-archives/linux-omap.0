From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v3 4/9] ARM: OMAP2+: gpmc-nand: populate gpmc configs
Date: Wed, 11 Apr 2012 05:15:12 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317C6F64@DBDE01.ent.ti.com>
References: <cover.1333640054.git.afzal@ti.com>
 <6c120ab77d0900a6f977246bc58fb37c62280371.1333640054.git.afzal@ti.com>
 <4F84890A.30500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F84890A.30500@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Menon, Nishanth" <nm@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "vimal.newwork@gmail.com" <vimal.newwork@gmail.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "mike@compulab.co.il" <mike@compulab.co.il>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On Wed, Apr 11, 2012 at 00:54:58, Hunter, Jon wrote:
> > +#define	GPMC_NAND_CONFIG_NUM	4
> 
> Where does 4 come from?


It depends on the use case, for NAND, with the way it was being
configured (or number of times gpmc_cs_configure was being called)
4 are needed.

Regards
Afzal
