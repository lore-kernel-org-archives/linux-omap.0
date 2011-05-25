From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 04/11] OMAP4: PM: VC: support configuration of i2c clks
Date: Wed, 25 May 2011 11:17:37 -0700
Message-ID: <87aaeawsou.fsf@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
	<1305695854-9638-5-git-send-email-nm@ti.com> <87y624xucx.fsf@ti.com>
	<BANLkTin5f5oz4aTiebmwWrwYCE2W2OLyAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:35403 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751601Ab1EYSRp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 14:17:45 -0400
Received: by iwn10 with SMTP id 10so9451066iwn.34
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 11:17:40 -0700 (PDT)
In-Reply-To: <BANLkTin5f5oz4aTiebmwWrwYCE2W2OLyAA@mail.gmail.com> (Nishanth
	Menon's message of "Wed, 18 May 2011 03:57:39 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

> On Wed, May 18, 2011 at 03:53, Kevin Hilman <khilman@ti.com> wrote:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> Patch "OMAP2+: voltage: split voltage controller (VC) code into ded=
icated layer"
>>> splits out the hardcoded value in the code to vc's channel init.
>>>
>>> This patch further isolates the configuration to remove out PMIC sp=
ecific
>>> configuration as high and low times are pmic specific.
>>>
>>> Values are updated as well based on latest TI analysis done in andr=
oid k35
>>> kernel.
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>
>> OK, this is a step in the right direction, but IIUC, these values ar=
e
>> sys_clk dependent right? =C2=A0Shouldn't we be calculating these val=
ues based
>> on sys_clk?
> 3 factors to my knowledge:
> a) sr clk I believe(I need to grab the relevant internal doc to
> verify) - factor of sysclk - > board based/in a way pmic based
> b)  factor of board capacitance (similar to i2c bus)
> c)  i2c bus capability of the PMIC itself.
>
> hence based it off pmic data..

These are hard-coded constants, that are calculated somehow, or their
simply pulled out of the air at random.  Either way, we need to know
*how* they are calculated, and explain it in.

Personaly, I'd prefer that the explanation come in the form of code.
IOW, functions that calculate the value based on dependent clocks using
whatever the board-specific factors are as inputs.

Kevin



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
