From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/8] ARM/dts: OMAP2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
Date: Fri, 7 Sep 2012 10:42:49 +0200
Message-ID: <5049B389.2070903@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
 <1346247067-9632-2-git-send-email-peter.ujfalusi@ti.com>
 <5044C2DD.5000705@ti.com> <504578B3.3090804@ti.com> <5045D557.30404@ti.com>
 <79CD15C6BA57404B839C016229A409A83EAA7C99@DBDE01.ent.ti.com>
 <50470C1E.7090300@ti.com>
 <79CD15C6BA57404B839C016229A409A83EAA8014@DBDE01.ent.ti.com>
 <5047544B.60105@ti.com>
 <79CD15C6BA57404B839C016229A409A83EAA8779@DBDE01.ent.ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA29468@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA29468-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Cc: "Ujfalusi, Peter" <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Anil,

On 09/07/2012 07:45 AM, AnilKumar, Chimata wrote:
> On Wed, Sep 05, 2012 at 20:11:11, Hiremath, Vaibhav wrote:
>> On Wed, Sep 05, 2012 at 19:01:55, Cousson, Benoit wrote:
>>> Hi Vaibhav,
>>>
>>> On 09/05/2012 11:15 AM, Hiremath, Vaibhav wrote:
>>>> On Wed, Sep 05, 2012 at 13:53:58, Ujfalusi, Peter wrote:
>>>>> Hi,
>>>>>
>>>>> On 09/05/2012 09:11 AM, Hiremath, Vaibhav wrote:
>>>>>>> Not yet, but we discussed that with Peter and since he does have these
>>>>>>> patches for DT, he'll be able to test your series with the McBSP changes.
>>>>>>>
>>>>>>
>>>>>> Great.
>>>>>
>>>>> With his series and your patch for omap-hwmod audio was probing and working on
>>>>> OMAP3/4/5 without issues.
>>>>>
>>>> Peter,
>>>> Care to provide your Tested-By??
>>>>
>>>> Benoit,
>>>> Can we merge this patch now?
>>>
>>> Yes, I'll include it in the pull request along with DTS patches.
>>>
>>> I've just tested it as well on OMAP4 by hacking the DTS for GPIO.
>>> I'll try to update at least all the OMAP4 IPs as well with the proper
>>> DTS resources for 3.7.
>>>
>>
>> Thanks Benoit,
>>
>> There are other patches which are pending,
>>
>> arm/dts: AM33XX: Convert all hex numbers to lower-case
>> https://patchwork.kernel.org/patch/1377351/
>> arm/dts: AM33XX: Specify reg and interrupt property for all nodes
>> https://patchwork.kernel.org/patch/1377361/
>>
> 
> Few more DT patches which are pending
> 
> arm/dts: AM33XX: Add basic pinctrl device tree data
> http://www.spinics.net/lists/linux-omap/msg76684.html
> arm/dts: AM33XX: Configure pinmuxs for user leds control on Bone
> http://www.spinics.net/lists/linux-omap/msg76682.html
> arm/dts: AM33XX: Add D_CAN device tree data
> http://www.spinics.net/lists/linux-omap/msg76683.html

These ones still need some acks, but looks fine to me.

Can you rebase them on top of the branch that already contains some
AM33xx patches from Vaibhav:

git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
for_3.7/dts

While you are rebasing, could you as well change the subject to use
"ARM: dts: " prefix. It looks like everybody is using that convention
now beside OMAP :-(

Thanks,
Benoit
