From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH 1/3] OMAP2+: UART: Remove cpu checks for populating errata flags
Date: Thu, 29 Mar 2012 13:05:24 +0530
Message-ID: <CAMrsUdKAAcc=tnC_vGRosEsqUmJBVaDQ9T=n898+9n30QwsSag@mail.gmail.com>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
 <1332325501-10467-2-git-send-email-govindraj.raja@ti.com> <4F722C63.9080900@ti.com>
 <CAMrsUdKfsoks4fB4GhrRcEur8niJsaWuYGE34+j5Bk6u2XiZQQ@mail.gmail.com> <4F733FC4.9010506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4F733FC4.9010506@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 28, 2012 at 10:13 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> Hi Govindraj,
>
>
> On 3/28/2012 6:09, Raja, Govindraj wrote:
>>
>> On Wed, Mar 28, 2012 at 2:38 AM, Jon Hunter<jon-hunter@ti.com> =A0wr=
ote:
>>>
>>> Hi Govindraj,
>>>
>>>

[...]

>>>> + =A0 =A0 =A0 u32 mvr, scheme;
>>>> + =A0 =A0 =A0 u16 revision, major, minor;
>>>> +
>>>> + =A0 =A0 =A0 mvr =3D serial_in(up, UART_OMAP_MVER);
>>>> +
>>>> + =A0 =A0 =A0 /* Check revision register scheme */
>>>> + =A0 =A0 =A0 scheme =3D mvr& =A0 =A0(0x03<< =A0 =A030);
>>>> + =A0 =A0 =A0 scheme>>=3D 30;
>>>
>>>
>>>
>>> Minor nit-pick, why not ...
>>>
>>> =A0 =A0 =A0 =A0scheme =3D mvr>> =A030;
>>>
>>
>> yes will correct it.
>
>
> Thinking some more, could be better to add some #defines for
> OMAP_MVR_VERSION_MASK/SHIFT here.
>

Yes sure.

>
>>>
>>>> + =A0 =A0 =A0 switch (scheme) {
>>>> + =A0 =A0 =A0 case 0: /* Legacy Scheme: OMAP2/3 */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MINOR_REV[0:4], MAJOR_REV[4:7] */
>>>
>>>
>>>
>>> This scheme is also true from OMAP1 devices. Maybe we could include=
 in
>>> the
>>> comment.
>>
>>
>> No omap1 from $SUBJECT also reason,
>>
>> mach-omap1/serial.c =3D> =A08250.c
>> mach-omap2/serial.c =3D> =A0omap-serial.c
>
>
> Got it! Thanks.
>
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 major =3D (mvr& =A0 =A00xf0)>> =A0 =A0=
4;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 minor =3D (mvr& =A0 =A00x0f);
>>>>
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 =A0 case 1:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* New Scheme: OMAP4+ */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MINOR_REV[0:5], MAJOR_REV[8:10] *=
/
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 major =3D (mvr& =A0 =A00x7<< =A0 =A0=
8)>> =A0 =A08;
>>>
>>>
>>>
>>> Nit-pick ...
>>>
>>> =A0 =A0 =A0 =A0major =3D (mvr>> =A08)& =A00x7;
>>
>>
>> yes fine will correct this.
>
>
> May be we should add #defines here to for OMAP_UART_MVR1_MAJ_MASK/SHI=
=46T,
> OMAP_UART_MVR1_MIN_MASK/SHIFT, OMAP_UART_MVR2_MAJ_MASK/SHIFT and
> OMAP_UART_MVR2_MIN_MASK/SHIFT.
>

okay will add this.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
