From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH 06/12] usb: dwc3: omap: Replace the extcon API
Date: Fri, 02 Dec 2016 11:03:46 +0200
Message-ID: <87fum6vh1p.fsf@linux.intel.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com> <1480485460-2663-7-git-send-email-cw00.choi@samsung.com> <CGME20161130103827epcas4p268ee1cbc6b7b2ace7c987dd7baba82d4@epcas4p2.samsung.com> <877f7lntjq.fsf@linux.intel.com> <58412848.5070209@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <58412848.5070209@samsung.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, gregkh@linuxfoundation.org, kishon@ti.com, sre@kernel.org
Cc: Peter.Chen@nxp.com, wens@csie.org, yoshihiro.shimoda.uh@renesas.com, maxime.ripard@free-electrons.com, b-liu@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, chanwoo@kernel.org
List-Id: linux-omap@vger.kernel.org


Hi,

Chanwoo Choi <cw00.choi@samsung.com> writes:
> Hi Felipe,
>
> On 2016년 11월 30일 19:36, Felipe Balbi wrote:
>> 
>> Hi,
>> 
>> Chanwoo Choi <cw00.choi@samsung.com> writes:
>>> This patch uses the resource-managed extcon API for extcon_register_notifier()
>>> and replaces the deprecated extcon API as following:
>>> - extcon_get_cable_state_() -> extcon_get_state()
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> 
>> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>> 
>
> Thanks for your review.
>
> Each patch has no any dependency among patches.
> So, If possible, could you pick the patch6/8/9/10/11/12 on your tree?

my tree is closed for v4.10, I can pick it up for v4.11

-- 
balbi
