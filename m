From: "B.J. Buchalter" <bj@mhlabs.com>
Subject: Re: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
Date: Thu, 26 May 2011 09:38:23 -0400
Message-ID: <AB90A028-5926-4DBB-BAD9-7C0EF6E0FD05@mhlabs.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-3-git-send-email-tarun.kanti@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D177FCC@dbde02.ent.ti.com>
	<4DDE2745.3030307@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D178110@dbde02.ent.ti.com>
	<4DDE435C.8060506@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D17815E@dbde02.ent.ti.com>
	<4DDE4BB0.7010809@ti.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4DDE4BB0.7010809@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Premi,
	Sanjeev" <premi@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan,
	Charulatha" <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

Why not do the following:

       #define OMAP_GPIO_REV_0	0
       #define OMAP_GPIO_REV_1	1
       #define OMAP_GPIO_REV_2	2
       #define OMAP_GPIO_REV_3	3
/*
	OMAP_GPIO_REV_0:	OMAP2420
	OMAP_GPIO_REV_1:	OMAP2430
	OMAP_GPIO_REV_2:	OMAP3, DMxxx
	OMAP_GPIO_REV_3:	OMAP4, OMAP5, DM816x
*/

  +	switch (oh->class->rev) {     ## This is auto-generated.
  +	case 0:				## But this is our code.

      I am recommending this to read as:

  +	switch (oh->class->rev) {     ## This is auto-generated.
  +	case OMAP_GPIO_REV_0:		## More readable.

That approach solves both issues -- Revision -> Chip mapping in comment, no magic numbers in the code, and no implied restriction of the rev number to a specific SoC. Using the defines makes it easier to search the code for a specific revision, since you would no longer get false positives for all the other '0' and '1' constants that appear in the code. It also makes it indexible by tools like LXR.

B.J. Buchalter
Metric Halo 
http://www.mhlabs.com
	
