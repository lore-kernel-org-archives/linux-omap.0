From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 03/11] arm: omap: device: create a device
 for system control module
Date: Tue, 29 May 2012 12:44:01 +0300
Message-ID: <20120529094400.GA3505@besouro>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-4-git-send-email-eduardo.valentin@ti.com>
	<4FBF7B74.4020302@ti.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FBF7B74.4020302@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: amit.kucheria@linaro.org, kbaidarov@dev.rtsoft.ru, kishon@ti.com, balbi@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 25, 2012 at 02:30:44PM +0200, Cousson Benoit wrote:
> On 5/25/2012 10:25 AM, Eduardo Valentin wrote:
> >From: Kishon Vijay Abraham I<kishon@ti.com>
> >
> >Extracts the device data from hwmod database and create a platform device
> >using omap device build.
> >
> >The device build is done during postcore_initcall.
> 
> Do you still need that since you are supporting only DT?
> The device will be built automatically in the DT case.

In fact this is not needed for DT only probing. Dropping this one.

> 
> Regards,
> Benoit
> 
> >
> >Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
> >Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
> >---
> >  arch/arm/mach-omap2/devices.c |   26 ++++++++++++++++++++++++++
> >  1 files changed, 26 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> >index 152c266..9332673 100644
> >--- a/arch/arm/mach-omap2/devices.c
> >+++ b/arch/arm/mach-omap2/devices.c
> >@@ -40,6 +40,32 @@
> >  #define L3_MODULES_MAX_LEN 12
> >  #define L3_MODULES 3
> >
> >+static int omap_init_control(void)
> >+{
> >+	struct omap_hwmod		*oh;
> >+	struct platform_device		*pdev;
> >+	const char			*oh_name, *name;
> >+
> >+	oh_name = "ctrl_module_core";
> >+	name = "omap-control-core";
> >+
> >+	oh = omap_hwmod_lookup(oh_name);
> >+	if (!oh) {
> >+		pr_err("Could not lookup hwmod for %s\n", oh_name);
> >+		return PTR_ERR(oh);
> >+	}
> >+
> >+	pdev = omap_device_build(name, -1, oh, NULL, 0, NULL, 0, true);
> >+	if (IS_ERR(pdev)) {
> >+		pr_err("Could not build omap_device for %s %s\n",
> >+		       name, oh_name);
> >+		return PTR_ERR(pdev);
> >+	}
> >+
> >+	return 0;
> >+}
> >+postcore_initcall(omap_init_control);
> >+
> >  static int __init omap3_l3_init(void)
> >  {
> >  	struct omap_hwmod *oh;
> 
