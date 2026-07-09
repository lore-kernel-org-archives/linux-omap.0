Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531141DC1AB
	for <linux-omap@vger.kernel.org>; Thu,  9 Jul 2026 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601168; cv=none; b=q1Op5oWtHpsVkiCkRCxEQv6GNS4TdwxYLzZ/bAt6XT4/IT8xFsm1U+eIHrsXYmXdfFZDVgteBcjd5VsAMXyO32kqPY4fu8mO1uZ/3eIiTvwMjZEnx+bdUQWqycEcHtGoObYm3/CfysN4t5Ic9Wowuzpm3FGxsXy4x64d021hwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601168; c=relaxed/simple;
	bh=/iG9LaEOOKZae4ol1OEca4VnoqsdZ/YxkgR30xJdOu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFW4SVUsBtkb1r5gnzJfpjdxLBErMGVOyDGUuWd3gR9BjxQaE5JnBcjYHBTjKNiG7dj/SS7K1pCrQEvgRindW93TX0wh5isBQGUjl2mvay17tThj0la3aQWh+0FbbEnAPhudNVZdW4LgZ6+X+1o4boSdCUuIQWWXK2W0uFh5rKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0/y0OAl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WNYNeNy0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0/y0OAl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNYNeNy0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNQnw1575682
	for <linux-omap@vger.kernel.org>; Thu, 9 Jul 2026 12:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vhHFYSLcv+6lYQ28t2RolA7btajCBASXtU6eML3rNHg=; b=L0/y0OAl+AJJOS7f
	w1PWvdtiYchzvRoPPGZqJ5PC98dZZjGkwHWPnmyI6lPB4JZ+Ch5QzTuUsb8GAI3S
	uoOyMLGYwDBqyN8db+oziIhRKWnYKbKIYpB4Ugdo5K906W+JosP8C/9peN2Uic+6
	FrUTAqylERxjEUAC8DmesG62n6SDOCQ218Ur2HHgA0OdxxF/3QFMpg4n4HUH1DXo
	pW0BKIKVtQmUVYkWNrYqohMTHT1rT8KyUjqW+tA+tTm319j4f3QpsHe8QNaOfi/j
	80OoPdp1MGq2xuPTsx2olI93kDkLY+qvmWo8xaiC8KuMDkvJEPhRkOO05CRYVxZ5
	Amnd3w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwc830-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 09 Jul 2026 12:46:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8952346bb9so1604672a12.2
        for <linux-omap@vger.kernel.org>; Thu, 09 Jul 2026 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783601162; x=1784205962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhHFYSLcv+6lYQ28t2RolA7btajCBASXtU6eML3rNHg=;
        b=WNYNeNy02E0dUknscEyLdj2ea2RVm6lv0wjI6LtGz+S4iXX6ld9vjxthxwSMaw2Yyp
         8LnDuNGHmvwUth2y3XYKfNcNCowtrn9nRnwyGCnM1/tXRGn7MUckFDORpwr/mn8lxigK
         YCleCeRc5B0H+AtwSOwBjzJRl+T+WrbI7kEF+FoyVpV0lp+ZR9O+gRR9tcY2KskM1wBB
         uNiARfXHsYUgwokR2LltuyAolUAjWRuKIT1oz5GYnrlRi2xMgtVnoyEyCOKJuNEzxAPZ
         2Qkg3RoBuczE7VZJTiKyGkoUwMj8nei6oThlFCmiq2SudPwDhup4ZU0UdrlHXDEzG+6P
         yPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783601162; x=1784205962;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vhHFYSLcv+6lYQ28t2RolA7btajCBASXtU6eML3rNHg=;
        b=CLbiu/4AUlpI43eFb40T34o0h8gkgGsk3+zhuecOde8xHp3pcFP2CrnEnQPoR2keON
         oOLtLWtImjkYwW/XW0S4XQF1zuMqBHip4zO22sA2mD44eVSxm0kBO2blzPVfNiFRs49F
         3Ksx0evQObKD/7tf9bG6rACCRBZ9dmX8vlV3UhZ9Ub4OdK7qFF4TTEz0nTouuRsAvUFk
         vWsuIfOZp7Hfyn2LL89Ihiy8Tr+2GQdaEpYUXtiSsw2jREIKLxSaPuo/qAAZKA3kzd7j
         A/8sSdqv0tk/6bb0KspsFEFsQns5Sz4/za48Q2KYQfR15nBTNdrgMgYGr7w63BVyZVBa
         0j6A==
X-Forwarded-Encrypted: i=1; AHgh+Rpxl66j2Unl/mT95Vsac+R3nQ6z70arw7QjJGNWcmDb/DhVJVTyFTWR97clgNerrSE/vgH/VAs5sj/w@vger.kernel.org
X-Gm-Message-State: AOJu0YxS9uNvMuCIUHUJtL7B14zY/MumYPbpampzall+RumSW0dgYLXd
	cFWi8S3EMb53ZjA5rN0/jOTAzn2LHIePBsTg3ZZsan17i2of7ISKhAVQ+1Afh2YCDRG2YfajFMO
	/T9Lm2tIzy1P31e6bUDxUYISR2yN/zCS+/nWYGtjWDfS0aLu5ewdIRKDsm7xCzKxx
X-Gm-Gg: AfdE7cnor6wsv+KLcs0FK4d6x54fgYQTJz06S6Anz7fJUJOkYW09gNQpgkDYGsRErmy
	Gb+7UipVNPcVbVox2Ig1gLRwmYzr9cIZf6V3OJ+cHsiDl5cKzbHpSDZLS5R06rYb9cr116S+SbO
	nmD8n3CDr8Qy1JTxYKD/nVAH5IEWtAu4mqd19XoNBauheWCLmAupDmdNWFDR949S2Ts7tOBO2Un
	ofyC2CldPYuVcCcUbjwXEK2AfELOSxj+a8LUbjy4oh+7AoeYpWhE4aEGkKKABg0DVgtb8G0gFt9
	IXU6A5vGkf5bgnTX5/t7ojNVhQog1v3A5VKrQX0Sqefp/JRP9P3Cw6ZGURVI+7kWhSAI3rjW3I9
	r74hc13hMgFRzLomY4fCqirQP6oS3f9BOWohzqVZGAJs=
X-Received: by 2002:a05:6a20:3ca3:b0:39f:acae:f12e with SMTP id adf61e73a8af0-3c0bced482bmr10459344637.22.1783601161843;
        Thu, 09 Jul 2026 05:46:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca3:b0:39f:acae:f12e with SMTP id adf61e73a8af0-3c0bced482bmr10459285637.22.1783601161268;
        Thu, 09 Jul 2026 05:46:01 -0700 (PDT)
Received: from [192.168.0.6] ([49.204.111.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac178dsm31739101eec.28.2026.07.09.05.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 05:46:00 -0700 (PDT)
Message-ID: <bc3afb69-bcf0-4a73-a9df-4321c32707ea@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 18:15:48 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] tty: serial: propagate errors from uart_ops.pm
 callback
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260709-add_return_check_for_uart_change_pm-v1-0-e85c6ffa8ec4@oss.qualcomm.com>
 <9320a573-ebf8-459b-a313-3a8b73a6180b@kernel.org>
 <5eecf3a0-b608-4057-b400-236f6952b380@oss.qualcomm.com>
 <ak906CqHYDooQTVu@ashevche-desk.local>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <ak906CqHYDooQTVu@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEyMyBTYWx0ZWRfXwqzMVY+NWGi5
 VGU77/gRZseQG6tD6u5fLC7UOP7RL7n+ygATLgNOmRIupW7HE39Nla9UF0dFrlud2Bt93TRLKJU
 33klbnDuufZhulqgX0al7G9bvCMLjxdPlOrl0aM8HbwC2mNGGnHGB7EsgsO4FWuJ/cYTh6N4dOA
 r2XtcISyKcyMgo96BF2oPV4y9SDaJW2hQZ+WsjBN0Ih4uoSMSWf2BaWZ3unYZGcwEeT9YGFPcRq
 lmtc9xSjt5XUQPNVo2h95rzduJO+bCSvBq4Ggmj11s1/5ZAclxz3GrZulkFCTOmXb2cA46K6Sl6
 NzNNPqrFJFqXAf60FQrbuQorCmP9ZisbmgDAIH+xy45RscSugq2P0K9nvAXE3MN8FxgDMMoKAJ5
 WEBSOv7/u1hWozLetQUq0W9txQ9qxOklj5m3/0ucUMs8s8HUKQc41kPXM+RBHlAL9bbO/1AeWOV
 kIAa0mX0BD9S92998wg==
X-Proofpoint-GUID: 05pfFk_coTWVriaoxlqPlB9mb55snWf2
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4f980a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=vz+FLylpEn3mlzyIWlmD3A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=2TZWhx8y46JuiruMumEA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 05pfFk_coTWVriaoxlqPlB9mb55snWf2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEyMyBTYWx0ZWRfX4VS9vaBbS+lB
 PcbHE3n7bR89/ufHiKuSQnOPTlZHozFE7UDGyIsyGSdLr400A8jWvHvfIus7azLdslQ+4ENhWkZ
 YM24Wz+pVmKyIDX3pzTW6zyljh4kKdc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090123

Hi Andy

On 09-07-2026 15:46, Andy Shevchenko wrote:
> On Thu, Jul 09, 2026 at 02:22:17PM +0530, Praveen Talari wrote:
>> On 09-07-2026 12:23, Jiri Slaby wrote:
>>> On 09. 07. 26, 8:25, Praveen Talari wrote:
> ...
>
>>> OK, now I miss the rationale behind the patchset. Neither there is a
>>> possible code path to actually test this?
>> The rationale is that qcom_geni_serial_pm() calls
>> pm_runtime_resume_and_get() which can fail, but its return value is
>> currently discarded because the callback is void.
> So, you take the solution from a wrong end. Just get rid of .pm() in your driver.

Ok I agree. Now i can control resources via PM runtime APIs from 
startup(get_sync()) and shutdown(put_sync()) APIs right?

Thanks,

Praveen Talari

> With that, problem solved. Really, this series is a road to even more broken
> PM solutions.
>
