From: Rob Clark <robdclark@gmail.com>
Subject: Re: [RFC] drm/lcdc: add TI LCD Controller DRM driver
Date: Mon, 17 Dec 2012 10:36:10 -0600
Message-ID: <CAF6AEGt2hvmjRQoAjeGko_Fxq=B5DcYCRQUsM7POPxqOwja5Lg@mail.gmail.com>
References: <1355443446-8723-1-git-send-email-robdclark@gmail.com>
	<50CF248B.4010401@ti.com>
	<CAF6AEGvm2TmFh7xiYzjt9yGT4kuBFA=_219NkwQAjbBVZ+Z6rg@mail.gmail.com>
	<CAF6AEGtfeXycZjashi=PenX86m7HLBTZ=U04Q4kLSyqJXwQ1fQ@mail.gmail.com>
	<CAKG51UAunsckFj9g7EMrX6=uFakEidQv2AJJMXPVzeY77eU+JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CAKG51UAunsckFj9g7EMrX6=uFakEidQv2AJJMXPVzeY77eU+JA@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Sekhar Nori <nori.sekhar@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "patches@linaro.org" <patches@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 17, 2012 at 9:26 AM, Sekhar Nori <nori.sekhar@gmail.com> wrote:
> Hi Rob,
>
>
> On Monday, December 17, 2012, Rob Clark wrote:
>>
>> On Mon, Dec 17, 2012 at 8:39 AM, Rob Clark <robdclark@gmail.com> wrote:
>> >> I'm not very enthusiastic about adding ti-lcdc specific panel/chip
>> >> drivers. It's not really a big deal if it's only kernel code, but you
>> >> add device-tree bindings also, which is an external API that you need
>> >> to
>> >> support after adding it.
>> >>
>> >> I'd rather see the energy put to common display framework, and get this
>> >> whole panel/chip driver issue solved in a generic manner.
>> >
>> > yeah, I was expecting to migrate to CDF once it exists, but needed
>> > something for now.  I'm using the exercise to get my thoughts straight
>> > on how CDF should fit into KMS.  (One thing I plan to add support for
>> > is an i2c connected hdmi encoder.. which looks like it would fit well
>> > in drivers/gpu/drm/i2c.. so the drm encoder-slave stuff might be the
>> > way.)
>> >
>> > If you have any suggestions on the DT bindings, I'd like to hear 'em.
>>
>> btw, a little bit of-topic, but speaking of DT...
>>
>> Anybody have any clue about how backlight devices are supposed to work
>> in this brave new DT world?
>
>
> See Runtime interpreted power sequences here:
>  http://lkml.indiana.edu/hypermail/linux/kernel/1208.2/00029.html
>
> It is an attempt to address this need.

hmm, I'm not really sure that is what is needed..  or rather, it might
perhaps make sense to have a generic backlight driver implementation
that could be used where appropriate, but I'm a bit suspicious about
that trying to cover absolutely everything.

>From the drm/display driver we don't even want to care how the
backlight is implemented.  You could have (just making something up
hypothetically) a backlight controlled via a uart or some sort of
other crazy magic.. and eventually the generic interpreter gets out of
hand.

Really I think we just want a way to retrieve a 'struct
backlight_device *' that is created somewhere else.  We don't care how
that backlight driver is implemented.  I don't think we want an
interpreter.. we want a way to lookup backlight device by name or
phandle or something like that.

BR,
-R
