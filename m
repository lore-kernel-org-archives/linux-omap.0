From: Mans Rullgard <mans.rullgard@linaro.org>
Subject: Re: [PATCH v2] ASoC: omap: convert per-board modules
	to platform drivers
Date: Thu, 8 Sep 2011 20:26:34 +0100
Message-ID: <CAG5Tg6WjGk71QPOQHoLiMhsUo=49yhyeao_B3aQ+BScJA2xPPw@mail.gmail.com>
References: <1315503297-8365-1-git-send-email-mans.rullgard@linaro.org>
	<CABb+yY0b607kDSGU+trycqQuvGMhC-zpHcv20wjgmEcaK7dz8Q@mail.gmail.com>
	<CAG5Tg6UOuztenNid1=YbH9a4ZH5MqV4YhohG+r9R+7F=zXs=CQ@mail.gmail.com>
	<CAJe_ZhdGaKFU9kVii83KX+TmN9_edcfCU8TohEzJ4oKaQTEgHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAJe_ZhdGaKFU9kVii83KX+TmN9_edcfCU8TohEzJ4oKaQTEgHw@mail.gmail.com>
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

On 8 September 2011 20:17, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 9 September 2011 00:35, Mans Rullgard <mans.rullgard@linaro.org> wrote:
>> On 8 September 2011 19:17, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>>> On Thu, Sep 8, 2011 at 11:04 PM, Mans Rullgard <mans.rullgard@linaro.or=
g> wrote:
>>>> This converts the per-board modules to platform drivers for a
>>>> device created by in main platform setup. =A0These drivers call
>>>> snd_soc_register_card() directly instead of going via a "soc-audio"
>>>> device and the corresponding driver in soc-core.
>>>>
>>>> Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>
>>>> ---
>>>> Platform device names fixed.
>>>> N8x0 changed to get clocks before registering card.
>>>> ---
>>>> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A06 ++
>>>> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A06 ++
>>>> =A0arch/arm/mach-omap2/board-am3517evm.c =A0 =A0 =A0 =A0| =A0 =A07 +++
>>>> =A0arch/arm/mach-omap2/board-devkit8000.c =A0 =A0 =A0 | =A0 =A06 ++
>>>> =A0arch/arm/mach-omap2/board-igep0020.c =A0 =A0 =A0 =A0 | =A0 =A06 ++
>>>> =A0arch/arm/mach-omap2/board-n8x0.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06=
 ++
>>>> =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0 =A0| =A0 =A06 ++
>>>> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 =A0 =A0 | =A0 =A07 +++
>>>> =A0arch/arm/mach-omap2/board-omap3pandora.c =A0 =A0 | =A0 =A06 ++
>>>> =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 17 +=
+++++
>>>> =A0arch/arm/mach-omap2/board-rx51.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06=
 ++
>>>> =A0arch/arm/mach-omap2/board-zoom-peripherals.c | =A0 =A06 ++
>>>
>>> Can't we do by having omap_init_audio() in arch/arm/mach-omap2/devices.c
>>> generate a platform device of name depending upon machine_is_* ?
>>
>> I had the same thought, but I couldn't find a suitable string anywhere.
>> Are you suggesting an if(machine_is_foo()) cascade in omap_init_audio()?
> Yes. And you could assign same names as you do now in board init files.

This would still be omap-specific though, but perhaps that can be
acceptable for now.  Longer term, I guess this is a candidate for
device tree.

-- =

Mans Rullgard
Multimedia
mans.rullgard@linaro.org
