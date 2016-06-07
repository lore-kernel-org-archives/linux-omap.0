From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] mfd: twl6040: Handle mclk used for HPPLL and optional
 internal clock source
Date: Tue, 7 Jun 2016 11:54:57 +0300
Message-ID: <7d5e3117-a014-0107-bf75-775401834e02@ti.com>
References: <1462965209-6955-1-git-send-email-peter.ujfalusi@ti.com>
 <20160516150231.GA5527@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160516150231.GA5527@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Lee,

On 05/16/16 18:02, Rob Herring wrote:
> On Wed, May 11, 2016 at 02:13:29PM +0300, Peter Ujfalusi wrote:
>> On some boards, like omap5-uevm the MCLK is gated by default and in =
order
>> to be able to use the High performance modes of twl6040 it need to b=
e
>> enabled by SW.
>> Add support for handling the MCLK source clock via CCF.
>> At the same time lover the print priority of the notification that t=
he 32K
>> clock is not proveded so it is not going to be handled by the driver=
=2E
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/twl6040.txt |  4 +--
>=20
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Can you take a look at this patch if it is OK to pick?

>>  drivers/mfd/twl6040.c                             | 34 ++++++++++++=
+++++------
>>  include/linux/mfd/twl6040.h                       |  3 +-
>>  3 files changed, 29 insertions(+), 12 deletions(-)


Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
