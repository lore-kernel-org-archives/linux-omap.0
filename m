From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH/RFT 1/1] OMAP2+: cpufreq: scale voltage along with
 frequency
Date: Thu, 23 Feb 2012 07:17:30 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317853DD@DBDE01.ent.ti.com>
References: <1329420043-32656-1-git-send-email-khilman@ti.com>
	<1329420043-32656-2-git-send-email-khilman@ti.com>
	<C8443D0743D26F4388EA172BF4E2A7A931782571@DBDE01.ent.ti.com>
	<87vcmz3f63.fsf@ti.com>
	<C8443D0743D26F4388EA172BF4E2A7A931784AE0@DBDE01.ent.ti.com>
 <87ehtm1zi9.fsf@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A931785204@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37398 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078Ab2BWHRf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 02:17:35 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1N7HX6D021637
	for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 01:17:34 -0600
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A931785204@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

Hi Kevin,

On Thu, Feb 23, 2012 at 10:58:57, Mohammed, Afzal wrote:
> > Using your example above, what if the closest value was 1.259V?
> > Wouldn't you then need +/- range?
> 
> In that case, it will set to next step after 1.259V.
> 
> If +/- is used, it may happen that SoC will work for a particular frequency
> at a voltage lower than it has been characterized (if you ask me to define
> characterized, I don't know, but what I know is that SoC can work at a
> lower frequency for the voltage of an OPP, but not vice versa). Still as
> voltage will be only very less than that specified by OPP, it may not be
> a problem to use +/-

Upon discussing with Sekhar, realized that I was wrong in the above
statements, +/- OPP tolerance range should be used.

Regards
Afzal
