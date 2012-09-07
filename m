From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC RESEND 1/4] arm/dts: OMAP: Add timer nodes
Date: Thu, 6 Sep 2012 21:09:28 -0500
Message-ID: <50495758.5080500@ti.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
 <1342218413-30116-2-git-send-email-jon-hunter@ti.com>
 <5000D647.4090200@gmail.com> <500439A8.1050705@ti.com>
 <500D6CAB.4030504@ti.com> <5048A8F6.6080108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5048A8F6.6080108-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tarun Kanti DebBarma <tarun.kanti-l0cyMroinI0@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 09/06/2012 08:45 AM, Rob Herring wrote:
> On 07/23/2012 10:24 AM, Jon Hunter wrote:

[snip]

>> Do you have any inputs on the above? Does it make sense to reserve timer
>> resources for kernel system timers in device-tree?
> 
> This issue is not unique to omap. So if we do specify clockevent and
> clocksource in dts, then it should be in a common way. I think using
> "linux,clockevent" either as an alias name or property within the timer
> node would work. I don't have a strong preference, but I tend to lean
> toward an alias. Primarily this is because we are already using aliases
> for similar purposes.
> 
> However, I still think this could be done by looking at properties.
> There's not really any reason you can't check properties at timer init
> stage. The FDT has already been un-flattened. What are the features or
> lack of features you care about to determine which timer to use?

I agree. Currently, I am looking into implementing something that will
use timer properties to select the system timers for the kernel and not
require us to select them in the device-tree. Once I have something
working I will send out for review.

Cheers
Jon
