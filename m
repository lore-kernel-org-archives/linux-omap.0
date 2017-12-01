From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 4/4] DTS: Pandora: fix panel compatibility string
Date: Fri, 1 Dec 2017 08:41:00 +0100
Message-ID: <029CB0A8-2D63-4F84-96EE-6C37167E1297@goldelico.com>
References: <cover.1511884135.git.hns@goldelico.com>
 <b6001c7b7fb98e7a3ad4c712084fea9dae9e6b27.1511884135.git.hns@goldelico.com>
 <20171128160437.GD28152@atomide.com>
 <ADAFBBA4-6AC4-4EC4-AB0E-98B59718E12E@goldelico.com>
 <20171128161834.GE28152@atomide.com>
 <4EE1E298-6461-48FF-977C-958DD16AD83A@goldelico.com>
 <20171130152430.GM28152@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171130152430.GM28152@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, Sean Paul <seanpaul@chromium.org>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> Am 30.11.2017 um 16:24 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [171128 18:35]:
>> Hi,
>> 
>>> Am 28.11.2017 um 17:18 schrieb Tony Lindgren <tony@atomide.com>:
>>> 
>>> * H. Nikolaus Schaller <hns@goldelico.com> [171128 16:17]:
>>>> Hi Tony,
>>>> 
>>>>> Am 28.11.2017 um 17:04 schrieb Tony Lindgren <tony@atomide.com>:
>>>>> 
>>>>> * H. Nikolaus Schaller <hns@goldelico.com> [171128 15:52]:
>>>>>> We can remove the unnecessary "omapdss," prefix because
>>>>>> the omapdrm driver takes care of it when matching with
>>>>>> the driver table.
>>>>> 
>>>>> So is this needed as a fix or is this another clean-up?
>>>>> 
>>>>> So is this is really needed as a fix?
>>>> 
>>>> Hm. How do you differentiate between "fix" and "cleanup"?
>>>> Maybe it is more a wording than a content issue...
>>>> 
>>>> For me it is a "fix" because it is semantically wrong to have
>>>> a prefix where it is not needed. And "fixing" it changes the
>>>> compiler output by 8 bytes.
>>> 
>>> How about let's call it a "typo fix" then? :)
>> 
>> Well, it is not really a typo.
> 
> Well what if the stable people pick it into earlier stable series
> based on the word fix in the subject? That has happened before.

Well, that may happen but IMHO *every* such backport must be checked
for reasonability and compatibility and sometimes even modified to apply.

And I think the author of the original patch receives a notification
from the stable maintainers and can then veto.

For Example I received "[PATCH 4.7 118/186] w1:omap_hdq: fix regression"
"4.7-stable review patch.  If anyone has any objections, please let me know."

If that process still fails, we simply have to revert it... Has also
happened before. So it will not be end of mankind :)

> 
> I suggest you update the dts patches to use wording like
> "update compatible to use new naming" or something similar.

I have applied s/fix/improve/ for patch 3/4 and left 4/4 as
suggested by Sebastian since it is really a strongly suggested
correction.

Since Tomi has already accepted the underlaying driver patch,
[PATCH v4] will only have the remaining DTS patches.

BR and thanks,
Nikolaus
