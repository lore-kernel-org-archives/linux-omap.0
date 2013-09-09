From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
Date: Mon, 9 Sep 2013 14:50:51 -0500
Message-ID: <522E269B.7000802@ti.com>
References: <1378736961-21005-1-git-send-email-koen@dominion.thruhere.net>
 <87zjrm81dl.fsf@linaro.org>
 <BBAC0939-A4F9-4FEA-B137-0307D8787DC3@dominion.thruhere.net>
 <522E1325.8050906@ti.com>
 <41952E65-1037-4117-A1AE-8310FED59E3A@dominion.thruhere.net>
 <522E18C0.9010909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <522E18C0.9010909@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, linux@arm.linux.org.uk, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, bcousson@baylibre.com, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/09/2013 01:51 PM, Joel Fernandes wrote:
> On 09/09/2013 01:43 PM, Koen Kooi wrote:
>>
>> Op 9 sep. 2013, om 20:27 heeft Joel Fernandes <joelf@ti.com> het volgende geschreven:
>>
>>> On 09/09/2013 10:51 AM, Koen Kooi wrote:
>>>>
>>>> Op 9 sep. 2013, om 17:23 heeft Kevin Hilman <khilman@linaro.org> het volgende geschreven:
>>>>
>>>>> Koen Kooi <koen@dominion.thruhere.net> writes:
>>>>>
>>>>>> The BeagleBone Black is basically a regular BeagleBone with eMMC and HDMI added,
>>>>>> so create a common dtsi both can use.
>>>>>>
>>>>>> IMPORTANT: booting the existing am335x-bone.dts will blow up the HDMI transceiver
>>>>>> after a dozen boots with an uSD card inserted because LDO will be at 3.3V instead
>>>>>> of 1.8.
>>>>>>
>>>>>> MMC support for AM335x still isn't in, so only the LDO change has been added.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>>
>>>>>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>>>>>> Tested-by: Tom Rini <trini@ti.com>
>>>>>> Tested-by: Matt Porter <matt.porter@linaro.org>
>>>>>
>>>>> I guess the subject should've included v5?
>>>>
>>>> Yes, I blame it on being monday :)
>>>
>>> The series you're posting will require rebasing on the current MMC DT series
>>> that is being discussed last couple of weeks on the mailing list which were
>>> waiting until now as DMA support was missing. Now that DMA support is pulled in,
>>> it is safe to apply those patches so I will be reposting them shortly.
>>>
>>> Please hold off any changes until those patches are posted. This will avoid
>>> unnecessary conflicts.
>>
>> Or you can rebase on top of this patch since it has no dependencies *and* fixes blowing up boards. FWIW, git-rebase, git-cherry-pick and git-am -3 track the rename in my patch just fine.
>>
> 
> That's fair enough, since  Kevin Acked and Benoit is pulling it, I'm fine with
> rebasing on top of it and we avoid any merge conflicts.
> 

I noticed - there were still some comments from Felipe on the v4 series of this
patch regarding RF cape and HDMI may be breaking it. How are you addressing that?

Regards,

-Joel
