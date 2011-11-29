From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Tue, 29 Nov 2011 17:19:12 +0100
Message-ID: <4ED50600.8070607@ti.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com> <1319467559-5518-5-git-send-email-ming.lei@canonical.com> <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com> <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com> <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com> <4EC6566C.70202@ti.com> <alpine.DEB.2.00.1111261854340.6289@utopia.booyaka.com> <alpine.DEB.2.00.1111261906010.6289@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60331 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619Ab1K2QTg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 11:19:36 -0500
In-Reply-To: <alpine.DEB.2.00.1111261906010.6289@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ming Lei <ming.lei@canonical.com>, linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi Paul,

On 11/27/2011 3:07 AM, Paul Walmsley wrote:
> On Sat, 26 Nov 2011, Paul Walmsley wrote:
>
>> Hi Beno=EEt,
>>
>> a question about this patch.
>
> ...
>
>>> +		.name		=3D "mipi_stm",
>>> +		.pa_start	=3D 0x54161000,
>>> +		.pa_end		=3D 0x54161fff,
>>> +		.flags		=3D ADDR_TYPE_RT
>
>> ... none of the address spaces above have the ADDR_TYPE_RT flag set.
>> Without this flag set, the hwmod code won't know where to access the=
 OCP
>> registers.
>
> Ugh, it's above; I just missed it.  Sorry about that.
>
> So just out of curiosity, do those SYSCONFIG registers in the STM add=
ress
> space apply to the entire DEBUGSS, or just the STM IP block?

The STM IP is the only one to have the TI generic wrapper to be=20
compliant with TI standards.
But in term of PRCM, there is only one IP, the DEBUGSS.
There are probably a bunch of internal clock management inside it that=20
are not exposed to PRCM.

The confusing part is that in theory all these entries can be accessed=20
by the same OCP port, and should potentially have this flags.
The point is that for the moment, we are mainly using that flag to get=20
the SYSCONFIG.
We already discussed that, but I think we should modify this flag to=20
highlight the SYSCONFIG / SYSSTATUS availability.
Maybe with something like ADDR_SYSCONFIG?

Any thought?

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
