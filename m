Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C53AFB14;
	Thu,  9 Jul 2026 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592185; cv=none; b=kLdI6DfjVJsCVQBPIGmMgSZFhEsphPXBbZrabM3eNY5DTaQGuTRyEL0AmdhNmfLFlD3Wg8HX4rPZizevWx3xR/chdjQHV0yijg2TwG5LVtTsIUGY0xYwb5zrjiExs+LS4xmSq0q1Mbo7cF1Zgep8O56gMnfIgouVKhD4w4D1T7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592185; c=relaxed/simple;
	bh=vUyuVhXb5XWOW1lu5ae8NpgTwEcJHaHweC6f6X1cbX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4WUYOAdE3kHAD9CAuSgPyiZtbFO9GcxLVNX2aJ5WyU/zcx4JM2P3LZyQRpOWd2//JZSMF8wfAYmt8VrUdObmwU+X8U5aNjfQ2oDdCbS6GObbjlGHn9OeSVKsGWnE7DpLJOQbQYaoT2tz1J9oLMQEYyiqwUUus7knc5WXx/KnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ji6e8qyc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ji6e8qyc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783592182; x=1815128182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vUyuVhXb5XWOW1lu5ae8NpgTwEcJHaHweC6f6X1cbX8=;
  b=ji6e8qycOK9XTAsqrHCOh6aaNAjoLiqjUVdKZQm+snnRdvtEJsGo/qix
   OupLfCGgH6dSBdsoKcrxZR0ucKFmPhpBkalP+iSHh7+91nbXrj46OZbjr
   wqG71jEmekPMxcBT00b50s8Vr/doXWh1Hr4jd9a1cpdfAQ2HLVwp8thBa
   RZunDLK0/9D73mRG0TPhhUTgfuoAG0eNmEHPpf9uC5hI74mOIu3WngOnM
   n1+zvpWC30qk3iRu9aF79yD4pjTLK2Z7Tu/T2RZrEJAgJ1zDHuZOCPCXX
   HG9muFRmvASemAvPjwUq3VdV4cBDqwHD5/N6dGbtE2HtQaNNzk2pF4jTq
   A==;
X-CSE-ConnectionGUID: 3Pu68IgrRvmwd45z6EwWjw==
X-CSE-MsgGUID: uXkFtDF5TGeeFpoPasmUEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94916084"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94916084"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:16:19 -0700
X-CSE-ConnectionGUID: nZeE0HBNTiyYL9uGZR4QmA==
X-CSE-MsgGUID: 88JSxELiQ7WNKT7Oj54cVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254058060"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:16:11 -0700
Date: Thu, 9 Jul 2026 13:16:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	Tony Lindgren <tony@atomide.com>,
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
Message-ID: <ak906CqHYDooQTVu@ashevche-desk.local>
References: <20260709-add_return_check_for_uart_change_pm-v1-0-e85c6ffa8ec4@oss.qualcomm.com>
 <9320a573-ebf8-459b-a313-3a8b73a6180b@kernel.org>
 <5eecf3a0-b608-4057-b400-236f6952b380@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eecf3a0-b608-4057-b400-236f6952b380@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 02:22:17PM +0530, Praveen Talari wrote:
> On 09-07-2026 12:23, Jiri Slaby wrote:
> > On 09. 07. 26, 8:25, Praveen Talari wrote:

...

> > OK, now I miss the rationale behind the patchset. Neither there is a
> > possible code path to actually test this?
> The rationale is that qcom_geni_serial_pm() calls
> pm_runtime_resume_and_get() which can fail, but its return value is
> currently discarded because the callback is void. 

So, you take the solution from a wrong end. Just get rid of .pm() in your driver.
With that, problem solved. Really, this series is a road to even more broken
PM solutions.

-- 
With Best Regards,
Andy Shevchenko


