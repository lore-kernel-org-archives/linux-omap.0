From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] of: provide of_platform_unpopulate()
Date: Mon, 22 Jul 2013 00:44:27 +0100
Message-ID: <CACxGe6sqv2Wsp26MWqqs9W_eWO3tjs-+2z3z8fC=2fe-BjJvkA@mail.gmail.com>
References: <1374257691-31981-1-git-send-email-bigeasy@linutronix.de>
 <51EBF33A.4050207@gmail.com> <51EC4908.4040504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51EC4908.4040504-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Jul 21, 2013 at 9:48 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 07/21/2013 09:42 AM, Rob Herring wrote:
>> On 07/19/2013 01:14 PM, Sebastian Andrzej Siewior wrote:
>>> So I called of_platform_populate() on a device to get each child device
>>> probed and on rmmod and I need to reverse its doing. After a quick grep
>>> I did what others did as well and rmmod ended in:
>>>
>>> | Unable to handle kernel NULL pointer dereference at virtual address 00000018
>>> | PC is at release_resource+0x18/0x80
>>> | Process rmmod (pid: 2005, stack limit = 0xedc30238)
>>> | [<c003add0>] (release_resource+0x18/0x80) from [<c0300e08>] (platform_device_del+0x78/0xac)
>>> | [<c0300e08>] (platform_device_del+0x78/0xac) from [<c0301358>] (platform_device_unregister+0xc/0x18)
>>>
>>> The problem is that platform_device_del() "releases" each ressource in its
>>> tree. This does not work on platform_devices created by OF becuase they
>>> were never added via insert_resource(). As a consequence old->parent in
>>> __release_resource() is NULL and we explode while accessing ->child.
>>> So I either I do something completly wrong _or_ nobody here tested the
>>> rmmod path of their driver.
>>
>> Wouldn't the correct fix be to call insert_resource somehow? The problem
>> I have is that while of_platform_populate is all about parsing the DT
>> and creating devices, the removal side has nothing to do with DT. So
>> this should not be in the DT code. I think the core device code should
>> be able to handle removal if the device creation side is done correctly.
>>
>> It looks to me like of_device_add either needs to call
>> platform_device_add rather than device_add. I think the device name
>> setting in platform_device_add should be a nop. If not, a check that the
>> name is already set could be added.
>>
>
> BTW, it looks like Grant has attempted this already:

Yup, things broke badly. Unfortunately the of_platform_device and
platform_device history doesn't treat resources in the same way. I
would like to merge the code, but I haven't been able to figure out a
clean way to do it. Looks like we do need the unpopulate function.

g.
