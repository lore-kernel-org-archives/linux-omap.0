Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486863DEAC6
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895786; cv=none; b=S+x5Z+DWRlD53VA/M6cLDjcMb9iL5Bp48Ie07no2W/fDIg02kq6hGilg3wgrIYj2P+ymuefFYdnMPu7d6dZan4S26GbGzSbTdv58b9x2JhbfN4c4IVf8B/oAgf2euvsmL8FthtevoG0+ZjidD+BDmxk2zoE+0t04LRSSKlWZKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895786; c=relaxed/simple;
	bh=eSJC/HPXN3YTKNn2Z8B6fMEKeWRVybcLVZH7mVe5aGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIiT4c/AQgBNizPVV0lDBbdJokgu24L7M6Rsc+P/7N20euRJyvEM0bg8ldmSqXOlstFYtWI1Yhspjkt7nVXjFzddG109Ufj6qCvDOOVudCg6k1JOudWsqv5g9JGjVVDz9ekYfDsZMJtzkkKGrtwCOBDQu8tUIH2X8/RAqhM7Gss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XOA7KUZy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vg1eptdd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XOA7KUZy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vg1eptdd"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OAE0wN2917075
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 12:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	swyQuDarVDN5VJVqjAFVM+bZ5jRGsu+zccVbSS0Cmqc=; b=XOA7KUZy5pk6PVqE
	Nc4Ta5bdbp8FPw6UN6UBTUZItLw0RamLPAjQLYfYFfU9f4lXXakwv4L3C6ubnPOE
	Gz5PjVhI9ZSKdTodG0gQkr0fDrFr/UK5ZBn8MXpnOy6s6PRAIyL8KyAxQoxlhNjC
	65a6mUyMdFY2D/Gn7SB8VIkqPnvGrHPSa/fOrND6nJ/1OZSPfaIMhflF7kMKN0vU
	dPfPcFOnlYFndTitzlIk70aHKkSOF90ZQOiq0UckkepiYDHd+pskcC+vHhDdNrt2
	iCdJR8NASVXn3e63hqKiGF1WTyrfKhFja8u5FDEKyNzcV9FOFwuwvu942F6C4Zgy
	SlLV6g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkp5vm4jg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 12:23:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51ca37ce4c3so885061cf.3
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784895782; x=1785500582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=swyQuDarVDN5VJVqjAFVM+bZ5jRGsu+zccVbSS0Cmqc=;
        b=Vg1eptdd5ZDZDo9lMWaUim9m86/XWDNiq7gEh+zU6XMNI4RHQhYZmiSfZ3c+v1LykQ
         4IzLy6SoGcviKq2R+vHryPdXhOPaM3kNo4aUBn8/vQVKjC3kJHYyPm4XiJeEZ6FoFhq2
         n11umC90C//UdQMyF0EM+KXG1CHNrYJXttadXrAbgE/Lvep2DCp0FCpptnND31oZ6LKp
         XWSgRvFjByi6mjeb/sgXt/6vKVdLFukeUddXyw1rvaBwhFpuPbtlKV5LY/RJyhZCkl/0
         aAUNLyP2xkNjNDlimVe/POVlGvovv/c7kKacUtoQdwdkUTgXf+8D7Si6o4OhnIL6mrMF
         C6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784895782; x=1785500582;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=swyQuDarVDN5VJVqjAFVM+bZ5jRGsu+zccVbSS0Cmqc=;
        b=eouQLsFiDN3gydnGEIyHKDNVmRT9h0IcRxgOaN5entW1gppsgj+4fHBlDer+kLZiU6
         EzhdusjeP7SoCtd+bbSM+huKEC2a3xCazTE6r7iarZloqeNw4HxTVVZ5XeB3tVqAwUzo
         4thJnhvMMFKK3zdTW/Uy8a6R9+SRB0yLBssYfDdg+2UXQ2zVqqOMAq4H1xJdWKlY1yAq
         txCh+d4BME7kI87Vu/yuBNfkupp4bFFQ1WHLDiIgU1dXQNuj047id6TsgKcciNIUc1fg
         xPmZmhTcihWXyVk5WAiTtoOck/PSIlgeZlzaoMbVuL+U+Fyn8hismMOMHiuonLbGBRS6
         qElA==
X-Forwarded-Encrypted: i=1; AHgh+RoxCcmuKr9gKXiGxbMyEIOV9PHw9njVc+a/NiD4V6GlJWUl436GtMA3ltryVGDsHJ68nucmVHCGEOhd@vger.kernel.org
X-Gm-Message-State: AOJu0YxTTNz26EsSOgQP7jcruxBqChLgtQixOMEACzCnttsSzgd7OSAS
	tyBT67V/v/1As+QfFSsESfWvJuUO4nbvI1ydiOIYd3ATOwRYMGQhfCYWHnkTSvdFEej8P/c1r8x
	H20E3faofAqlaH++iQZRW1ovsTDItGMWcElzeewoP21/zPA6IMZ18hC1vhKS8PKpP
X-Gm-Gg: AR+sD13t6y3tQNIrc0djRr0Rql276D8sRiUkfBxSzyg7Pz4OyONJsxnaSXt5JJQfyal
	+OH1C948d/AsHbKgmm1z5G6tpXpE7zKKD0hXgpP9Ua3MS7x4yBKq57NNmEqzfUT9arL2wyL3OQk
	9S47cfZp/cXg3WIlOKM0rL3XHZE5iTDKC1UYL95AnWHOiudIj4ATdw+ZhUXsswIi/0vf5JjoxTe
	w6vhKkGCSTVE/dLjhP6ZPGGFHfXvkusPpS9pi7sYByQ9FLPQCfnZ7xqORwZU8kYMh895x/vP0yN
	OR3hHp+zk+5LJu4SFgqlcmou73Sc9683p2BpCUIXycX0WowSLC8pUYtfjHkyLPyX7wwcUw5Q4aS
	ek0EBehvDtiH4ZXGX0gG2Xu2g
X-Received: by 2002:a05:622a:6208:b0:51c:11b4:6b24 with SMTP id d75a77b69052e-528496c5744mr31381061cf.3.1784895782018;
        Fri, 24 Jul 2026 05:23:02 -0700 (PDT)
X-Received: by 2002:a05:622a:6208:b0:51c:11b4:6b24 with SMTP id d75a77b69052e-528496c5744mr31380561cf.3.1784895781535;
        Fri, 24 Jul 2026 05:23:01 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ebad78sm339747966b.46.2026.07.24.05.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 05:23:00 -0700 (PDT)
Message-ID: <720eb684-ae89-4003-b167-e427b4d31add@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 14:22:57 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] clk: qcom: clean-up simple provider misuse of the
 consumer API
To: Jerome Brunet <jbrunet@baylibre.com>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tero Kristo <kristo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
References: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
 <20260724-clk-provider-simple-clean-v2-2-56f306156d25@baylibre.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260724-clk-provider-simple-clean-v2-2-56f306156d25@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExMiBTYWx0ZWRfX6gwmqKiN/dA+
 1CvSrzYNx4bnkYn8hmHklEGHEGyQb0IAnPvLU7/ayR++BC6F6fhwSNUgqifP5FM1fBq/4xmL+Zn
 uey669kjZMsCB+cSEF4T8g2t53Jfn20=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExMiBTYWx0ZWRfXwk/AW9sXOWZk
 iC7CmVasW/C6ErK8damAsJyVtuAw4lVUiaHdieSdU6kCf4xj9PnxHtZ+2ixhe2m6osQY6Dyovyc
 CeObk7fccNO4cLI+F60tuEAkuVDCEPVlk2uiUjTNPbKjoeyCCxGA7C3i27062nU9fVpxsmROIqr
 1DXHRJfB3Ap4HnFGfbnhdzMy0qsYY0ACksPZOTDaDjiobeGG9wF7dd4ElJjoCpQ2Ls8BP2VVi4a
 pQNs5ZQ81Qsyz0NJngzfhrqFQ5ntvD7jsYW4dU+w0L/g1QCa/7mdkKafcTYSezZG7qPSLPhAuD0
 osq8S9oZJUi+lD6xYok81LhwNFaMmsE8gK8l5eHthza3RsDMDFJ+8+EXiMa7mnGvK04Jz+K5GWv
 AT4D1PStHJmkJzSsz1J7oTB9zemRViinG3cIEX5Tn3kYUlRVOUYF8gRSRCDQqNmgmHHhNPFP4gI
 pxzXBy+CDg8sjbCE5uw==
X-Authority-Analysis: v=2.4 cv=Z9Dc2nRA c=1 sm=1 tr=0 ts=6a635926 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=4bE8Fl-H3dgRu3KWX3sA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: An0aSz-rxDRMY4cRVtA_jmydJWO0YCX_
X-Proofpoint-ORIG-GUID: An0aSz-rxDRMY4cRVtA_jmydJWO0YCX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240112

On 7/24/26 11:03 AM, Jerome Brunet wrote:
> Clock provider should not be using the consumer interface.
> In other words, a provider should not be dealing with struct clk.
> 
> This change targets occurrences for which the provider uses the
> consumer interface and corresponding clk_hw interface exist.
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
