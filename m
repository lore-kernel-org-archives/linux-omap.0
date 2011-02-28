From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [Patch 1/2] OMAP2PLUS: DSS2: Add dss_opt_clk_roles in pdata
Date: Mon, 28 Feb 2011 14:47:44 +0530
Message-ID: <AANLkTi=oAcua0z3Bwb4Yq-Xoj=2R5RXgDR+KnuJ77qkT@mail.gmail.com>
References: <1298622470-10558-1-git-send-email-sumit.semwal@ti.com>
 <1298622470-10558-2-git-send-email-sumit.semwal@ti.com> <1298884249.9809.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53110 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752993Ab1B1JSG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 04:18:06 -0500
Received: by mail-gy0-f171.google.com with SMTP id 12so1605752gyd.30
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 01:18:04 -0800 (PST)
In-Reply-To: <1298884249.9809.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

Hi Tomi,

On Mon, Feb 28, 2011 at 2:40 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
<snip>
>> + =A0 =A0 oc =3D oh->opt_clks;
>> + =A0 =A0 oc_count =3D oh->opt_clks_cnt;
>> +
>> + =A0 =A0 /* copy roles of opt_clocks available from hwmod into pdat=
a */
>> + =A0 =A0 pdata.dss_opt_clk_roles =3D kzalloc(sizeof(char *) * oc_co=
unt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 GFP_KERNEL);
>> + =A0 =A0 if (!pdata.dss_opt_clk_roles) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("could not allocate memory for dss_=
opt_clk_roles\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 for (i =3D 0; i < oc_count; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int oc_length =3D strlen(oc[i].role);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata.dss_opt_clk_roles[i] =3D kzalloc(oc_=
length + 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pdata.dss_opt_clk_roles[i]) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int j =3D i - 1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("kzalloc failed for=
 dss_opt_clk[%i]\n", i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (; j >=3D 0; j--)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pdat=
a.dss_opt_clk_roles[j]);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pdata.dss_opt_clk_ro=
les);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 strncpy(pdata.dss_opt_clk_roles[i], oc[i].=
role, oc_length+1);
>> + =A0 =A0 }
>
> Do you actually need to copy the role strings? Can they every change?=
 If
> they are const data, you could just point to the original strings.
Right; no, I don't think they can change, so I could point to the
original strings.
>
> And is there even need to create clk_roles array. If I'm not mistaken=
,
> the only use for this data is for the opt_clock_available() function.=
 We
> could just have an opt_clock_available() function pointer in the
> omap_display_platform_data, and the function itself would be in
> display.c. And the function could use the original hwmod data.
Ok, but in that case, we do the same hwmod lookup everytime, is it?
That may not be so bad though, considering we check that very rarely
[in dsshw_probe=3D>dss_get_clocks() path].

Ok, will do and send the updated one soon.
~Sumit.

>
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
