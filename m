From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 2/2] mt_ventoux: support for TeeJet Mt.Ventoux board
Date: Thu, 12 Jan 2012 00:04:14 +0400
Message-ID: <4F0DEB3E.6060809@emcraft.com>
References: <1324940912-18164-1-git-send-email-yanok@emcraft.com> <1324940912-18164-3-git-send-email-yanok@emcraft.com> <4EF97A41.7050605@compulab.co.il> <4EFA4E9C.30307@emcraft.com> <4F02CED6.8090709@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:49895 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab2AKUEY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 15:04:24 -0500
In-Reply-To: <4F02CED6.8090709@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sasha_d@emcraft.com

Hi Igor,

On 03.01.2012 13:48, Igor Grinberg wrote:
>> I will forward this info to hardware guys and ask about wiring. For now
>> I will leave it as is. Thanks for this information it turned to be some
>> kind of mystery. It would be great if you could give some pointer to the
>> datasheet regarding VDDSHV and DSS.
> 
> Well, there is no direct pointer to that information, but
> I've found these facts:
> 1) the "Ball Characteristics" tables state that the DSS related pins
>    (and also many others) are powered by the VDDSHV.
> 2) the estimated power consumption of VDDSHV is the largest after the
>    VDD_CORE, which is typical for DSS, but it is also one of the largest
>    power domains, so I guess this cannot be a valid argument ;-)
> 3) On the "Voltage domains" diagram, only the VDD_CORE is exposed and
>    DSS is not listed in it, but there are other domains which are not
>    exposed... (this only can exclude the DSS from VDD_CORE, but not
>    absolutely, as datasheets can have mistakes or just not give that piece
>    of information).
> 
> Still, it is a guess and not verified information.

Yes, I understand. Thanks for sharing you thoughts!

Regards, Ilya.

