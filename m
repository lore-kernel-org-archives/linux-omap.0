From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 0/7] usb: musb: add driver for control module
Date: Tue, 15 Jan 2013 20:09:22 +0530
Message-ID: <50F56A1A.3040504@ti.com>
References: <1358239378-10030-1-git-send-email-kishon@ti.com>
 <201301151341.08297.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201301151341.08297.arnd-r2nGTMty4D4@public.gmane.org>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On Tuesday 15 January 2013 07:11 PM, Arnd Bergmann wrote:
> On Tuesday 15 January 2013, Kishon Vijay Abraham I wrote:
>> Added a new driver for the usb part of control module. This has an API
>> to power on the USB2 phy and an API to write to the mailbox depending on
>> whether MUSB has to act in host mode or in device mode.
>>
>> Writing to control module registers for doing the above task which was
>> previously done in omap glue and in omap-usb2 phy is removed.
>>
>> Also added the dt data to get MUSB working in OMAP platforms.
>> This series has patches for both drivers and ARCH folders, so If it has to
>> be split I'll do it.
>>
>
> The series looks good to me, I just had a minor comment on one patch.
>
> One a somewhat related topic, I wonder whether there are any plans
> on your side to change this driver to support multiple bus glues
> to be built for one kernel image. With a multiplatform kernel, we
> may need all of TUSB6010/OMAP2PLUS/DSPS/UX500 for instance.

We don't have plans as of now. I actually don't expect any changes in 
the driver other than the Kconfig changes. Anyways the probe of glue's 
other than the platform it's running won't get called. right Felipe?

Thanks
Kishon
