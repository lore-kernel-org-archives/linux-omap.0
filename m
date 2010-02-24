From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: Re: [PATCHv4 1/7] OMAP4: PMIC: Add support for twl6030
	codec
Date: Wed, 24 Feb 2010 15:43:14 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65DD218C@dlee06.ent.ti.com>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B13@dlee06.ent.ti.com>
	<1267006169.3274.88.camel@odin> <20100224111328.GA2950@sortiz.org>
	<20100224132246.GG9018@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100224132246.GG9018@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Mark,

I'll re-submit the patch series using twl6040_codec instead of twl6030_codec, twl6030 is the power companion chip and twl4030 is the audio chip, so in the case of this patch should I send an incremental patch to rename it?

Regards,
Margarita

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, February 24, 2010 7:23 AM
> To: Samuel Ortiz
> Cc: Liam Girdwood; Olaya, Margarita; alsa-devel@alsa-project.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCHv4 1/7] OMAP4: PMIC: Add support for twl6030 codec
> 
> On Wed, Feb 24, 2010 at 12:13:29PM +0100, Samuel Ortiz wrote:
> 
> > > Samuel are you OK with this ?
> 
> > That seems fine, yes.
> > Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> 
> OK, I've applied this one now - the cross tree issues mean it seems
> better to get into 2.6.34.  I'll review the rest of the patches now.
