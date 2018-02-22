From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 1/4] dt-bindings: sound: add motorola,
	cpcap-audio-codec
Date: Thu, 22 Feb 2018 11:54:19 -0800
Message-ID: <20180222195418.GC5184@atomide.com>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
 <20180216113008.GB5886@sirena.org.uk>
 <20180216132537.lkd4wzfg7uuoyx7k@earth.universe>
 <20180216134448.GI5886@sirena.org.uk>
 <20180216141237.rd75sbix7bopi7zu@earth.universe>
 <20180216151609.GK5886@sirena.org.uk>
 <20180216155706.GS6364@atomide.com>
 <20180219130514.GC32761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20180219130514.GC32761@sirena.org.uk>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [180219 12:05]:
> On Fri, Feb 16, 2018 at 07:57:07AM -0800, Tony Lindgren wrote:
> > One advantage of using a compatible property for the pmic subdevices
> > though is that it leaves out a dependency between various device
> > drivers things happen automagically. The mfd core driver can be
> > minimal and just implement interrupt handling and regmap. So no need
> > to to parse the child nodes in the pmic mfd driver :)
> 
> There's no need to do that anyway - with a MFD the child devices can
> assume that they're part of the MFD and reference their parent.
> 
> > So personally I'd prefer the option that requires least amount
> > of custom code if compatible vs no compatible property is the
> > only issue here.
> 
> It's a few lines of code to register the child devices from code rather
> than the DT, and keeps it out of the ABI.

OK yeah that's a good point with avoiding the ABI. Seems
we still want the dts child node(s) though. That way audio
device can be disabled for devices where audio is not wired
up at all on this PMIC.

Regards,

Tony
