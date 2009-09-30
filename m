From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [RFC][PATCH] omapfb: Condition mutex acquisition
Date: Wed, 30 Sep 2009 08:34:43 -0500
Message-ID: <A24693684029E5489D1D202277BE89444C92BD1C@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89444B781B6F@dlee02.ent.ti.com>
 <A24693684029E5489D1D202277BE89444B781B70@dlee02.ent.ti.com>
 <1254236004.23991.17.camel@tubuntu> <20090930005310.GI16865@atomide.com>
 <20090930120821.GD25087@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58411 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754016AbZI3NfP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 09:35:15 -0400
In-Reply-To: <20090930120821.GD25087@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Imre Deak wrote:
> Hi,
> 
> On Wed, Sep 30, 2009 at 02:53:10AM +0200, ext Tony Lindgren wrote:
>> [...]
>> Tomi & Imre, do you want me to add this to the omap-fixes queue,
>> or are you planning to send other fixes too?
>> 
>> If you want me to add it, please reply with your ack.
>> 
>> I'll added it into omap-fixes-testing branch for now so we can
>> get the omaps booted.
> 
> Acked-by: Imre Deak <imre.deak@nokia.com>
> 
> There are no other patches for the DSS1 driver, so it'd be good if
> you could just apply it to omap-fixes.

Tony,

Please take v2 of patch instead, has a richer description of the problem.

Thanks in advance,
Sergio

> 
> --Imre

