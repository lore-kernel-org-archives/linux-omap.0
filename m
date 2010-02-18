From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 18 Feb 2010 09:14:17 -0800
Message-ID: <20100218171417.GP21755@atomide.com>
References: <1266417960-22787-1-git-send-email-ilkka.koskinen@nokia.com>
	<1266417960-22787-2-git-send-email-ilkka.koskinen@nokia.com>
	<20100218002543.GG21755@atomide.com>
	<alpine.DEB.2.00.1002181244400.13895@tumpelo.nmp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1002181244400.13895@tumpelo.nmp.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ilkka Koskinen <ikoskine@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

* Ilkka Koskinen <ikoskine@nokia.com> [100218 02:54]:
> 
> Hi,
> 
> On Thu, 18 Feb 2010, ext Tony Lindgren wrote:
> >* Ilkka Koskinen <ilkka.koskinen@nokia.com> [100217 06:41]:
> >>From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> >>
> >>Add sidetone feature to McBSP instances 2 and 3 on OMAP3 based devices.
> >>
> >>Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
> >
> >This one looks good to me and can be merged via Alsa list along with
> >the other patch.
> >
> >Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Is that easiest way to do that? I mean, I'm afraid that the ALSA
> tree doesn't have Janusz Krzysztofik's McBSP register cache patches
> nor does it have your "omap3: Replace ARCH_OMAP34XX with ARCH_OMAP3"
> patch either.
> 
> Anyway, I'll send the updated patches still today.

OH, that's right, I totally forgot about that. Sounds like I should
add them both to omap for-next once everybody is happy.

Regards,

Tony
