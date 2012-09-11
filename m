From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v8 2/3] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Tue, 11 Sep 2012 10:16:56 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9E1D2C@DBDE01.ent.ti.com>
References: <cover.1346846464.git.afzal@ti.com>
 <c14607ff57fca419dc9d7e0beaea197e001f4e25.1346846464.git.afzal@ti.com>
 <5047AE2B.30807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5047AE2B.30807@ti.com>
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
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On Thu, Sep 06, 2012 at 01:25:23, Hunter, Jon wrote:

> Nit-pick, I see some devices writing the above as ...
> 
> 	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
> 
>  	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;

> Otherwise ...
> 
> Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Thanks for your reviews, updated series has been posted

Regards
Afzal
