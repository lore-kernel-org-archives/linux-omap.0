From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCHv6 0/4] omapdrm: DSI command mode panel support
Date: Wed, 29 May 2019 12:33:07 +0300
Message-ID: <0f124d61-b2ed-2b7f-f63a-0b478473c8fd@ti.com>
References: <20190523200756.25314-1-sebastian.reichel@collabora.com>
 <60c45d23-de2f-d94a-c3d7-146a2bee538f@ti.com>
 <20190527112122.GJ5447@atomide.com>
 <e507c415-38de-86fe-9265-4b0aed0d7224@ti.com>
 <20190528093952.GM5447@atomide.com>
 <14c6c702-844b-756d-2d97-44e8f5a169df@ti.com>
 <20190528101847.GN5447@atomide.com>
 <c2eaee25-a0d3-2632-fdea-3a81ac7085af@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c2eaee25-a0d3-2632-fdea-3a81ac7085af@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org



On 28/05/2019 13.32, Tomi Valkeinen wrote:
> On 28/05/2019 13:18, Tony Lindgren wrote:
>> Strange that this is not affecting other x15? I think timer12 would
>> be blocked on HS devices though?
> 
> I don't know... I can't believe my x15 would be unique =). Can it be
> something in the kernel config? u-boot?
> 
> Peter should have the same A3. Peter, can you try with my config?

It did not boot with your config.
My config boots, I'm using SLUB.
Flipping CONFIG_SLUB_DEBUG_ON to y and the kernel does not boot.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
