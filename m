From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 5/9] ARM: OMAP: USB: Add phy binding information
Date: Tue, 18 Jun 2013 15:34:36 +0530
Message-ID: <51C030B4.5070707@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-6-git-send-email-kishon@ti.com>
 <20130618094438.GT5461@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130618094438.GT5461-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
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
To: balbi-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 18 June 2013 03:14 PM, Felipe Balbi wrote:
> On Thu, Jun 13, 2013 at 02:13:55PM +0530, Kishon Vijay Abraham I wrote:
>> In order for controllers to get PHY in case of non dt boot, the phy
>> binding information (phy device name) should be added in the platform
>> data of the controller.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>
> I would rather not pass strings around, any other way to handle this ?
> Why do you need to pass this string ?

Our old way of binding the controller and the phy using device name 
started creating problems after the devices are created using 
PLATFORM_DEVID_AUTO. Infact non-dt boot is broken in mainline for OMAP3 
platforms for which I have posted a RFC series 
http://www.serverphorums.com/read.php?12,708632 which also uses strings.
I'm not sure of any other way to deal with this.

Thanks
Kishon
