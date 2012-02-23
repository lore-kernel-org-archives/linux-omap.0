From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH/RFT 1/1] OMAP2+: cpufreq: scale voltage along with
 frequency
Date: Thu, 23 Feb 2012 05:28:57 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A931785204@DBDE01.ent.ti.com>
References: <1329420043-32656-1-git-send-email-khilman@ti.com>
	<1329420043-32656-2-git-send-email-khilman@ti.com>
	<C8443D0743D26F4388EA172BF4E2A7A931782571@DBDE01.ent.ti.com>
	<87vcmz3f63.fsf@ti.com>
	<C8443D0743D26F4388EA172BF4E2A7A931784AE0@DBDE01.ent.ti.com>
 <87ehtm1zi9.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54016 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab2BWF3E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 00:29:04 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1N5T1Ii008949
	for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 23:29:02 -0600
In-Reply-To: <87ehtm1zi9.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>

Hi Kevin,

On Thu, Feb 23, 2012 at 00:12:06, Hilman, Kevin wrote:
> > And in my patch plus - minus was not used as regulator framework will
> > try to set voltage for the least voltage which sometimes corresponds
> > to exact OPP required value.
> 
> sometimes?

I was not clear in my previous statement, let me explain it differently.

Regulator framework will always try to set lowest voltage in the range.
Upon, regulator_set_voltage(reg, OPPVOLT, (OPPVOLT+RESOLUTION-1)), if
OPPVOLT is a value that can be set by the regulator, that will be set by
the regulator, this is what I meant by 'sometimes'. Otherwise it will set
the next possible step.

> Using your example above, what if the closest value was 1.259V?
> Wouldn't you then need +/- range?

In that case, it will set to next step after 1.259V.

If +/- is used, it may happen that SoC will work for a particular frequency
at a voltage lower than it has been characterized (if you ask me to define
characterized, I don't know, but what I know is that SoC can work at a
lower frequency for the voltage of an OPP, but not vice versa). Still as
voltage will be only very less than that specified by OPP, it may not be
a problem to use +/-

> Please have a look at my v2.
> 
> The drivers will get pre and post notifiers, with the caveat that upon
> DVFS failure, the freq in the post notifier might be the same as the one
> in the pre notifier, indicating that no change was made.

Yes, I overlooked your freq.new update for error condition.

Earlier while adding support for DVFS on AM335X, it was noticed that, lpj
was going wrong after dvfs failure, then those error notifiers were added
to recover properly. Later it was realized that it was due to a bug in
cpufreq framework,

"d08de0c1  [CPUFREQ] update lpj only if frequency has changed"

fixed it, probably those extra handling in  my patch is not required now,
if drivers can understand your pre & post notifiers properly (if drivers
can't, then maybe it is driver problem)

Regards
Afzal
