From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 2/6] dt-bindings: sound: add motorola,
	cpcap-audio-codec
Date: Thu, 10 Aug 2017 09:53:59 -0700
Message-ID: <20170810165358.GK8569@atomide.com>
References: <20170725151030.26863-1-sebastian.reichel@collabora.co.uk>
 <20170725151030.26863-3-sebastian.reichel@collabora.co.uk>
 <20170726114827.pye3jm2b7x2nqo5v@sirena.org.uk>
 <20170727090141.sxzm6mq5cv4jzucg@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20170727090141.sxzm6mq5cv4jzucg@earth>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170727 02:02]:
> Hi,
> 
> On Wed, Jul 26, 2017 at 12:48:28PM +0100, Mark Brown wrote:
> > On Tue, Jul 25, 2017 at 05:10:26PM +0200, Sebastian Reichel wrote:
> > > Motorola CPCAP is a PMIC with audio functionality, that can be
> > > found on Motorola Droid 4 and probably a few other phones from
> > > Motorola's Droid series.
> > 
> > Please submit patches using subject lines reflecting the style for the
> > subsystem.  This makes it easier for people to identify relevant
> > patches.  Look at what existing commits in the area you're changing are
> > doing and make sure your subject lines visually resemble what they're
> > doing.
> 
> Right, I did not notice, that ASoC does not follow general
> "dt-bindings: <subsys>:" DT bindings subject style. How
> do Rob and Mark find them?
> 
> > > +&cpcap {
> > > +	audio-codec {
> > > +		compatible = "motorola,cpcap-audio-codec";
> > > +		vdd-supply = <&vaudio>;
> > > +	};
> > > +};
> > 
> > I'd expect supplies (especially generically named supplies like this) to
> > be looked up at the chip level - aside from my general concerns with MFD
> > subnodes like this in the case of supplies it's especially problematic
> > as it makes it harder to do the generic chip level hookup in the DT and
> > it precludes other parts of the chip using the same supply (which seems
> > especially likely with a generically named supply like this).
> 
> I don't follow you here. Why can't other parts of the chip use the
> same supply? Regarding the other point: Handling the audio-codec
> differently than all other sub-modules of cpcap seems much more
> problematic to me and the codec is basically the last one
> missing:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi

Mark, any comments on the above? I'm just wondering if the
related dts changes are safe for me to pick.

Regards,

Tony
