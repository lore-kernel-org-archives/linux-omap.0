Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AFE3F412C;
	Mon, 25 May 2026 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779728134; cv=none; b=goNhRyD8t3SGUJBX6Dsp1rxJVYGTvIpfRbgrM3zm1tpKewFmXT/jkicHvJ8I7phzbJpwS9DwTnx28xVl43vr2fgXkACqz+pgbp1fPqqdJhgbD/WizVrizshNMhgH0mgkwVhdUIMjHp+dCCHBSFuiAk6NWJBdWykRIkGL0D5NfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779728134; c=relaxed/simple;
	bh=r9F+Z/G2R9EmJkJqYGdSK5x1qhDsOMO4RIwwPT3nm08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGaZtK6fo6RX2QYbaxKeXGHwDZYJxm/QNCmfhATUQ1j7arPK0+4TVsORJ91va+3m1L6pl+GTHodbL0QaFyDE5oKeLK0Cqk+9v9gH+CJa+1+Uc24fnONo9euRCZSfTNeYQtfmpJWx2RFzsZlTNUfSsLAyT/OEWxG4blalyZRsKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmjI4rKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmjI4rKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DF41F000E9;
	Mon, 25 May 2026 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779728133;
	bh=ev9yLt5NTZ9nEb03Xjyz/o28bx64uGp1JLdEhh9Coe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fmjI4rKS4bBepoqAbV18Ip+mP1JiKaJ3SoWM3uQKqXia1IKu2zRHu2mI1vT2l5Fqs
	 3+EOG9c04IkzAjonoKnZm7GnFDrQO2v6NPjAZT3ut9lI48JcOZ2G9P3IT6YksrvV99
	 y1e7z+eYHMmBDGXGsxi2q2imq/lnYzFVqV9rOuqaYdo3I8lMmskVD04kbXLnNMYQ25
	 kq967Zy2cOc7fghz+uBGLRScMX/WVp30btRe98rSP5Hzx65U9+z4lBn/0KOhjB71un
	 l52BZzGMNEsXMzRCvHQ21t4rHFRPC21lyXe8cKiDIOKJGMB+BdE8FFmuHw3AWsjfUk
	 dPifMRmJhwO+g==
Date: Mon, 25 May 2026 09:55:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Mithil Bavishi <bavishimithil@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: OMAP2+: Add CFI type for omap4_finish_suspend
Message-ID: <20260525165527.GA18457@ax162>
References: <20260522233036.12277-1-bavishimithil@gmail.com>
 <202605241332.fXvCYBR2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202605241332.fXvCYBR2-lkp@intel.com>

On Sun, May 24, 2026 at 02:01:31PM +0800, kernel test robot wrote:
> Hi Mithil,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on tmlind-omap/for-next]
> [also build test ERROR on linus/master v7.1-rc4 next-20260522]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mithil-Bavishi/ARM-OMAP2-Add-CFI-type-for-omap4_finish_suspend/20260523-073206
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git for-next
> patch link:    https://lore.kernel.org/r/20260522233036.12277-1-bavishimithil%40gmail.com
> patch subject: [PATCH v2] ARM: OMAP2+: Add CFI type for omap4_finish_suspend
> config: arm-defconfig (https://download.01.org/0day-ci/archive/20260524/202605241332.fXvCYBR2-lkp@intel.com/config)
> compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260524/202605241332.fXvCYBR2-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605241332.fXvCYBR2-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/arm/mach-omap2/sleep44xx.S:61:1: error: invalid instruction
>    SYM_TYPED_FUNC_START(omap4_finish_suspend)
>    ^

This report and the GCC one

  https://lore.kernel.org/202605252315.UhjCBtGA-lkp@intel.com/

are both pointing out that cfi_types.h needs to be included in
arch/arm/mach-omap2/sleep44xx.S for SYM_TYPED_FUNC_START to always be
expanded properly. I tested adding

  #include <linux/cfi_types.h>

as the first include line and both issues were resolved.

Cheers,
Nathan
