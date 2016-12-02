From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 06/12] usb: dwc3: omap: Replace the extcon API
Date: Fri, 2 Dec 2016 22:20:56 +0900
Message-ID: <CAGTfZH0SGB9Wd5ww8rKQOJStCvuFsRzypVBer+nkhnKojkthqA@mail.gmail.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
 <1480485460-2663-7-git-send-email-cw00.choi@samsung.com> <CGME20161130103827epcas4p268ee1cbc6b7b2ace7c987dd7baba82d4@epcas4p2.samsung.com>
 <877f7lntjq.fsf@linux.intel.com> <58412848.5070209@samsung.com> <87fum6vh1p.fsf@linux.intel.com>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87fum6vh1p.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Greg KH <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Peter Chen <Peter.Chen@nxp.com>, Chen-Yu Tsai <wens@csie.org>, yoshihiro.shimoda.uh@renesas.com, Maxime Ripard <maxime.ripard@free-electrons.com>, b-liu@ti.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-usb@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

2016-12-02 18:03 GMT+09:00 Felipe Balbi <balbi@kernel.org>:
>
> Hi,
>
> Chanwoo Choi <cw00.choi@samsung.com> writes:
>> Hi Felipe,
>>
>> On 2016=EB=85=84 11=EC=9B=94 30=EC=9D=BC 19:36, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Chanwoo Choi <cw00.choi@samsung.com> writes:
>>>> This patch uses the resource-managed extcon API for extcon_register_no=
tifier()
>>>> and replaces the deprecated extcon API as following:
>>>> - extcon_get_cable_state_() -> extcon_get_state()
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>
>>> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>>>
>>
>> Thanks for your review.
>>
>> Each patch has no any dependency among patches.
>> So, If possible, could you pick the patch6/8/9/10/11/12 on your tree?
>
> my tree is closed for v4.10, I can pick it up for v4.11

Thanks for your pickup to 4.11.

--=20
Best Regards,
Chanwoo Choi
