From: Tim Niemeyer <tim.niemeyer@corscience.de>
Subject: Re: regarding arm: update ARM_ERRATA_430973 Kconfig
Date: Thu, 28 Mar 2013 12:19:25 +0100
Message-ID: <1364469565.2235.6.camel@herbert.er.corscience.de>
References: <alpine.DEB.2.01.1303261247320.18121@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50737 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956Ab3C1LT3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 07:19:29 -0400
In-Reply-To: <alpine.DEB.2.01.1303261247320.18121@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Thomas Weber <thomas.weber@corscience.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi

Am Dienstag, den 26.03.2013, 12:57 +0100 schrieb Peter Meerwald:
> regarding your patch against arch/arm/Kconfig:
> 
> @@ -1215,7 +1215,7 @@  config ARM_ERRATA_430973
>  	depends on CPU_V7
>  	help
>  	  This option enables the workaround for the 430973 Cortex-A8
> -	  (r1p0..r1p2) erratum. If a code sequence containing an ARM/Thumb
> +	  (r1p*) erratum. If a code sequence containing an ARM/Thumb
>  	  interworking branch is replaced with another code sequence at the
>  	  same virtual address, whether due to self-modifying code or virtual
>  	  to physical address re-mapping, Cortex-A8 does not recover from the
> 
> 
> I am seeing strange segfault/illegal instructions fixed by enabling 
> ARM_ERRATA_430973 on a TI OMAP3 DM3730, r3p2 IMHO (see below) 
The only information i have is that it was fixed in r2p1. The statement
is from mru on:
http://www.beagleboard.org/irclogs/index.php?date=2013-02-18#T15:00:07

> ARM_ERRATA_430973 is relevant for which processors? have you checked the 
> errata list? I had no luck obtaining it yet
No, i don't have it either.

-- 
Tim Niemeyer

Corscience GmbH & Co. KG
Henkestr. 91
D-91052 Erlangen
Germany

e-mail: tim.niemeyer@corscience.de
Internet: www.corscience.de

