From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v3 0/8] Beaglebone-Black HDMI audio
Date: Mon, 27 Jan 2014 21:31:59 +0200
Message-ID: <52E6B42F.4050901@ti.com>
References: <y>	<cover.1390836773.git.jsarha@ti.com>	<52E6806A.2090109@metafoo.de>	<52E686B2.9060806@ti.com>
 <20140127190641.273890c6@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20140127190641.273890c6@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: detheridge@ti.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/27/2014 08:06 PM, Jean-Francois Moine wrote:
> On Mon, 27 Jan 2014 18:17:54 +0200
> Jyri Sarha <jsarha@ti.com> wrote:
>
>> Support for S16_LE could maybe be added if the tda998x specific codec
>> would fiddle with CTS_N predivider-setting (K select) according to the
>> used sample width. But it appears Cobox plays all the sample formats
>> fine without this change, so the question is if playing around with
>> CTS_N predivider would break already working support there (something to
>> be tested).
>
> Jyri,
>
> Setting
>
> 	cts_n = CTS_N_M(3) | CTS_N_K(1);
>
> instead of K(3) in the I2S sequence of tda998x_configure_audio() in the
> tda998x driver works fine for me with S16_LE and S24_LE.
>
> Does this solve your problem?
>

With that setting S16_LE works, but S32_LE does not. S24_LE does not 
really work at all on BBB, or it works but because the 8 most 
significant bits are zero the audio output is attenuated by 48 dB.

On the other hand S24_3LE does work, but then the problem is the clock 
rate support. On BBB the McASP IP is the bit clock master and provides 
the bit clock by simple divider from 24.576MHz oscillator. With 24 bit 
samples neither 44100 or 48000Hz sample rate can be supported (on the 
other hand 32kHz could be supported 24576000 % (24*2*32000) = 0).

The BBB HW price has squeezed so low that it can only implement the most 
basic use cases.

I would suggest to leave the CTS_N_K to the current setting (3), unless 
we can change the CTS_N_K on the fly according to the used sample format.

Best regards,
Jyri
