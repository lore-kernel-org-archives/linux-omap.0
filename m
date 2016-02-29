From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v5 4/8] drm/i2c: tda998x: Add support
 of a DT graph of ports
Date: Mon, 29 Feb 2016 12:36:10 +0200
Message-ID: <56D41F1A.2030100@ti.com>
References: <cover.1455720381.git.jsarha@ti.com>
 <842e221030a0b14bc862790eb2f5bc97bb29c012.1455720381.git.jsarha@ti.com>
 <20160218143530.GB9654@rob-hp-laptop> <56CF04DA.8080905@ti.com>
 <20160226004311.GM5783@n2100.arm.linux.org.uk> <56D02594.4020407@ti.com>
 <20160226112159.GO5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160226112159.GO5783@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, moinejf@free.fr, peter.ujfalusi@ti.com, devicetree@vger.kernel.org, airlied@linux.ie, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 02/26/16 13:21, Russell King - ARM Linux wrote:
> On Fri, Feb 26, 2016 at 12:14:44PM +0200, Jyri Sarha wrote:
>> On 02/26/16 02:43, Russell King - ARM Linux wrote:
>>> On Thu, Feb 25, 2016 at 03:42:50PM +0200, Jyri Sarha wrote:
>>>> On 02/18/16 16:35, Rob Herring wrote:
>>>>> This should be implied from the port unit address. In other words,
>>>>> port@0 is defined to be the rgb port. Now, if this is one of several
>>>>> modes for the video port, then that is a different story.
>>>>>
>>>>
>>>> Do you suggest that also the audio i2s and s/p-dif port-types should be
>>>> coded in the port unit addresses? Something like: port@0 is always rgb,
>>>> port@1 is i2s, and port@2 is spdif?
>>>
>>> For the audio inputs, the port address corresponds to the input pin.
>>> TDA998x devices can have multiple streams routed to the pins, and can
>>> select between them.
>>>
>>> For example, there may be four I2S data pins and one I2S clock pin.
>>> When using stereo, you can select which of the four I2S data pins
>>> carries the audio data.
>>>
>>
>> Sure, but I do not think that would be the usual setup. The only "normal"
>> situation I can think for having a need to have two alternative audio se=
tups
>> would one for i2s and another for s/p-dif. But then again it is possible=
 to
>> come up with a design with multiple alternative audio wirings and it
>> relatively simple handle that in DT binding, so why not.
>
> There's another reason: if you want to support 8 channel audio using I2S
> rather than SPDIF, then you need to use four I2S data inputs.  Each I2S
> data input can support only two channels.
>

Yes, but surely in the situation where there is 4 data wires, those =

should all be seen as a single audio port, as they are all sharing the =

same bit and frame clock wires. In such a situation I can't see why we =

would ever want to configure anything less that all four connected =

wires. ALSA and CPU=97DAI driver can then deal with the situations when we =

only have two channels of data, or the HDMI sink can only play stereo.

If we start to think how to describe multiple alternative endpoints for =

I have to have a unit address, but do I have to have a reg property? I =

did not know about such a rule when I already made an alternative =

binding and implementation that appears to work just fine with multiple =

ports without reg property, but maybe I have over looked some piece of =

specification that forbids that.essentially the same entity (=3Dthe single =

i2s port, with up to 4 data wires), then there is no upper limit to the =

amount of ports we'd need to support.

On the other hand, if there are multiple i2s components sharing the same =

clock wires (and maybe some data wires with TDM too), then graph-style =

binding is probably not the best way to describe that kind of setup.

The more I think about this the more I think the graph binding is a bad =

choice to for i2s connections. For SPDIF the graph works better, but why =

use something that does not work for every DAI format?

>>> When using SPDIF, there may be two SPDIF inputs, and you can select
>>> which SPDIF input is used.
>>>
>>> So, "reg" may not be an address in terms of a CPU visible address, but
>>> it's an address as far as selecting the appropriate input - and it
>>> fits in with the requirements of ePAPR, which are that if you have
>>> a unit-address (which is required to distinguish different port nodes)
>>> then you must have a matching "reg" property.
>>
>> Still I do not see why it is desirable to reuse reg property, when we can
>> introduce new property for describing the audio wiring.
>
> Different people have different opinions.  Your opinion is just another
> example of someone holding a different view.
>
> You _have_ to have a unit address, and therefore you _have_ to have a
> reg property.  If you want to use some other property to describe the

I have to have a unit address, but do I have to have a reg property? I =

did not know about such a rule when I already made an alternative =

binding and implementation that appears to work just fine with multiple =

ports without reg property, but maybe I have over looked some piece of =

specification that forbids that.

> audio input pin, then you will need to make up a totally ficticious
> unit-address and reg property for each audio input pin.
>
> That's adding complexity, arguably unnecessary complexity, and making
> the binding unnecessarily more complex for no good reason.
>
>>> I don't particularly like the video node using the RGB routing register
>>> value either for the reg property, but I've kept quiet because I have
>>> nothing to offer there: again, this comes down to ePAPR requirements
>>> and the need to specify multiple "port { }" nodes.  You can't have two
>>> "port { }" nodes without using a unit-address, and we'd need to chose
>>> a unit-address for it which doesn't conflict with the audio ports...
>>> so there's a kind of logic to using the RGB routing value, which will
>>> never conflict.
>>>
>>
>> If we after all decide to go with using reg property for audio wiring (a=
nd
>> essentially writing the value directly to AP_ENA register), then we could
>> also agree that video port's unit address is always 0 as it corresponds =
to
>> audio disabled in AP_ENA register and would not collide with any audio
>> "address". Then we could keep the old video-ports property to configure =
the
>> video wiring. How does this sound?
>
> Sub-standard :)
>
> This has actually been discussed before.  See the thread:
>
> "[PATCH v9 1/4] drm/i2c: tda998x: Add DT support for audio"
>
> from January 2015.
>

Yes, this started sound strangely familiar :). Well, I've been trying to =

come up with an upstremable implementation for Beaglebone-Black HDMI =

audio for almost three years already. At this point I am ready to make =

almost what ever compromise if I just could get the code in. I just want =

to explain my point of view.

Luckily the HDMI-codec part is mostly agnostic about these things so =

maybe I can have life of its own.

Best regards,
Jyri
