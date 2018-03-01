From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] arm: dts: omap3: Add missing #sound-dai-cells
Date: Thu, 1 Mar 2018 17:28:10 -0600
Message-ID: <CAL_Jsq+=dBEH_MFHDgZbNBb75hVzoXsyH-_qE7mKFuGtOixQsw@mail.gmail.com>
References: <20180301202537.30571-2-robh@kernel.org>
 <20180301223243.GI62820@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180301223243.GI62820@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, ARM-SoC Maintainers <arm@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 1, 2018 at 4:32 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Rob Herring <robh@kernel.org> [180301 12:26]:
>> dtc now gives the following warnings:
>>
>> arch/arm/boot/dts/omap3-gta04a3.dtb: Warning (sound_dai_property): /sound_telephony/simple-audio-card,cpu: Missing property '#sound-dai-cells' in node /ocp@68000000/mcbsp@49026000 or bad phandle (referred from sound-dai[0])
>> arch/arm/boot/dts/omap3-gta04a4.dtb: Warning (sound_dai_property): /sound_telephony/simple-audio-card,cpu: Missing property '#sound-dai-cells' in node /ocp@68000000/mcbsp@49026000 or bad phandle (referred from sound-dai[0])
>> arch/arm/boot/dts/omap3-gta04a5.dtb: Warning (sound_dai_property): /sound_telephony/simple-audio-card,cpu: Missing property '#sound-dai-cells' in node /ocp@68000000/mcbsp@49026000 or bad phandle (referred from sound-dai[0])
>>
>> Add the missing #sound-dai-cells property.
>
> Is this needed for the current -rc or is v4.17 OK?

4.17 is fine.

> Somehow I'm not seeing these with current -rc or next, is
> there some special option (not W=2 :) that you're using?

Upstream dtc which I'm working on syncing to for 4.17.

Rob
