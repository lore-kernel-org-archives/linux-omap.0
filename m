Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954D3E3163;
	Mon, 13 Jul 2026 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934977; cv=none; b=U9lcIZjt42FX5qgt66SR9Z7xCN2ITIkHxzMfpkED7RZlPMTnAMyJ7QiLGxHTXdh2QH5fVASXuWvt3Ybir4BAA/t9ydMZH+MgN8JbXYay+/mt6pl4hmResOmnUIjt3RN79EElE8FPhMT1xMQHhCNFUm69tS0q+TZaxd5+95cz4AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934977; c=relaxed/simple;
	bh=IP6+FHRCeZ6ktDt3C7axt12zz2S64i+osWbdVgzJ2m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfxx9Ta9kTBWjM+j6MSmwavtnl7FyE1ElSQLLEBr8VFMxI2Xu+uU4GKDlWwVRisiT1Z/L03JKen/z9zNx/PmMdC4yQjMH5P82G/t/fePhVdpqyXTFhgja9rK5feQrGcZAuSNbp+Tr5f6Fb/DOciKcuR0oWzSeFoPeNvRW6Ob4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YarZFYC3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YarZFYC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783934975; x=1815470975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IP6+FHRCeZ6ktDt3C7axt12zz2S64i+osWbdVgzJ2m8=;
  b=YarZFYC3fbKVH6yRnBqmtzVR+8AVx8+rlKPO+b6VQLWvUZe4UYqZROj2
   Krk6UL/0Ax2vIOjtra4HCe1kLE3paXtJMkigd/X9Rr5mtSe7OzqIvXZic
   8wC9lNPaIpRIcfYtxjRIbtqi+WlzrJBoSHqb0SVOG3UGnlctqy4nFPX/7
   6wwWTH9rmQ7jIAe3Q25b1AUqOJTY6hsdbeBmft0/0M/OOCGDBxvIg+HlP
   Jo0K1Bbc95CB3Wl+6xli0LAAe7EJtxK+Dh/6oFLZIgAQfLUKzBoHkTdod
   i9dyqOqXTRdKqrSF3npSWfLBsGxsTTU1CrrGGA9RWGsO517TE72V/8Du/
   g==;
X-CSE-ConnectionGUID: z24o08MsSc+/Vle9Q1vY/w==
X-CSE-MsgGUID: a0/sTs0jQH6Uac4tWz25ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="110082196"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="110082196"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 02:29:34 -0700
X-CSE-ConnectionGUID: 4vHZevoKQ0ioRPvqHl9QsQ==
X-CSE-MsgGUID: U0RLdXqZR9Ovvs5nHqBgCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="260394092"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 02:29:23 -0700
Date: Mon, 13 Jul 2026 12:29:20 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <alSv8BPCOiyKvOI2@tlindgre-MOBL1>
References: <20260709-add_return_check_for_uart_change_pm-v1-0-e85c6ffa8ec4@oss.qualcomm.com>
 <ak9OPNcVAhkfxHvZ@ashevche-desk.local>
 <20260710043746.GM30058@atomide.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710043746.GM30058@atomide.com>

On Fri, Jul 10, 2026 at 07:37:46AM +0300, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [260709 10:38]:
> > Note, that Tony (you have him in the Cc list) did a lot for some corner cases
> > with that and we still have them IIRC. Tony, do you know what is the state of
> > affairs with runtime PM for UART?
> 
> The RX side of things should work for hardware that can wake up to an incoming
> event. Linux for sure needs more work to properly handle the various corner case
> TX wake-up of a PM runtime idled UART. I'm mostly offline until Monday though,
> will check my notes for more details next week.

For the TX side handling, my understanding is that at least uart_update_mctrl()
needs to call PM runtime resume and put autosuspend. And we should assume
uart_update_mctrl() can sleep to resume the PM runtime suspended serial port.

For drivers, the callers of uport->ops->get/set_mctrl() should be updated
to use uart_update_mctrl() where possible. And the remaining ones that cannot
sleep should be fixed so they can sleep or have PM runtime disabled.

Anybody have better ideas?

Regards,

Tony
