From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v3 0/8] Beaglebone-Black HDMI audio
Date: Mon, 27 Jan 2014 18:17:54 +0200
Message-ID: <52E686B2.9060806@ti.com>
References: <y> <cover.1390836773.git.jsarha@ti.com>
 <52E6806A.2090109@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <52E6806A.2090109@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: detheridge@ti.com, alsa-devel@alsa-project.org, Jean-Francois Moine <moinejf@free.fr>, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/27/2014 05:51 PM, Lars-Peter Clausen wrote:
> Hi,
>
> I think you should try to get this in sync with the work Jean-Francois is
> currently doing[1]. Having the HDMI transmitter register a CODEC device is
> definitely the right approach, compared to the rather 'interesting'
> constraints stuff you do in patch 4.
>

Oh, Jean-Francois's patches are now out. I'll take those into use, but I 
am afraid it still does not save me from the constraint stuff.

The most complex piece of code comes from limited sample-rate 
availability, which is coming Beaglebone-Black desing (available i2s 
master clock), not from the HDMI encoder itself. It does not help with 
the stereo only limitation either, because it comes from the one wire 
only audio data connection on BBB.

Support for S16_LE could maybe be added if the tda998x specific codec 
would fiddle with CTS_N predivider-setting (K select) according to the 
used sample width. But it appears Cobox plays all the sample formats 
fine without this change, so the question is if playing around with 
CTS_N predivider would break already working support there (something to 
be tested).


Best regards,
Jyri
