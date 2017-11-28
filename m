From: H. Nikolaus Schaller <hns@goldelico.com>
Subject: Re: [PATCH v3 4/4] DTS: Pandora: fix panel compatibility string
Date: Tue, 28 Nov 2017 19:32:37 +0100
Message-ID: <4EE1E298-6461-48FF-977C-958DD16AD83A@goldelico.com>
References: <cover.1511884135.git.hns@goldelico.com>
 <b6001c7b7fb98e7a3ad4c712084fea9dae9e6b27.1511884135.git.hns@goldelico.com>
 <20171128160437.GD28152@atomide.com>
 <ADAFBBA4-6AC4-4EC4-AB0E-98B59718E12E@goldelico.com>
 <20171128161834.GE28152@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171128161834.GE28152@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 28.11.2017 um 17:18 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [171128 16:17]:
>> Hi Tony,
>> 
>>> Am 28.11.2017 um 17:04 schrieb Tony Lindgren <tony@atomide.com>:
>>> 
>>> * H. Nikolaus Schaller <hns@goldelico.com> [171128 15:52]:
>>>> We can remove the unnecessary "omapdss," prefix because
>>>> the omapdrm driver takes care of it when matching with
>>>> the driver table.
>>> 
>>> So is this needed as a fix or is this another clean-up?
>>> 
>>> So is this is really needed as a fix?
>> 
>> Hm. How do you differentiate between "fix" and "cleanup"?
>> Maybe it is more a wording than a content issue...
>> 
>> For me it is a "fix" because it is semantically wrong to have
>> a prefix where it is not needed. And "fixing" it changes the
>> compiler output by 8 bytes.
> 
> How about let's call it a "typo fix" then? :)

Well, it is not really a typo.

> 
>> "Cleanup" would be for me removing whitespace or empty lines
>> or typos in comments.
>> 
>>> If this is just clean-up, again, please resend once the driver
>>> changes have cleared.
>> 
>> There is no change to the pandora driver involved here. The Pandora
>> panel driver is already correct. Just the DTS has some redundant
>> content which should be removed.
>> 
>> So there is no dependency for this patch.
> 
> OK please resend separately after the driver changes have merged
> then.

The Pandora driver does not need an update. Only the DTS.
So there is noting to merge or wait for.

Maybe the confusion comes that in both cases (GTA04 and OpenPandora)
there are changes to DTS.

But different ones.

GTA04: change vendor prefix to make it consistent
Pandora: remove redundant (unnecessary and potentially wrong) omapdss, prefix

In addition we have to modify the GTA04 panel to handle the correct
vendor prefix. The Pandora panel already uses the right one.

Anyways, I think it is now Tomi to decide about the panel driver
(vendor prefix) patch 1/4 and 2/4 first. Then we can sort out
the DTS changes (3/4 and 4/4).

BR and thanks,
Nikolaus
