From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 2/4] DTS: GTA04: fix panel compatibility string
Date: Tue, 28 Nov 2017 17:04:38 +0100
Message-ID: <AB65CE5D-C055-4344-9872-F3556981BCEE@goldelico.com>
References: <cover.1510822218.git.hns@goldelico.com> <09d975dd62afa1dfa43d94079cc9a44731af4b3b.1510822218.git.hns@goldelico.com> <20171128145727.GY28152@atomide.com> <C108B0B6-FED7-44DB-9A18-39E3BE93E586@goldelico.com> <20171128151039.GZ28152@atomide.com> <F14B3797-8154-4958-82AB-8E39C75BB97B@goldelico.com> <20171128160057.GB28152@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128160057.GB28152@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org


> Am 28.11.2017 um 17:00 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [171128 15:51]:
>>> Am 28.11.2017 um 16:10 schrieb Tony Lindgren <tony@atomide.com>:
>>> OK fine dropping both. Please update the description in both dts
>>> patches to make it clear they are needed as a fix. Preferrably
>>> with a proper fixes tag.
>> 
>> Well, it is not "needed" in a strong sense since current mainline&stable
>> works. It is more a style and consistency fix to use "tpo," everywhere.
>> 
>>> 
>>> Having "We can remove the "omapdss," prefix" in the description sure
>>> does not sounds like it's needed as a fix :)
>> 
>> The description has been improved on -v3.
> 
> Thanks.
> 
>>> Sounds like maybe these two should be just a single patch for
>>> a proper fix?
>> 
>> Hm. I usually get the feedback to separate DT and driver fixes into
>> separate commits... Therefore I submit patch sets in the hope they
>> are not picked apart :)
> 
> See "both dts patches" part above. Yes the dts patches can and should
> be sent separately. In almost every case if the dts patches cannot be
> applied separately it means your driver changes are breaking things.

That is why the v3 driver now accepts both, the old and the new vendor
name. This means applying the driver alone is safe. Applying or not
applying DTS patch afterwards is also safe.

BR,
Nikolaus
