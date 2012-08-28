From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ams-delta: fix card initalization
 failure
Date: Tue, 28 Aug 2012 11:13:39 -0700
Message-ID: <20120828181338.GB8796@opensource.wolfsonmicro.com>
References: <1346102910-8610-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <20120827213835.GE4400@opensource.wolfsonmicro.com>
 <3048168.EXxi4fR4e7@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <3048168.EXxi4fR4e7@acer>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 28, 2012 at 05:13:05PM +0200, Janusz Krzysztofik wrote:
> On Mon, 27 Aug 2012 14:38:35 Mark Brown wrote:
> > On Mon, Aug 27, 2012 at 11:28:30PM +0200, Janusz Krzysztofik wrote:

> > > -	platform_set_drvdata(ams_delta_audio_platform_device,
> > > -				&ams_delta_audio_card);

> > The real fix here is that you should be using platform data here, not
> > driver data.  Is there some reason not to do that?

> Do you think the change you propose is suitable for the rc cycle? I'm 
> trying to fix a regression in the first place. Converting the ams-delta 
> asoc to a platform driver is on my todo list and I'm going to take care 
> of this as soon as I have enough spare time.

The above looks like you already have a platform driver?  All I'm
suggesting is changing the above to use platform rather than driver
data.
