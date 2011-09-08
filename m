From: Mans Rullgard <mans.rullgard@linaro.org>
Subject: Re: [PATCH v2] ASoC: omap: convert per-board modules
	to platform drivers
Date: Thu, 8 Sep 2011 20:08:17 +0100
Message-ID: <CAG5Tg6XMwDi_VhJ8vChDgeL6_CPcwAY3j=i6vzBnsXqoxF4cyw@mail.gmail.com>
References: <1315503297-8365-1-git-send-email-mans.rullgard@linaro.org>
	<CABb+yY0b607kDSGU+trycqQuvGMhC-zpHcv20wjgmEcaK7dz8Q@mail.gmail.com>
	<20110908181831.GE3591@opensource.wolfsonmicro.com>
	<CAJe_Zhcq5ekv0TvUtYBaLb1=xrieiBrVTG0XrUHQCqRWJZ0Q0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAJe_Zhcq5ekv0TvUtYBaLb1=xrieiBrVTG0XrUHQCqRWJZ0Q0A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linaro-dev@lists.linaro.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 8 September 2011 19:35, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 8 September 2011 23:48, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Thu, Sep 08, 2011 at 11:47:16PM +0530, Jassi Brar wrote:
>>
>>> Can't we do by having omap_init_audio() in arch/arm/mach-omap2/devices.c
>>> generate a platform device of name depending upon machine_is_* ?
>>
>> That's not a bad idea. =A0If we were going to do that it shouldn't be OM=
AP
>> specific, any platform could use it. =A0Though we'd need a way to overri=
de
>> it to provide platform data on systems that needs it.
> Perhaps by providing an optional call, say set_asoc_platdata(void *pdata),
> that boards could call from their init_machine() ?

That seems like a sensible approach to me.

-- =

Mans Rullgard
Multimedia
mans.rullgard@linaro.org
