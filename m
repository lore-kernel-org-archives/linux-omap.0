Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D354CF42;
	Tue,  8 Sep 2026 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879237; cv=none; b=JzaP/GEgD+OBO9WWisKybmPkCxWG7B5sHBsIYmE+xt3Ip6LBQdiHNHM49wmmEuZquKGEZmjTecP++DfVTR+oWivHQjxjPhqr80Qmm/f+5OB8npzhwPKfxDlx0591Uv0IwxaUMUCnMW3QM7BO9CuZZZ7e/3+ew+4HuRiv1xGuNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879237; c=relaxed/simple;
	bh=TrSMQu2ZABHjU14yTvTji0c+6KQPSKtUqdvhvBoVBiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZVGM2T9hUfgWxmu2MYaKr1hRkgcpEt9l+hbsbalAqj3fKYNBW9wZRHOzMx/6oYztZIruV1ncd5gfjzXMM7BfieoR0z9hAl1Z/s+WhtMjx60cXGxuZIKxC8VDH4vW5EKC2O8U2PV5cC7ZRbp2j1Rxy17oSJSi3/cWkJmSaeogs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=hhPeX5Wz; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="hhPeX5Wz"
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688EojEP1957252;
	Tue, 8 Sep 2026 14:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=/2M0juWJsGHfapNEjd9U5lOWq3
	v+ZdSMdpMvEnhkfHE=; b=hhPeX5WzohW62sFh8ZoW+3snOonRnrGF0H5kU5+fks
	6LvVPIN773hza/8u5G0hmPI27pFyB5X2OGHY66N4i6GlHMXHUYuCo9F1feMHfZfz
	I6aByb3A3df+BDaYbd9G/r5//3KXV7oq9ghWiuZ1AzyAP78ASsAddCynPTNb4DZB
	USVJrdgK2b926ovt3xFn3DFElV4mNPEW0jt/KBtcoN2fOXSzy81giDb4e6JYSLKT
	JrjA4hoSjJcjxxT60TWqOJIQHWAozqA/cqB3cZxEHBNDT4qpoue88n80/C9YSMmZ
	C+A3Uw2cmIrLBZEj737xq9oPYs67zD6oxJh5G9tYeYlg==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4gjgxuu56w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 14:51:45 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 31AE2806B10;
	Tue,  8 Sep 2026 14:51:42 +0000 (UTC)
Received: from ilogsc-qemu.local (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id BF964806B6F;
	Tue,  8 Sep 2026 14:51:38 +0000 (UTC)
Date: Tue, 8 Sep 2026 09:51:36 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/9] docs: kernel-parameters: Drop the bau= entry
Message-ID: <aqAgAjccvFQ8HSN8@ilogsc-qemu.local>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
 <20260905070347.25902-3-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905070347.25902-3-kmehltretter@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE1OSBTYWx0ZWRfX0OcXsb7+afNp
 Wxvoi/6GnqRjyOdOWgk8vmpil2xZ7/B6hWhMV7dZEOjoZSPtzmaNiet8nNLmitXJKAHZDYGRuiO
 +BnYV71I99h+Rv0Omy9lovZ2YHlrfp0w0MpRhtH+xctUaoYEVhh7CoQNwVwyvUE+hv3qEB5QrKa
 LESp8EkOVHaq5KHGAsKHiURSc8DuKwWQN0bbu8m5fZSsrvjMSeJcdu7nvtYo+EfYv/YutcytdIr
 J3kqcOqa7xeU6Hf9c9Yhz9QQ6oaEGx9vn4MuuW8u/sO2OabO7cN0b5s5/LS0RHcFjC9FvFI/1t/
 vS5PHN1O8aTK0owdYkLUGOZqoqPEZ7r19IQxyUL9gT1nXnmIjLYJCScSrWn0lsB1VI0Fhx7cnT9
 vuOBIEzSFsKsgDie7KK8pk3F0VLYWXPRS/R8GmfVI4yW6mzYvyCYTShMfAnYHe200LU3qSneVvW
 dhqkSlFuDup+THT56RQ==
X-Proofpoint-ORIG-GUID: kSPi3CYtlGSGi8JBxY6XVTVrmRXF89VC
X-Proofpoint-GUID: kSPi3CYtlGSGi8JBxY6XVTVrmRXF89VC
X-Authority-Analysis: v=2.4 cv=EZT4hvmC c=1 sm=1 tr=0 ts=6aa02101 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=3haJ9R1Aw3gUfsUHDaCR:22 a=pGLkceISAAAA:8
 a=MvuuwTCpAAAA:8 a=LHlW8V97vvmrU187Gq4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE1OSBTYWx0ZWRfXzze0u1U5qUAw
 LOz2+0CMKZ2r0oPoOu4gI0Fso6RS3BpO9Mwiw8RJOUVIP2IixDqn1c0zi2x/V0l1ImOqzm7ENsI
 fgq3w6HAb/FOBYm4cigHRs/KW4j6ULE=
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080159

On Sat, Sep 05, 2026 at 09:03:40AM +0200, Karl Mehltretter wrote:
> bau= went away with commit 39297dde7390 ("x86/platform/uv: Remove UV
> BAU TLB Shootdown Handler"); nothing parses it any more.
> 
> Drop the entry.
> 
> Found by cross-checking every documented name against the __setup(),
> early_param() and core_param() registrations in the tree.
> 
> Fixes: 39297dde7390 ("x86/platform/uv: Remove UV BAU TLB Shootdown Handler")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c8d96de4c00d..99d5bb68968a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -624,13 +624,6 @@ Kernel parameters
>  			Format: <int> (must be >=0)
>  			Default: 64
>  
> -	bau=		[X86_UV] Enable the BAU on SGI UV.  The default
> -			behavior is to disable the BAU (i.e. bau=0).
> -			Format: { "0" | "1" }
> -			0 - Disable the BAU.
> -			1 - Enable the BAU.
> -			unset - Disable the BAU.
> -
>  	bdev_allow_write_mounted=
>  			Format: <bool>
>  			Control the ability to open a mounted block device
> -- 
> 2.53.0
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
