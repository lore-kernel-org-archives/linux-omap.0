Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7539320CD3;
	Tue, 14 Jul 2026 05:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006752; cv=none; b=ZsdaBOqxziHjj3G8lc5Jm/zdmhYR6ayFWvYrd7v1cNY3/0mz7CDDmg1k8ARttkASCK4+tCBtoJyo9CD+Fa5gtF2NWGbe5yhaXgVuCxd56WqW1HBDowRtPKLvf/D6Su51FIfq+cinIgKag9nRj+8+W6EXNPHjLHdIL/c2rxWaNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006752; c=relaxed/simple;
	bh=nvUp6ixQ/4WO1OpQur/BaHDEnmJshINP5l4vlNHwZLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1ArbopyttnJ6Ly3ecIHSD4RE1DQ1mk216QJZo20YKraBnyS0we+FB4xKcu5/fsZWgWrLBekds7Ln2CTDo55UCx9qvP+lG2KOeKmjdnnfzVepUlpaWeiLfJxzkHTT1gtDBkxWzofRq3t/iDg+hGPvzt2ehhmAsStcQvU3schr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4QERsU8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4QERsU8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784006750; x=1815542750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nvUp6ixQ/4WO1OpQur/BaHDEnmJshINP5l4vlNHwZLQ=;
  b=R4QERsU8RS0GjehHw65G9hMQISGMMXokVI4xaMMSs+bOu9blneZkwnd6
   QNmnoujEGVfkWnB8P4azE3YuxkHgmiQaqdIKPPC+/yntrdKiQ/qu4AJDn
   y1WHUr0pekFjz0MzMtBf+fFxEWNcbPj03PVGoHcSDGALkVQ8AofMev/C+
   W+d7bfCzZo9ary/yp82+PeJXpkMjkf86la1/3alb0xl0VwceUvzAOaEwB
   FcFbnSjW4AZqWxU5a4Z4o6Mdu4Z/5GbISn56zMFBFCpdglX7ojsWKG/Gd
   ddpk41P0ipGOceLPeJMScfSSypXynLSp3MxJhlwk0+mBpcJ8S1y1Bki0Y
   g==;
X-CSE-ConnectionGUID: 8abq/H3/RguevLrjiOw64Q==
X-CSE-MsgGUID: w6gzDah7T9mHmJ2ILezqrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84583596"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84583596"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:25:48 -0700
X-CSE-ConnectionGUID: b7VVUikhRGC8aHkOs9IFiw==
X-CSE-MsgGUID: Jy/VK4toSbSQTUtrikKzFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="280169706"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.248])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:25:36 -0700
Date: Tue, 14 Jul 2026 08:25:32 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	Michal Simek <michal.simek@amd.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	bjorn.andersson@oss.qualcomm.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-omap@vger.kernel.org, linux-mips@vger.kernel.org,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	aniket.randive@oss.qualcomm.com,
	chandana.chiluveru@oss.qualcomm.com
Subject: Re: [PATCH 0/6] tty: serial: propagate errors from uart_ops.pm
 callback
Message-ID: <alXITHzkv4TlvwcT@tlindgre-MOBL1>
References: <20260709-add_return_check_for_uart_change_pm-v1-0-e85c6ffa8ec4@oss.qualcomm.com>
 <ak9OPNcVAhkfxHvZ@ashevche-desk.local>
 <20260710043746.GM30058@atomide.com>
 <alSv8BPCOiyKvOI2@tlindgre-MOBL1>
 <alTKNEk97jkVGfML@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alTKNEk97jkVGfML@ashevche-desk.local>

On Mon, Jul 13, 2026 at 02:21:24PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 13, 2026 at 12:29:20PM +0300, Tony Lindgren wrote:
> > On Fri, Jul 10, 2026 at 07:37:46AM +0300, Tony Lindgren wrote:
> > > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [260709 10:38]:
> > > > Note, that Tony (you have him in the Cc list) did a lot for some corner cases
> > > > with that and we still have them IIRC. Tony, do you know what is the state of
> > > > affairs with runtime PM for UART?
> > > 
> > > The RX side of things should work for hardware that can wake up to an incoming
> > > event. Linux for sure needs more work to properly handle the various corner case
> > > TX wake-up of a PM runtime idled UART. I'm mostly offline until Monday though,
> > > will check my notes for more details next week.
> > 
> > For the TX side handling, my understanding is that at least uart_update_mctrl()
> > needs to call PM runtime resume and put autosuspend. And we should assume
> > uart_update_mctrl() can sleep to resume the PM runtime suspended serial port.
> > 
> > For drivers, the callers of uport->ops->get/set_mctrl() should be updated
> > to use uart_update_mctrl() where possible. And the remaining ones that cannot
> > sleep should be fixed so they can sleep or have PM runtime disabled.
> > 
> > Anybody have better ideas?
> 
> I don't, but the above sounds like a plan. Is it a big task? I can help with
> something in that area, perhaps Ilpo also would be able to participate.

Not sure how much changes are involved. Maybe it's safer to set up a
runtime PM enabled wrapper for uart_update_mctrl() and then start updating
the uart_update_mctrl() and get/set_mctrl() callers one at a time to make
them runtime PM aware.
