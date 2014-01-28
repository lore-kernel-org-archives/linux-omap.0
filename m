From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v3 4/8] ASoC: davinci-evm: HDMI audio
 support for TDA998x trough McASP I2S bus
Date: Tue, 28 Jan 2014 09:47:13 +0200
Message-ID: <52E76081.3030905@ti.com>
References: <cover.1390836773.git.jsarha@ti.com>
 <86fcca2ecf302a695e7fd8199a1d635a67bbfcc8.1390836773.git.jsarha@ti.com>
 <20140127204910.GB11841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20140127204910.GB11841@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: detheridge@ti.com, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/27/2014 10:49 PM, Mark Brown wrote:
> On Mon, Jan 27, 2014 at 05:37:53PM +0200, Jyri Sarha wrote:
>> Add machine driver support for BeagleBone-Black and other boards with
>> tilcdc support and NXP TDA998X HDMI transmitter connected to McASP
>> port in I2S mode. McASP produces the bit clock for the i2s bus from
>> the masted clock by a simple divider and the available sample rates
>
> I have to say I agree with Lars' comments about where the code to set
> the constraints is here - I don't doubt that these limitations are valid
> but it would be better to factor them into the relevant chip drivers so
> that other systems with similar limitations can be handled correctly
> too.
>

Ok, I'll push them into mcasp driver then.

Thanks,
Jyri
