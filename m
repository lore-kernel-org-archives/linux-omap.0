From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/4] ARM: dts: Add USB host support for Panda and
 Beagle-xm
Date: Mon, 29 Apr 2013 15:32:18 +0300
Message-ID: <517E6852.5010001@ti.com>
References: <1366365457-28972-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1366365457-28972-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: b-cousson-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: nm-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/19/2013 12:57 PM, Roger Quadros wrote:
> Hi Benoit/Tony
> 
> I've consolidated all the USB host device tree patches for Panda and Beagles
> to one place and addressed Tony's comments.
> 
> NOTE: patch 1 depends on OMAP clock binding introduced in
> https://lkml.org/lkml/2013/4/12/407

Tony, Benoit,

Just FYI, the patch [1] that is needed will probably not get in
until 3.10 rc1. However, this series need not wait till that happens.

[1] https://lkml.org/lkml/2013/4/12/407

cheers,
-roger

> 
> v3:
> - updated mux mode to use pulldowns on panda as non-DT boot uses pulldowns.
> - fixed usb pin naming for panda, beagle and beagle-xm
> 
> The following changes since commit 1fac4fffa719a98ec1047eaece236244333c9afe:
> 
>   ARM: dts: Add OMAP3430 SDP NOR flash memory binding (2013-04-09 00:21:35 +0200)
> 
> are available in the git repository at:
>   git://github.com/rogerq/linux.git usbhost-omap-dts
> 
> Roger Quadros (4):
>       ARM: dts: omap4-panda: Add USB Host support
>       ARM: dts: omap3-beagle: Make USB host pin naming consistent
>       ARM: dts: omap3-beagle-xm: Add USB Host support
>       ARM: dts: omap3-beagle-xm: Add USB host supprot for Rev. Ax/Bx
> 
>  arch/arm/boot/dts/omap3-beagle-xm-ab.dts  |   19 ++++++++
>  arch/arm/boot/dts/omap3-beagle-xm.dts     |   65 ++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/omap3-beagle.dts        |   25 ++++++-----
>  arch/arm/boot/dts/omap4-panda-common.dtsi |   58 +++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi              |    5 ++
>  5 files changed, 158 insertions(+), 14 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap3-beagle-xm-ab.dts
> 
