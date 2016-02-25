From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v5 4/8] drm/i2c: tda998x: Add support
 of a DT graph of ports
Date: Thu, 25 Feb 2016 15:42:50 +0200
Message-ID: <56CF04DA.8080905@ti.com>
References: <cover.1455720381.git.jsarha@ti.com>
 <842e221030a0b14bc862790eb2f5bc97bb29c012.1455720381.git.jsarha@ti.com>
 <20160218143530.GB9654@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160218143530.GB9654@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, moinejf@free.fr, airlied@linux.ie, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 02/18/16 16:35, Rob Herring wrote:
> On Wed, Feb 17, 2016 at 04:49:05PM +0200, Jyri Sarha wrote:
>> From: Jean-Francois Moine <moinejf@free.fr>
>>
>> Two kinds of ports may be declared in a DT graph of ports: video and audio.
>> This patch accepts the port value from a video port as an alternative
>> to the video-ports property.
>> It also accepts audio ports in the case the transmitter is not used as
>> a slave encoder.
>> The new file include/sound/tda998x.h prepares to the definition of
>> a tda998x CODEC.
>>
>> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>   .../devicetree/bindings/display/bridge/tda998x.txt | 51 ++++++++++++
>>   drivers/gpu/drm/i2c/tda998x_drv.c                  | 90 +++++++++++++++++++---
>>   include/sound/tda998x.h                            |  8 ++
>>   3 files changed, 140 insertions(+), 9 deletions(-)
>>   create mode 100644 include/sound/tda998x.h
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/tda998x.txt b/Documentation/devicetree/bindings/display/bridge/tda998x.txt
>> index e9e4bce..35f6a80 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/tda998x.txt
>> +++ b/Documentation/devicetree/bindings/display/bridge/tda998x.txt
>> @@ -16,6 +16,35 @@ Optional properties:
>>
>>     - video-ports: 24 bits value which defines how the video controller
>>   	output is wired to the TDA998x input - default: <0x230145>
>> +	This property is not used when ports are defined.
>> +
>> +Optional nodes:
>> +
>> +  - port: up to three ports.
>> +	The ports are defined according to [1].
>> +
>> +    Video port.
>> +	There may be only one video port.
>> +	This one must contain the following property:
>> +
>> +	- port-type: must be "rgb"
>
> This should be implied from the port unit address. In other words,
> port@0 is defined to be the rgb port. Now, if this is one of several
> modes for the video port, then that is a different story.
>

Do you suggest that also the audio i2s and s/p-dif port-types should be 
coded in the port unit addresses? Something like: port@0 is always rgb, 
port@1 is i2s, and port@2 is spdif?

Having the port-type information explicitly written serves the purpose 
keeping the dts files human readable. Is saving couple of bytes this 
important or is there some other reason to not to have the port-type 
property?

>> +	and may contain the optional property:
>> +
>> +	- reg: 24 bits value which defines how the video controller
>> +		output is wired to the TDA998x input (video pins)
>> +		When absent, the default value is <0x230145>.
>
> This is not really how reg is intended to be used. Can you explain how
> this value is determined?
>

I never liked this unorthodox usage of reg property either. I'll replace 
the reg -properties with something more explicit.

>> +    Audio ports.
>> +	There may be one or two audio ports.
>> +	These ones must contain the following properties:
>> +
>> +	- port-type: must be "i2s" or "spdif"
>> +
>> +	- reg: 8 bits value which defines how the audio controller
>> +		output is wired to the TDA998x input (audio pins)
>
> Same here.
>
> Rob
>
