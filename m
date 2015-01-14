From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC 0/3] Make "ti,tilcdc,slave" DT binding more sensible
Date: Wed, 14 Jan 2015 11:56:46 +0200
Message-ID: <54B63D5E.1010606@ti.com>
References: <cover.1421167634.git.jsarha@ti.com> <20150114075729.7fe4b80a@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48393 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbbANJ4z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2015 04:56:55 -0500
In-Reply-To: <20150114075729.7fe4b80a@armhf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, detheridge@ti.com, tomi.valkeinen@ti.com

On 01/14/2015 08:57 AM, Jean-Francois Moine wrote:
> On Tue, 13 Jan 2015 19:12:25 +0200
> Jyri Sarha <jsarha@ti.com> wrote:
>
>> These patches are needed for Beaglebone-back HDMI audio. There is no
>> direct dependency between these patches and the other (dts and ASoC)
>> changes needed for the HDMI audio so these changes can be merged
>> independently. I also feel that these changes make sense even without
>> the HDMI audio.
>>
>> Best regards,
>> Jyri
>>
>> Jyri Sarha (3):
>>    drm: encoder_slave: Add drm_i2c_encoder_attach()
>>    drm/tilcdc: slave: Add support for "i2c-slave" DT-parameter
>>    ARM: dts: am335x-boneblack: Use new binding in ti,tilcdc,slave node
>>
>>   .../devicetree/bindings/drm/tilcdc/slave.txt       |    4 +-
>>   arch/arm/boot/dts/am335x-boneblack.dts             |    9 +++-
>>   drivers/gpu/drm/drm_encoder_slave.c                |   51 ++++++++++++++++++++
>>   drivers/gpu/drm/tilcdc/tilcdc_slave.c              |   50 +++++++++++--------
>>   include/drm/drm_encoder_slave.h                    |    3 ++
>>   5 files changed, 95 insertions(+), 22 deletions(-)
>
> Instead of adding code to have the slave encoder working, it would be
> simpler to change the way tilcdc uses the tda998x.
> I already proposed such a patch:
>
> http://lists.freedesktop.org/archives/dri-devel/2014-March/056065.html
>
> and the changes in the tda998x driver have been done by Russell:
>
> commit: a8f4d4d63739e4bca459ff40636f1d9e4b7ef5e6
> 	drm/i2c: tda998x: allow re-use of tda998x support code
> and
> commit: c707c3619ca81f499a5ce032021405e989a96ff0
> 	drm/i2c: tda998x: add component support
>

Interesting. Would you still have the original branch somewhere? Manual 
applying the patches from the web-page is time consuming.

Best regards,
Jyri
