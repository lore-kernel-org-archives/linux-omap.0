From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH v2] arm/dts: AM33XX: Add SPI device tree data
Date: Wed, 26 Sep 2012 09:47:19 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9A927A@DBDE01.ent.ti.com>
References: <1347946228-25874-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347946228-25874-1-git-send-email-avinashphilip@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Benoit,

On Tue, Sep 18, 2012 at 11:00:28, Philip, Avinash wrote:
> Add McSPI data node to AM33XX device tree file. The McSPI module (and so
> as the driver) is reused from OMAP4.
> 	
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> Tested-by: Matt Porter <mporter@ti.com>


I haven't received any comments till now for this patch. 
Do you have any comments for this patch? 

With this patch SPI is working on AM335x SoC in PIO mode.

If no comments, can you pull this patch for 3.7?

Thanks
Avinash
