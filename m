From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Bug in linux omap clock framework?
Date: Thu, 11 Dec 2008 09:17:50 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812110916310.26754@utopia.booyaka.com>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com> <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com> <1228726770.8668.66.camel@tubuntu> <alpine.DEB.2.00.0812080218190.5902@utopia.booyaka.com> <1228831086.31061.9.camel@tubuntu>
 <87wse7rrvd.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1949738811-1229012270=:26754"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59070 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756386AbYLKQRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 11:17:51 -0500
In-Reply-To: <87wse7rrvd.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1949738811-1229012270=:26754
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Jouni, Tomi,=20

On Thu, 11 Dec 2008, H=C3=B6gander Jouni wrote:

> So it seems that cm_* register should not be written while there is
> powerstate transition ongoing in * domain. Patch by Tomi is fixing
> this. As it seems to be transition related rather than pwrdm state,
> same line should be added into omap2_clkdm_clk_disable also.

Shouldn't this have also crashed the system if it needed to be done=20
in omap2_clkdm_clk_disable() ?  Perhaps we should avoid adding it there=20
until we can reproduce a crash there?


- Paul
--155748971-1949738811-1229012270=:26754--
