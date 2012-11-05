From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH v3] ARM: dts: AM33xx: Add SPI node
Date: Mon, 5 Nov 2012 11:32:40 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9DAB5F@DBDE01.ent.ti.com>
References: <1351680669-20718-1-git-send-email-avinashphilip@ti.com>
 <50927DF5.4080008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50927DF5.4080008@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "AnilKumar, Chimata" <anilkumar@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 01, 2012 at 19:19:41, Cousson, Benoit wrote:
> Hi Avinash,
> 
> On 10/31/2012 11:51 AM, Philip, Avinash wrote:
> > Add McSPI data node to AM33XX device tree file. The McSPI module (and so
> > as the driver) is reused from OMAP4.
> > 
> > Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> > Tested-by: Matt Porter <mporter@ti.com>
> 
> I've just realized the interrupt-parent was still there, so I removed both.
> 
> Please find below the updated version.

I tested it and thanks for the fix.

Thanks
Avinash
