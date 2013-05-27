From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 2/3] extcon: Palmas Extcon Driver
Date: Mon, 27 May 2013 14:54:12 +0530
Message-ID: <51A3263C.5040400@ti.com>
References: <1369405896-30246-1-git-send-email-kishon@ti.com>
 <1369405896-30246-3-git-send-email-kishon@ti.com>
 <51A2F07F.8070009@samsung.com> <51A2F512.2090907@ti.com>
 <51A2F84D.9030605@samsung.com> <51A2FB88.9000303@nvidia.com>
 <51A2FDD2.10309@ti.com> <51A2FEE9.1060905@nvidia.com>
 <51A30026.2090001@ti.com> <51A3038E.3030405@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51A3038E.3030405-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "george.cherian-l0cyMroinI0@public.gmane.org" <george.cherian-l0cyMroinI0@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 27 May 2013 12:26 PM, Laxman Dewangan wrote:
> On Monday 27 May 2013 12:11 PM, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Monday 27 May 2013 12:06 PM, Laxman Dewangan wrote:
>>> On Monday 27 May 2013 12:01 PM, Kishon Vijay Abraham I wrote:
>>>> Hi,
>>>>
>>>> On Monday 27 May 2013 11:52 AM, Laxman Dewangan wrote:
>>>>> On Monday 27 May 2013 11:38 AM, Chanwoo Choi wrote:
>>>>>> On 05/27/2013 02:54 PM, Kishon Vijay Abraham I wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Monday 27 May 2013 11:04 AM, Chanwoo Choi wrote:
>>>>>>>> Hi Kishon,
>>>>>>>>
>>>>>>>> I have some comment about this patch
>>>>>>>> and upload modified patch to following repository
>>>>>>>> (extcon-for-palmas).
>>>>>>>> -
>>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/com=
mit/?h=3Dextcon-for-palmas&id=3Df2b7cb80699cbe1a5fd6c97ef2c600915f8d7f2c
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> This patchset include patch related to other module
>>>>>>>> ,so I need your opinion to apply this patchset to git repository.
>>>>>>> yeah.. Still there is some confusion with
>>>>>>> palmas_set_switch_smps10().
>>>>>>> I think we can remove it for now and add it separately later. By
>>>>>>> this
>>>>>>> at least we can have device mode fully functional in OMAP5. What do
>>>>>>> you think?
>>>>>>>
>>>>>>     I agree your opinion.
>>>>>>
>>>>>> But, I propose some fixes about palmas_set_switch_smps10().
>>>>>> I dont' prefer to call global function in exton-palmas.c from
>>>>>> palmas-regulator.c.
>>>>>> So, Why don't you use regulator consumer instead of global function?
>>>>>> You can register specific regulator for enabling or disabling
>>>>>> SMPS10_SWITCH_EN
>>>>>> and then control SMPS10_SWITCH_EN bit through regulator framework in
>>>>>> extcon-palmas.c
>>>>>> without calling global function.
>>>>> Along with this, I also like to make the VBUS regulator control to be
>>>>> optional here. Currently it is mandatory.
>>>> But dint you just tell on my v4 of this patch that you don=92t require
>>>> this.
>>>> http://www.spinics.net/lists/linux-doc/msg10638.html
>>> In V4, I said remove this VBUS control and my mean was to remove all
>>> regulator calls for VBUS enabled/disable.
>>> I saw you just remove the platform data option to have this control and
>>> made VBUS mandatory.
>>>
>>> Probably some gap here.
>> Indeed..
>> I think then we should stick back to how it was with my v4 or else it
>> would break OMAP. The regulator calls can't be moved anywhere else as it
>> is specific to PALMAS.
>>
>
> I was thinking that extcon driver just detect the cable type and notify
> to the client. After cable detection, the next level of configuration
> should be done in the respective client.
>
> On Tegra platform,  for ID pin detection, Tegra SOC is capable of detect
> the ID pin presence or Palma is capable. Depending on the board design,
> how the ID pin routed from USB connector to PMIC or to Tegra, we enable
> corresponding detection logic.
> Once the USB driver got notification for ID pin presence (by any means),
> the enabling of VBUS (as the Tegra will work as Host now and need to
> supply VBUS), is done in USB driver.
> Not sure about the OMAP here.

I think I got your point here. Will check and send a patch.

Thanks
Kishon
