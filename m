From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Audio capture not working with AIC23/McBSP1
	on	OMAP3517
Date: Wed, 26 Aug 2009 18:49:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D83F@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D82D@dbde02.ent.ti.com>
	<20090826130356.GB29299@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090826130356.GB29299@sirena.org.uk>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, August 26, 2009 6:34 PM
> To: Aggarwal, Anuj
> Cc: linux-omap@vger.kernel.org; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Audio capture not working with AIC23/McBSP1 on
> OMAP3517
> 
> On Wed, Aug 26, 2009 at 06:30:52PM +0530, Aggarwal, Anuj wrote:
> 
> > I am trying to capture audio through LineIn on my OMAP3517 EVM, using
> > AIC23 codec and McBSP1, and getting the following error:
> 
> > arecord: pcm_read:1529: read error: Input/output error
> 
> That suggests that DMA isn't happening - might be worth checking to see
> that clocks are being generated properly.
I am able to see the bit clock and frame sync coming properly.
>
> 
> > Playback is working fine using the same combination.
> 
> > I have tried using another instance of AIC23 codec which uses McBSP2
> > and both playback & capture works fine there.
> 
> > Has anyone faced this issue before? Any suggestions?
> 
> Which kernel are you using?  There are rather a lot of McBSP changes
> queued up for 2.6.32.  If this ever worked in the past a git bisect
> might be interesting.
I am on 2.6.31-rc5. I have to check whether the new patches fix 
anything related to this.
