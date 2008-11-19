From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH] OMAP3 powerdomains: remove RET from SGX power states list
Date: Wed, 19 Nov 2008 13:54:09 -0800
Message-ID: <5e088bd90811191354g7d570338n40abe9523ee1a8cc@mail.gmail.com>
References: <alpine.DEB.2.00.0811051152150.15612@utopia.booyaka.com>
	 <20081106033327.GQ21736@atomide.com>
	 <alpine.DEB.2.00.0811060401150.11718@utopia.booyaka.com>
	 <87ej1na8c2.fsf@trdhcp146196.ntc.nokia.com>
	 <alpine.DEB.2.00.0811100741420.23090@utopia.booyaka.com>
	 <87r65i66j5.fsf@trdhcp146196.ntc.nokia.com>
	 <alpine.DEB.2.00.0811121157530.28853@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:1819 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbYKSVyL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 16:54:11 -0500
Received: by nf-out-0910.google.com with SMTP id d3so89257nfc.21
        for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 13:54:09 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0811121157530.28853@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: =?ISO-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "Stoppa Igor \\(Nokia-D/Helsinki\\)" <Igor.Stoppa@nokia.com>, r-woodruff2@ti.com, Kevin Hilman <khilman@deeprootsystems.com>, "Sawant, Anand" <sawant@ti.com>, Poussa Sakari <sakari.poussa@nokia.com>

On Wed, Nov 12, 2008 at 11:07 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Jouni, Kevin,
>
> On Tue, 11 Nov 2008, H=F6gander Jouni wrote:
>
>> I wouldn't add any flags for this. The goal is finally to set all
>> next_states as OFF until someone has set some constraint which
>> prevents OFF usage. For now we need to use RET as default, because
>> drivers are not supporting OFF mode. Do you agree this?
>
> Yes.
>
>> Easiest way here would be to add own hook for SGX in pwrdms_setup? O=
ne
>> more strcmp("*_pwrdm, pwrdm->name) :)
>>
>> What do you think?
>
> That is okay with me.  This seems to be an unusual case - I guess it'=
s due
> to an SGX firmware bug.
>
> So Kevin, if you have a strong opposition to that strcmp, maybe we sh=
ould
> use a powerdomain flag for the SGX pwrdm.  Otherwise, let's go with a
> strcmp as Jouni suggested.  Thoughts?

Has there been a final resolution on this?

I am unable to boot reliably on Overo with 2.6.28-rc5 -- almost every
boot attempt gives me:

Power Management for TI OMAP3.
Unable to set state of powerdomain: sgx_pwrdm
=46ailed to setup powerdomains
omap2|3_pm_init failed: -22

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
