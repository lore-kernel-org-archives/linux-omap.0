From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: How to handle named resources with DT?
Date: Tue, 9 Aug 2011 11:23:20 +0200
Message-ID: <4E40FC88.5090403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Grant,

Trying to bind hwmod informations with DT, I'm facing a little limitation.
A bunch of drivers are using the platform_get_resource_byname, so the 
name for the resource is needed.

The name is used so far for IORESOURCE_MEM, IORESOURCE_IRQ and 
IORESOURCE_DMA types of resources.

Do you have any plan to add that, or do you have any clean way to avoid 
that without having to use the resource index?

Thanks,
Benoit
