From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 2/3] pwm: New driver to support PWMs on TWL4030/6030
 series of PMICs
Date: Thu, 8 Nov 2012 13:53:43 +0200
Message-ID: <CANOLnOM6dp2_WthKUo31X_0os4cwax9Y42qSLqi09XiR-HF-Uw@mail.gmail.com>
References: <1352299488-11351-1-git-send-email-peter.ujfalusi@ti.com>
	<1352299488-11351-3-git-send-email-peter.ujfalusi@ti.com>
	<CANOLnOM7sp+O+KBKjiRk2drWh_63D6-bY86dx+upWkrvs7pp9w@mail.gmail.com>
	<509B5BDC.3030005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <509B5BDC.3030005@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 8, 2012 at 9:14 AM, P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.=
com> wrote:
> On 11/07/2012 06:50 PM, Grazvydas Ignotas wrote:
>>> +       if (pwm->hwpwm) {
>>> +               /* PWM 1 */
>>> +               mask =3D TWL4030_GPIO7_VIBRASYNC_PWM1_MASK;
>>> +               bits =3D TWL4030_GPIO7_VIBRASYNC_PWM1_PWM1;
>>> +       } else {
>>> +               /* PWM 0 */
>>> +               mask =3D TWL4030_GPIO6_PWM0_MUTE_MASK;
>>> +               bits =3D TWL4030_GPIO6_PWM0_MUTE_PWM0;
>>> +       }
>>> +
>>> +       /* Save the current MUX configuration for the PWM */
>>> +       twl->twl4030_pwm_mux &=3D ~mask;
>>> +       twl->twl4030_pwm_mux |=3D (val & mask);
>>
>> Do we really need this mask clearing here? After probe twl4030_pwm_m=
ux
>> should be zero, and if twl4030_pwm_request is called twice you don't
>> clear the important bits before |=3D, I think 'twl4030_pwm_mux =3D v=
al &
>> mask' would be better here.
>
> I'm storing both PWM's state in the same variable, but in different o=
ffsets:
> PWM0: bits 2-3
> PWM1: bits 4-5
> Probably it is over engineering to clear the relevant bits in the bac=
kup
> storage, but better to be safe IMHO.
> I would leave this part as it is.

Oh, it should be good then.


--=20
Gra=C5=BEvydas
