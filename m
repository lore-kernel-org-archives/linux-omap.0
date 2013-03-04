From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Mon, 4 Mar 2013 12:19:10 -0600
Message-ID: <5134E59E.1000507@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-12-git-send-email-jon-hunter@ti.com>
 <CALF0-+V3A-fL7q2nPRmcgnFKmzRt8KwSLuzrwzyyce6MqHjVpw@mail.gmail.com>
 <5134DF2A.4050209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5134DF2A.4050209-l0cyMroinI0@public.gmane.org>
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
To: Ezequiel Garcia <elezegarcia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 03/04/2013 11:51 AM, Jon Hunter wrote:
> 
> On 03/04/2013 05:57 AM, Ezequiel Garcia wrote:
>> Hi Jon,
>>
>> On Tue, Feb 26, 2013 at 2:30 PM, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org> wrote:
>>> +
>>> +Example:
>>> +
>>> +gpmc: gpmc@6e000000 {
>>> +       compatible = "ti,omap3430-gpmc", "simple-bus";
>>
>> I'm concern about using simple-bus, and I'm not entirely sure this will work.
>>
>> AFAIK, you can't correlate a parent-child relationship in the device tree
>> to the order in which drivers will be probed,
>> so it's only a matter of coincidence if this is working for you right now.
> 
> Ummm, I am not sure I am convinced. Have you looked at
> of_platform_bus_create() which creates the devices? It is clearly
> creating the child devices after creating the parent device.

Sorry you said order by which drivers are probed. Yes I would agree that
you cannot control the order drivers are probed, but just the order
devices are registered.

However, I don't see this as being a device-tree specific issue. Even
when not using device-tree you would need to ensure that probing the
parent happens before the child for the GPMC.

Jon
