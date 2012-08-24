From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC] ASoC: snd_soc_jack for HDMI audio: does it
 make sense?
Date: Thu, 23 Aug 2012 20:57:20 -0600
Message-ID: <5036ED90.4080508@wwwdotorg.org>
References: <5032E8A5.8070108@ti.com> <1345528867.15491.12.camel@lappyti>
 <CAO8GWq=B8wa1tWOiT5ja80T2VrxHiSKSp4U6fHydV9iyOg=+Zg@mail.gmail.com>
 <50342E9A.9010707@ti.com> <s5htxvv8iot.wl%tiwai@suse.de>
 <5036DC80.90200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5036DC80.90200@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Brown, Mark" <broonie@opensource.wolfsonmicro.com>, DRI development list <dri-devel@lists.freedesktop.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Clark, Rob" <rob@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On 08/23/2012 07:44 PM, Ricardo Neri wrote:
> On 08/22/2012 02:55 AM, Takashi Iwai wrote:
>> At Tue, 21 Aug 2012 19:58:02 -0500,
>> Ricardo Neri wrote:
...
>>> Maybe the lack of audio support in drm is because the audio users should
>>> not talk to drm directly but to a lower level component (omapdrm,
>>> omapdss?). However, today there exists video technology supports audio
>>> as well, such as DisplayPort or HDMI. Could it make more sense now to
>>> provide audio support?
>>
>> The reason is that the audio and video handling are already separated
>> in the hardware level, at least, for desktop graphics.
> 
> Separated in what sense? Do they have separate register banks in

For NVIDIA desktop GPUs, this is certainly true, and I think so for any
Intel Azalia/HDA controller. The separate register banks are in
different PCI functions on the chip. The Intel Azalia/HDA spec also
architects specific ways that the audio and video parts interact (i.e.
ELD representation of EDID data, unsolicited response messages when the
video state changes, etc.) Oh, I see Takashi mentioned this below.

> independent power domains?

Most likely yes.

> Can audio an video work with complete
> independence. What happens if someone decides to power off video. Is the
> audio able to continue if required?

I believe audio DMA isn't affect by the video state, but I'm not 100%
sure of that.

>> The audio infoframe is passed via ELD to the audio controller part
>> upon plug/unplugging via HD-audio unsolicited event, and the audio
>> driver sets up the stuff according to the given ELD.  Thus no extra
>> interface between drm and ALSA was required in the kernel API level,
>> so far.
> 
> I see that the unsolicited event is used only to parse the EDID,
> correct? It also notifies about the jack status. Hence, if there the
> cable is disconnected the application will know and act accordingly. Is
> this understanding correct?

The kernel will know, and then passes the information on to user-space.
