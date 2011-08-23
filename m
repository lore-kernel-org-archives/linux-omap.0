From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC/PATCH v2 00/13] dt: omap: dt binding with omap_device and
	support for i2c1
Date: Tue, 23 Aug 2011 14:38:21 +0200
Message-ID: <4E539F3D.4010602@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
	<4E537ECB.1060704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E537ECB.1060704@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Manju,

Few "minor" comments about your subjects in this series.

> Patch series reworked from:
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/61674
> Also added support for i2c1 controller on omap4 based panda
> board.
>
> Baseline:
> =========
> git://git.secretlab.ca/git/linux-2.6.git
> Branch: devicetree/test
> The above branch is rebased with v3.1-rc2 mainline.
> +
> pdev decoupling patches from kevin hilman
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg53534.html
>
> The patch series is also available at:
> https://gitorious.org/devicetree/dt_omap/commits/devicetree/dt_rfcv2

Please provide the git URL + branch and not the link to the web page.
It will allow to copy paste directly the line and do a git fetch <repo> 
<branch>.

> Testing:
> ========
> Build : dt and not dt build for omap2plus_defconfig
> Boot: OMAP3530 Beagle Board and OMAP4430 Panda board
>
> Limitation:
> ===========
> The current implementation of omap-device build through
> device tree supports only single instance of hwmod and
> multiple instances are not supported.
>
> G, Manjunath Kondaiah (13):
>     OMAP: omap_device: Add device tree node pointer
>     dt: Add pd_size to AUXDATA structure
>     dt: omap3: add soc file for handling i2c controllers
>     dt: omap3: beagle board: set clock freq for i2c devices
>     dt: omap3: add generic board file for dt support
>     dt: omap3: add omap-device compatible property
>     dt: omap: create platform bus for omap devices
>     dt: omap: i2c: add dt support for i2c1 controller
>     dt: omap4: add soc file for handling i2c controllers
>     dt: omap4: panda board: set clock freq for i2c devices
>     dt: omap4: add generic board file for dt support
>     dt: omap4: enable dt support for i2c1 controller
>     dt: omap: i2c: dt usage model documentation

You should adapt the prefix depending of the subsystem your patch is 
changing. Most patches are changing files inside mach-omap2 and thus in 
that case should not be prefix with dt: but rather OMAP2+:
The dts files modification should then be prefixed with arm/dt or arm/dts.


Regards,
Benoit
