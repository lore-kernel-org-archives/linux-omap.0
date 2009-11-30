From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Mon, 30 Nov 2009 10:01:56 -0700
Message-ID: <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
	<1259599010.4649.51.camel@thunk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:39753 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbZK3RCJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 12:02:09 -0500
Received: by iwn1 with SMTP id 1so2382997iwn.33
        for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 09:02:16 -0800 (PST)
In-Reply-To: <1259599010.4649.51.camel@thunk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: Mika Westerberg <ext-mika.1.westerberg@nokia.com>, tony@atomide.com, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Mon, Nov 30, 2009 at 9:36 AM, Peter Barada <peterb@logicpd.com> wrot=
e:
> On Mon, 2009-11-30 at 10:46 +0200, Mika Westerberg wrote:
>> Hi Tony,
>>
>> Current omap serial driver takes control of all 3 (4 on OMAP3640)
>> UARTS. However, we have such a setup where UART2 for example is used
>> by bluetooth driver. It uses the UART as non-standard way (there are
>> some Nokia extensions to H4 protocol) so we cannot use the standard
>> driver for driving the UART but have written special one for that
>> purpose.
>>
>> Question is: Is there any, upstreamable, way of preventing omap seri=
al
>> driver to do this? Currently this is done with custom #ifdef hackery=
 to
>> mach-omap2/serial.c. Alternative solution that comes into mind is to
>> specify UART configuration in board files and let serial driver to u=
se
>> that instead of hard-coded one. Or do you have some nice alternative=
s?
>
> Previously (back around 2.6.28-rc8) in the board file, the
> omap_uart_config struct controlled which serial ports were enabled on
> startup. =A0It was used in omap_serial_init, and it looks like that c=
ode
> went away with the following commit:
> http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.git=
;a=3Dblobdiff;f=3Darch/arm/mach-omap2/serial.c;h=3D2e17b57f5b23bb6703a2=
d621103585af1d8d729b;hp=3D555e735524381cbf8ef9f20d778ad81f9438e24e;hb=3D=
4355c41a635943d30e9396b95185314343dcb551;hpb=3D7e9ccf7776bb68b5367eb0bb=
35e519df62bea35c
>
> I'm kinda in the same boat as I want to use some of the unused serial
> port pins for GPIO, but they are setup as serial ports....

Not in mainlined yet, but I'm working on porting flattened device tree
support to OMAP to solve exactly this sort of problem.  Basically,
instead of hard coding or #ifdeffing things, a data blob gets handed
to the kernel at boot time telling it exactly what hardware is present
in a consistent, parsable format.  Device drivers then get probed
based on data in the device tree.  Here's some info on the approach:

http://www.elinux.org/Device_Trees

I expect to have my prototype ready for review mid-January, and most
of the common code should be either merged or queued up in linux-next
by that time.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
