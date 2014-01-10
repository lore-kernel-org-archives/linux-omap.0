From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: 3.13-rc2 phy-twl4030-usb.c - Timeout setting T2 HSUSB PHY DPLL
Date: Fri, 10 Jan 2014 10:55:41 +0530
Message-ID: <52CF8455.5090506@ti.com>
References: <CAAfyv37aM6SrpuU9fzKA6GKsWn=To5ANOpG_kSX509NjMjdecA@mail.gmail.com>	<529F1E89.6080700@ti.com>
 <CAAfyv36sNyEiEHEOKfZWN1xRYLGUt-NW18uhcJbSTWRBA5=2BA@mail.gmail.com>
 <52CE32AB.1050204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52CE32AB.1050204@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>, Belisko Marek <marek.belisko@gmail.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 09 January 2014 10:54 AM, Roger Quadros wrote:
> Hi Marek,
> 
> I have no idea what is happening there. Have you tried using device tree boot?
> Board file boot support would be dropped eventually.
> 
> Did you try if I2C read write to the twl4030 device works and all necessary clocks/supplies are
> present?
> 
> Kishon, do you know what is causing the USB DPLL failure there?

Not sure what's causing those failures :-s

-Kishon

> 
> cheers,
> -roger
> 
> On 01/09/2014 02:31 AM, Belisko Marek wrote:
>> Any pointers? Still present in 3.13-rc7.
>>
>> On Wed, Dec 4, 2013 at 1:22 PM, Roger Quadros <rogerq@ti.com> wrote:
>>> +Kishon
>>>
>>> On 12/03/2013 11:33 PM, Belisko Marek wrote:
>>>> Hi,
>>>>
>>>> current 3.13-rcX break usb support on gta04 board (similar to
>>>> beagleboard) when booting via board file.
>>>>
>>>> In console we can see messages:
>>>>  [ 5227.287841] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
>>>> [ 5232.936096] omap_musb_mailbox: musb core is not yet ready
>>>> [ 5233.958160] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
>>>> [ 5235.058227] twl4030_usb twl4030_usb: Timeout setting T2 HSUSB PHY DPLL clock
>>>>
>>>> Any pointer what could cause that? (in 3.12 usb works fine)
>>>>
>>>> BR,
>>>>
>>>> marek
>>>>
>>>
>>
>> BR,
>>
>> marek
>>
> 
