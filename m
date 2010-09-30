From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP4: Extend clock data.
Date: Thu, 30 Sep 2010 11:16:13 +0200
Message-ID: <4CA4555D.2040106@ti.com>
References: <1285833630-23044-1-git-send-email-thara@ti.com> <alpine.DEB.2.00.1009300247170.5439@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55483 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840Ab0I3JQR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 05:16:17 -0400
In-Reply-To: <alpine.DEB.2.00.1009300247170.5439@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi Thara,

On 9/30/2010 10:57 AM, Paul Walmsley wrote:
> Hello Thara,
>
> On Thu, 30 Sep 2010, Thara Gopinath wrote:
>
>> This patch extends the OMAP4 clock data to include
>> various x2 clock nodes as the clock framework
>> skips a *2 whie calculating the dpll locked frequency.
>>
>> Signed-off-by: Thara Gopinath<thara@ti.com>
>> Acked-by: Kevin Hilman<khilman@deeprootsystems.com>
>> ---
>> Currently the framework is extended to include x2 nodes
>> only for a few clocks critical for OMAP4 DVFS. This
>> exercise needs to be done for most of the other post divider
>> clocks as and when necessary.
>
> Beno=EEt and I have been discussing this - I think we should probably=
 fix
> this problem for all of the DPLLs and HSDIVIDERs in one patch.  I'll =
let
> Beno=EEt comment further, but I think the current plan will be to gen=
erate a
> CLKOUTX2 node after the DPLLs, and then to use that as the parent for
> the various HSDIVIDERs that use that X2 output.

Here is


> Also, I think we should make this change in a consistent way with reg=
ards
> to what the autogeneration scripts should generate.  This way, we won=
't
> have to redo it later and cause unnecessary patch noise.
>
> Perhaps you can help Beno=EEt update the autogeneration scripts for t=
he
> above changes?
>
>
> - Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
