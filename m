From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects (was:
	Re: Beagleboard rev C memory timings & suspend/resume)
Date: Sat, 6 Jun 2009 13:50:42 +0300
Message-ID: <6ed0b2680906060350i4de093fbj3575ba117c084295@mail.gmail.com>
References: <200904291553.49378.jpihet@mvista.com>
	 <200905261527.16648.jpihet@mvista.com>
	 <alpine.DEB.2.00.0906021724490.31531@utopia.booyaka.com>
	 <200906051735.57772.jpihet@mvista.com>
	 <alpine.DEB.2.00.0906051308370.31531@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:47351 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbZFFKul convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Jun 2009 06:50:41 -0400
Received: by fxm9 with SMTP id 9so1089759fxm.37
        for <linux-omap@vger.kernel.org>; Sat, 06 Jun 2009 03:50:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0906051308370.31531@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jean Pihet <jpihet@mvista.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Jun 5, 2009 at 10:14 PM, Paul Walmsley<paul@pwsan.com> wrote:
> Hi Jean,
>
> On Fri, 5 Jun 2009, Jean Pihet wrote:
>
>> Some notes:
>> - all calls to omap2_init_common_hw have been adapted in the board f=
iles. it
>> looks like 2430SDP and Pandora board files are broken since they use=
 only one
>> param. Can that be checked on those boards?
>
> Yep, builds with those two boards are broken on the PM branch, and it
> looks like your patch fixes both.
>
> Gra=9Eyvdas, looks like Pandora might use 2 SDRAM chipselects also?

Yes it does, it uses different part than Beagle rev C (256/512
RAM/NAND instead of 256/256), but RAM portion should be identical I
guess.


Gra=9Evydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
