From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v1 09/10] OMAP: McBSP: use omap_device APIs to modify
 SYSCONFIG
Date: Tue, 04 Jan 2011 11:46:59 +0200
Message-ID: <4D22EC93.70008@nokia.com>
References: <1292917231-13800-1-git-send-email-kishon@ti.com>	<1292917231-13800-9-git-send-email-kishon@ti.com>	<4D22CDB0.6000503@nokia.com> <AANLkTinW4uEW1qOjBfXiwayi1mr=iygohxX5mtr9KwBo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:24363 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab1ADJrC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 04:47:02 -0500
In-Reply-To: <AANLkTinW4uEW1qOjBfXiwayi1mr=iygohxX5mtr9KwBo@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com

On 01/04/11 11:26, ext ABRAHAM, KISHON VIJAY wrote:
>>     1. How we select the WAKE events from McBSP?
>>       We need XRDYEN, and RRDYEN bits for wake (in WAKEUPEN register=
),
>=20
>      Ahh.. Ok. This setting still need to be present. Will add it in =
my
> next patch version.
>      Thanks.

Thanks.

>>     and
>>       also we need to enable the WAKEUP in SYSCON register.
>=20
>       Setting of WAKEUPEN will be taken care by pm_runtime_get_sync()

I need to get more familiar with the hwmod things ;)

>>     2. How we are configuring the CLOCKACTIVITY field in SYSCON regi=
ster?
>=20
>=20
>        It's been set in the hwmod database. In [1], there is a field
> .clockact in
>        omap_hwmod_class_sysconfig where we set the clock activity to =
2.
> Whenever
>        we do a get_sync, CLOCKACTIVITY field in SYSCON register will =
be set
>        to the value present in .clockact field.
>=20
>       [1] https://patchwork.kernel.org/patch/423731/

I see. Is there a way to change the CLOCKACTIVITY field in certain case=
s?
What I mean is:
the 0x2 means that ICLK can be switched off, PRCM FCLK must kept on
I have a setup, where I can switch off the FCLK for a period of time (s=
o
PER domain can hit retention). For this I'll need to have 0x0 in
CLOCKACTIVITY.
I'm not sure what are the side effects if we always use 0x0, but IMHO
that shall be fine as well.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
