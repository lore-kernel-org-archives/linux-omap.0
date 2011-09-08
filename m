From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2] ASoC: omap: convert per-board modules to platform
	drivers
Date: Fri, 9 Sep 2011 00:05:17 +0530
Message-ID: <CAJe_Zhcq5ekv0TvUtYBaLb1=xrieiBrVTG0XrUHQCqRWJZ0Q0A@mail.gmail.com>
References: <1315503297-8365-1-git-send-email-mans.rullgard@linaro.org>
	<CABb+yY0b607kDSGU+trycqQuvGMhC-zpHcv20wjgmEcaK7dz8Q@mail.gmail.com>
	<20110908181831.GE3591@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110908181831.GE3591@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jarkko Nikula <jhnikula@gmail.com>, linaro-dev@lists.linaro.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 8 September 2011 23:48, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Sep 08, 2011 at 11:47:16PM +0530, Jassi Brar wrote:
>
>> Can't we do by having omap_init_audio() in arch/arm/mach-omap2/devices.c
>> generate a platform device of name depending upon machine_is_* ?
>
> That's not a bad idea. =A0If we were going to do that it shouldn't be OMAP
> specific, any platform could use it. =A0Though we'd need a way to override
> it to provide platform data on systems that needs it.
Perhaps by providing an optional call, say set_asoc_platdata(void *pdata),
that boards could call from their init_machine() ?
