From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v6 0/9] Generic PHY Framework
Date: Tue, 21 May 2013 10:31:09 +0530
Message-ID: <519AFF95.9060002@ti.com>
References: <1367229812-30574-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1367229812-30574-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, grant.likely@linaro.org, tony@atomide.com, balbi@ti.com, arnd@arndb.de, swarren@nvidia.com, sylvester.nawrocki@gmail.com, gregkh@linuxfoundation.org, akpm@linux-foundation.org
Cc: rnayak@ti.com, linux@arm.linux.org.uk, b-cousson@ti.com, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, shawn.guo@linaro.org, santosh.shilimkar@ti.com, cesarb@cesarb.net, rob@landley.net, benoit.cousson@linaro.org, linux-omap@vger.kernel.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org, mchehab@redhat.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 29 April 2013 03:33 PM, Kishon Vijay Abraham I wrote:
> Added a generic PHY framework that provides a set of APIs for the PHY drivers
> to create/destroy a PHY and APIs for the PHY users to obtain a reference to
> the PHY with or without using phandle.
>
> This framework will be of use only to devices that uses external PHY (PHY
> functionality is not embedded within the controller).
>
> The intention of creating this framework is to bring the phy drivers spread
> all over the Linux kernel to drivers/phy to increase code re-use and to
> increase code maintainability.
>
> Comments to make PHY as bus wasn't done because PHY devices can be part of
> other bus and making a same device attached to multiple bus leads to bad
> design.
>
> If the PHY driver has to send notification on connect/disconnect, the PHY
> driver should make use of the extcon framework. Using this susbsystem
> to use extcon framwork will have to be analysed.
>
> Making omap-usb2 and twl4030 to use this framework is provided as a sample.
>
> This patch series is developed on linux-next tree.

Any comments on this patch series?

Thanks
Kishon
