From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH RFC v3 0/8] Beaglebone-Black HDMI audio
Date: Mon, 27 Jan 2014 17:32:00 +0100
Message-ID: <52E68A00.5030207@metafoo.de>
References: <y> <cover.1390836773.git.jsarha@ti.com>
	<52E6806A.2090109@metafoo.de> <52E686B2.9060806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <52E686B2.9060806@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, dri-devel@lists.freedesktop.org, broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/27/2014 05:17 PM, Jyri Sarha wrote:
> On 01/27/2014 05:51 PM, Lars-Peter Clausen wrote:
>> Hi,
>>
>> I think you should try to get this in sync with the work Jean-Francois is
>> currently doing[1]. Having the HDMI transmitter register a CODEC device is
>> definitely the right approach, compared to the rather 'interesting'
>> constraints stuff you do in patch 4.
>>
> 
> Oh, Jean-Francois's patches are now out. I'll take those into use, but I am
> afraid it still does not save me from the constraint stuff.
> 
> The most complex piece of code comes from limited sample-rate availability,
> which is coming Beaglebone-Black desing (available i2s master clock), not
> from the HDMI encoder itself. It does not help with the stereo only
> limitation either, because it comes from the one wire only audio data
> connection on BBB.
> 
> Support for S16_LE could maybe be added if the tda998x specific codec would
> fiddle with CTS_N predivider-setting (K select) according to the used sample
> width. But it appears Cobox plays all the sample formats fine without this
> change, so the question is if playing around with CTS_N predivider would
> break already working support there (something to be tested).

The ASoC core will set the constraints for the audio format/rate to the
intersection of what is supported by the CODEC and the CPU DAI. So if the
limitation comes from the CPU DAI the constraints should be applied there
and not in the machine driver. Similar if the tda998x only supports 32 bit
samples it should advertise this and the compound card will only support 32
bit samples.

- Lars
