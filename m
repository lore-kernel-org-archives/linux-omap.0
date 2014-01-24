From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI
 audio support for TDA998x trough McASP I2S bus
Date: Fri, 24 Jan 2014 14:57:09 +0200
Message-ID: <52E26325.4040203@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>	<d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>	<20131231132555.GA31886@sirena.org.uk>	<52D67099.1040904@ti.com>	<20140115165100.3bfab96f@armhf>	<52DF8D60.9020505@ti.com>	<20140122111953.238349a5@armhf>
 <20140122114647.20f75d0d@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20140122114647.20f75d0d@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On 01/22/2014 12:46 PM, Jean-Francois Moine wrote:
> On Wed, 22 Jan 2014 11:19:53 +0100
> Jean-Francois Moine <moinejf@free.fr> wrote:
>
>> As both I2S and S/PDIF may be used for HDMI output in the Cubox,
>> I wrote a tda998x CODEC which gets the audio ports from the DT and
>> dynamically sets these ports and the audio type (i2s / spdif) on audio
>> streaming start. I have not submitted yet this codec and the associated
>> changes in tda998x, because I am waiting for a first patch series on the
>> tda998x to be applied
>> (http://lists.freedesktop.org/archives/dri-devel/2014-January/051552.html).
>
> Sorry, the last patch request is
>
> http://lists.freedesktop.org/archives/dri-devel/2014-January/052201.html
>

I checked the sample format support again with and without your patches.

On my other TV all the formats produce something that sounds Ok if you 
do not listen too carefully or use sine sweep etc. make the short 
comings audible. The other TV is completely silent when playing the "non 
supported" formats.

Could you give me a link to a git repo with your tda998x codec code so I 
could prepare to use that too?

Best regards,
Jyri
