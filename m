From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 8/9] dspbridge: add map support for big buffers
Date: Thu, 26 Aug 2010 07:38:26 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602F10ED4B1@dlee06.ent.ti.com>
References: <1277943660-4112-7-git-send-email-x0095840@ti.com>
	<1277943660-4112-8-git-send-email-x0095840@ti.com>
	<1277943660-4112-9-git-send-email-x0095840@ti.com>,<20100826155416J.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100826155416J.fujita.tomonori@lab.ntt.co.jp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ohad@wizery.com" <ohad@wizery.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>
List-Id: linux-omap@vger.kernel.org


Hi Fujita,
________________________________________
>From: FUJITA Tomonori [fujita.tomonori@lab.ntt.co.jp]
>Sent: Thursday, August 26, 2010 1:55 AM
>To: Guzman Lugo, Fernando
>Cc: linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org; ohad@wizery.com; hiroshi.doyu@nokia.com; ameya.palande@nokia.com; felipe.contreras@nokia.com
>Subject: Re: [PATCH 8/9] dspbridge: add map support for big buffers
>
>On Wed, 30 Jun 2010 19:20:59 -0500
>Fernando Guzman Lugo <x0095840@ti.com> wrote:
>
>> due to a restriction in scatter gather lists, it can
>> not be created a list for a buffer bigger than 1MB.
>> This patch is spliting big mappings into 1MB mappings.
>
>I don't read the whole thread but the above description is incorrect.
>
>Why can't you use scatter gather chaining? You can create a scatter
>list for a buffer larger than 1MB.

The thing is that ARM architecture does not support SG chaining. This patch should be
seen like a workaround until it is fixed in iovmm module.

Thanks and regards,
Fernando.
