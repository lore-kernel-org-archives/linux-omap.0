From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 3/5] SOUND: SOC: CODECS: Add support for
	the TWL4030 audio codec
Date: Fri, 5 Sep 2008 07:16:49 -0700
Message-ID: <5e088bd90809050716r6b14c382s4648c019552ec3f6@mail.gmail.com>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com>
	<1220504520-6067-2-git-send-email-sakoman@gmail.com>
	<1220504520-6067-3-git-send-email-sakoman@gmail.com>
	<1220504520-6067-4-git-send-email-sakoman@gmail.com>
	<20080904120441.GB21663@sirena.org.uk>
	<5e088bd90809040748u5f487c4fy3f347b851a8d7d7b@mail.gmail.com>
	<20080905100646.GC12383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20080905100646.GC12383@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Sakoman <sakoman@gmail.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 5, 2008 at 3:06 AM, Mark Brown <broonie@sirena.org.uk> wrote:

>> How about I add a "TODO" on this?  I'm swamped for the next few weeks
>> and won't be able to give it the attention it deserves test-wise.

> If there aren't any bypass paths then it should be fine to leave it
> as-is.

There are no bypass paths, so I will leave it as is for now.

I plan to get back to this in a few weeks and will then implement
proper BIAS_PREPARE and BIAS_STANDBY support.

Steve
