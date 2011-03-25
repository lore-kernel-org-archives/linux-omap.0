From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 12/19] OMAP2+: powerdomain: add voltage domain lookup during register
Date: Fri, 25 Mar 2011 08:52:52 -0700
Message-ID: <87r59vtcx7.fsf@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-13-git-send-email-khilman@ti.com>
	<AANLkTin4=SzfUawC5dk3dmNNPoFK93vT4D6+rP1+1X=T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:53416 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753747Ab1CYPxY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 11:53:24 -0400
Received: by mail-pv0-f176.google.com with SMTP id 37so222006pve.21
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 08:52:55 -0700 (PDT)
In-Reply-To: <AANLkTin4=SzfUawC5dk3dmNNPoFK93vT4D6+rP1+1X=T@mail.gmail.com>
	(Jean Pihet's message of "Fri, 25 Mar 2011 10:18:06 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

[...]

>> @@ -94,6 +95,14 @@ static int _pwrdm_register(struct powerdomain *pw=
rdm)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (_pwrdm_lookup(pwrdm->name))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EEXIS=
T;
>>
>> + =C2=A0 =C2=A0 =C2=A0 voltdm =3D voltdm_lookup(pwrdm->voltdm.name);
>> + =C2=A0 =C2=A0 =C2=A0 if (!voltdm) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("powerdoma=
in: %s: voltagedomain %s does not exist\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pwrdm->name, pwrdm->voltdm.name);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>
> Per patch 10/19 some power domains do not have an associated voltage
> domain struct filled in. This will result in failure of the power
> domain registration. I think this is not expected.
>

Right.  I'll fix up the changelog in patch 10.  Now, all powerdomains
are required to have a voltage domain.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
