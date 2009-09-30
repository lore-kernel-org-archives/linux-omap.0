From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [RFC][PATCH] omapfb: Condition mutex acquisition
Date: Wed, 30 Sep 2009 15:08:21 +0300
Message-ID: <20090930120821.GD25087@localhost>
References: <A24693684029E5489D1D202277BE89444B781B6F@dlee02.ent.ti.com> <A24693684029E5489D1D202277BE89444B781B70@dlee02.ent.ti.com> <1254236004.23991.17.camel@tubuntu> <20090930005310.GI16865@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27061 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbZI3MG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 08:06:56 -0400
Content-Disposition: inline
In-Reply-To: <20090930005310.GI16865@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "ext Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, Sep 30, 2009 at 02:53:10AM +0200, ext Tony Lindgren wrote:
> [...] 
> Tomi & Imre, do you want me to add this to the omap-fixes queue,
> or are you planning to send other fixes too?
> 
> If you want me to add it, please reply with your ack.
> 
> I'll added it into omap-fixes-testing branch for now so we can
> get the omaps booted.

Acked-by: Imre Deak <imre.deak@nokia.com>

There are no other patches for the DSS1 driver, so it'd be good if
you could just apply it to omap-fixes.

--Imre

