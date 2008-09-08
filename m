From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 3/5] ALSA: ASoC: Add support for TWL4030
	audio codec (rev 3)
Date: Mon, 8 Sep 2008 11:16:17 -0700
Message-ID: <5e088bd90809081116v58ff6b14rd2331e5fccaeb097@mail.gmail.com>
References: <1220769704-16705-1-git-send-email-sakoman@gmail.com>
	<1220769704-16705-2-git-send-email-sakoman@gmail.com>
	<1220769704-16705-3-git-send-email-sakoman@gmail.com>
	<1220769704-16705-4-git-send-email-sakoman@gmail.com>
	<20080908095607.GC790@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20080908095607.GC790@sirena.org.uk>
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
To: sakoman@gmail.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 8, 2008 at 2:56 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Sat, Sep 06, 2008 at 11:41:42PM -0700, sakoman@gmail.com wrote:
>
>> +
>> +config SND_SOC_TWL4030
>> +     tristate
>> +     depends on SND_SOC && I2C
>> +
>
> Sorry, didn't notice earlier: this should depend on whatever the config
> option is for the TWL4030 core driver rather than on I2C since it
> doesn't actually interact with I2C directly.  Although in most
> applications this won't make much odds since the machine driver will
> select the codec driver and select ignores the dependencies anyway.

You are correct.  Good catch, though as you say it doesn't really
matter in practice.

I will re-submit a version with this fixed nonetheless.

Steve
