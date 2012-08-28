From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] ASoC: ams-delta: fix card initalization
	failure
Date: Tue, 28 Aug 2012 17:13:05 +0200
Message-ID: <3048168.EXxi4fR4e7@acer>
References: <1346102910-8610-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <20120827213835.GE4400@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120827213835.GE4400@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 27 Aug 2012 14:38:35 Mark Brown wrote:
> On Mon, Aug 27, 2012 at 11:28:30PM +0200, Janusz Krzysztofik wrote:
> 
> > -	platform_set_drvdata(ams_delta_audio_platform_device,
> > -				&ams_delta_audio_card);
> > -
> > -	ret = platform_device_add(ams_delta_audio_platform_device);
> > -	if (ret)
> > -		goto err;
> 
> The real fix here is that you should be using platform data here, not
> driver data.  Is there some reason not to do that?

Mark,

Do you think the change you propose is suitable for the rc cycle? I'm 
trying to fix a regression in the first place. Converting the ams-delta 
asoc to a platform driver is on my todo list and I'm going to take care 
of this as soon as I have enough spare time.

Thanks,
Janusz
