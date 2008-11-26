From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 09:24:03 -0800
Message-ID: <5e088bd90811260924u28a081bej62689470551b6982@mail.gmail.com>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
	<20081126110854.GA6234@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20081126110854.GA6234@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 26, 2008 at 3:08 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Wed, Nov 26, 2008 at 06:47:58PM +0800, Stanley.Miao wrote:
>> Add a shared omap SoC driver to avoid reduplicate code among omap soc drivers.
>
> It's really good to see work on this but I've got some concerns with the
> approach being taken here.

I too have concerns.

The SoC drivers are very much alike at the moment because only the
minimum subset of twl4030 functionality is supported.

As we flesh out the twl4030 features (see the other twl4030 codec
driver threads on this list) I expect the machine specific drivers to
begin to diverge (radically in some cases) based upon the hardware
features of each.

I'm all for factoring out common code, but I think that this approach
will become a maintenance nightmare over time.

Steve
