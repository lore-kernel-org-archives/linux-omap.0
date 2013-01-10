From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/3] ARM: dts: omap: add dt data for MUSB
Date: Thu, 10 Jan 2013 11:49:13 +0530
Message-ID: <50EE5D61.1020307@ti.com>
References: <1348047128-25692-1-git-send-email-kishon@ti.com>
 <505A8BAB.2020004@ti.com> <20121227183524.GB7097@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121227183524.GB7097-R3WNPi76c83LsdW6vOPryG4HOFkwEHDbMR2xtNvyitY@public.gmane.org>
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
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 28 December 2012 12:05 AM, Aaro Koskinen wrote:
> Hi,
>
> On Thu, Sep 20, 2012 at 05:21:15AM +0200, Benoit Cousson wrote:
>> On 09/19/2012 11:32 AM, Kishon Vijay Abraham I wrote:
>>> This patch series adds dt data to get MUSB working in omap4 and omap3
>>>
>>> Changes from v2:
>>> * Changes the subject of all the patches to include "ARM: dts:"
>>> * Added reg property and interrupt property for "usb_otg_hs". Previously these
>>>    were obtained from ti,hwmods property.
>>> * Rebased on
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git devel-dt
>>>
>>> Changes from v1:
>>> Just removed the omap-usb2 dt data and sent that as a separate patch.
>>>
>>> Kishon Vijay Abraham I (3):
>>>    ARM: dts: Add twl6030-usb data
>>>    ARM: dts: Add twl4030-usb data
>>>    ARM: dts: omap: Add usb_otg and glue data
>>
>> Thanks for the update. I've just pulled the series for 3.7.
>
> I wonder what happened to the patch #3 (Add usb_otg and glue data)
> of this series? Why was it dropped? I cannot see it in 3.7 or 3.8-rc1.

Benoit?

-Kishon
