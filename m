From: =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [PATCH 0/2] ARM: dts: omap3-overo: Add pwm-leds and audio support
Date: Wed, 06 Feb 2013 15:26:43 +0100
Message-ID: <51126823.6070605@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <5101273A.9090800@ti.com> <510F7BEB.1020408@epfl.ch> <51125AFC.10704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51125AFC.10704@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, florian.vaussard@epfl.ch, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all !

Le 06/02/2013 14:30, Benoit Cousson a =E9crit :
> Salut Florian,
>
> On 02/04/2013 10:14 AM, Florian Vaussard wrote:
>> Hello Benoit,
>>
>> On 01/24/2013 01:21 PM, Benoit Cousson wrote:
>>> + Peter who did the original PWM
>>>
>>> Hi Florian,
>>>
>>> On 01/23/2013 06:56 PM, Florian Vaussard wrote:
>>>> Hello Benoit,
>>>>
>>>> This patchset adds some new DT supports to the Overo products.
>>>> The first patch converts the PMIC LEDB output to use the
>>>> pwm-leds, newly merged in your branch for_3.9/dts. The second
>>>> patch adds the audio support.
>>>
>>> Excellent, that looks very good to me, but I'd like to get the
>>> feedback from Peter before merging it.
>>>
>>
>> So a patch is being merged to handle triggers in the case of pwm
>> leds [1]. When done, we will be able to add back the default
>> trigger. Do you want to wait on it to merge this series?
>
> What kind of dependency do we have between these two series? I mean
> what will happen if the DTS is merged before the pwm subsystem?
>
> If that does not generate any regression / crash, then it is OK, if
> not, we should take care of the order.

Florian is on holiday the next two weeks.

AFAIK if the PWM/leds subsystem patches are not merged before this one
then the kernel will panic if a trigger is used to change the led status.

Regards,

Philippe
