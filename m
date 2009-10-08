From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv1 1/3] OMAP UART: Adds omap-serial driver support.
Date: Thu, 8 Oct 2009 11:46:12 +0530
Message-ID: <d6a0f7aa0910072316y622f8a7ch40624dc43d1a650b@mail.gmail.com>
References: <65168.192.168.10.89.1253788033.squirrel@dbdmail.itg.ti.com>
	 <20091002224124.GY1133@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20091002224124.GY1133@earth.li>
Sender: linux-serial-owner@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Oct 3, 2009 at 4:11 AM, Jonathan McDowell <noodles@earth.li> wr=
ote:
> On Thu, Sep 24, 2009 at 03:57:13PM +0530, Govindraj.R wrote:
>> From: Govindraj R <govindraj.raja@ti.com>
>>
>> This patch adds support for OMAP3430-HIGH SPEED UART Controller.
>>
>> Signed-off-by: =A0 =A0 =A0 =A0Govindraj R <govindraj.raja@ti.com>
>> Reviewed-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
>> Reviewed-by: Tony Lindgren <tony@atomide.com>
>> ---
>
>> +config SERIAL_OMAP
>> + =A0 =A0 bool "OMAP serial port support"
>> + =A0 =A0 depends on ARM && ARCH_OMAP
>> + =A0 =A0 select SERIAL_CORE
>> + =A0 =A0 help
>> + =A0 =A0 If you have a machine based on an Texas Instruments OMAP C=
PU you
>> + =A0 =A0 can enable its onboard serial ports by enabling this optio=
n.
>
> If it's OMAP3 hardware then should the "depends on" be ARCH_OMAP3 ||
> ARCH_OMAP4, rather than allowing it for OMAP1 + 2 as well?
>
> J.
>

Agree. Will do the changes.


> --
> Revd. Jonathan McDowell, ULC | If they can't take a joke....fuck 'em.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
