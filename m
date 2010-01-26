From: "Andrew Murray" <amurray@mpc-data.co.uk>
Subject: RE: PM: VDD2 OPPs
Date: Tue, 26 Jan 2010 23:06:40 -0000
Message-ID: <0C997DD87CC88A4F86C897F52650B52B0280770B@MOLSON.mpc-data.co.uk>
References: <0C997DD87CC88A4F86C897F52650B52B02807701@MOLSON.mpc-data.co.uk> <4B5F5378.9020800@ti.com> <0C997DD87CC88A4F86C897F52650B52B02807703@MOLSON.mpc-data.co.uk> <74583B8642AB8841B30447520659FCA9E761EEC1@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cvs.mpc-ogw.co.uk ([81.2.99.171]:21406 "EHLO
	molson.mpc-data.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752577Ab0AZXGn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 18:06:43 -0500
Content-class: urn:content-classes:message
In-Reply-To: <74583B8642AB8841B30447520659FCA9E761EEC1@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, "Menon, Nishanth" <nm@ti.com>

> The OPP sets in the TRM are the one that were characterized and
validated by TI. They provide you the max frequency you  > can achieve
at a certain voltage.
> As soon as the frequency is below the one defined in the OPP, you can
do whatever you want.

Thanks for the clarification - this makes sense to me now.

> Concerning the 41.5MHz for the core, the issue is that the voltage for
that OPP is almost the same than the one at 83MHz > thus providing very
little gain for the power point of view. In term of energy it will even
increase the consumption due > to the very negative performance impact
that frequency will do to the MPU and the whole system in general.

Yes I see this - understood.

Thanks for the quick answers!
