Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887F63C1D73
	for <linux-omap@vger.kernel.org>; Sat,  1 Aug 2026 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785618560; cv=none; b=QDd2uCujBzRwwDym+PAHU2nR7wLoCfdFts2Tc5hLKeih26vWKMiLmoyFdVMBI2Ek8J55Wkod7atoWc9oM9BWpkHTQFKTvufLKHoa18X3uuVV1IqAC1ZCwjwxufG9gyjihsCfsX2fTMR/o43AoofhN+9pHf8lDLInihLsPv/QECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785618560; c=relaxed/simple;
	bh=2MkiDQ4LR3v9Qggis8f5b96KMm5T+X1N0muAXGvlHhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I3Tb/adoRF9583a2lraCD5xj0O1Jkbp3yvuaJEpecqXzl5NGYWcJIAKIlZjluAnlQ0bJtyRL4AO1PYGuKWbEOTlogTacfLfDmhXfU24RJxhJcWgaDDWow2mM5hHeqWiRUVFIVMovFgPgK8h/slesBREV2/D9CbzuX54V60ms2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TjFC8Fgx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ePqMKnOJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TjFC8Fgx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ePqMKnOJ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671J06MW3600705
	for <linux-omap@vger.kernel.org>; Sat, 1 Aug 2026 21:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+QnrZ4/gBqFlKmDVWiKKlCYQOhkw0/cY20YHLWTsZcg=; b=TjFC8FgxcOufN75j
	lrBlnQz0MM2v9sHtA4O3iPYNi432rgEEkoDs9BYLNBE23EFR0LT4FRf0OK+7VKHL
	JRTn6HNuLGxSTjz1AlJ8tCeX4yC/nWFm3iVDTPF6HUAI16R+AZD3hvayAK08Tgzo
	Q6u+6VOoibIvaQcfVmFKreXp/+tI2RX7NLE2ieC7IKh3DzyKR0eaoCA04FCvp4/v
	EE2pNXAeHeFMF4MhyQ8PZij2udo5zu9H/DPJAPckJ8bH2Y1VlB5hM/K1mZQeFXdg
	vsebUPM2AzO3SCwCB9aLbrSgtvmF6XwToj1qc1Da6j6AeqZKeGvyB0X2gFKcIlWC
	3PERsw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs9jfsjaq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Sat, 01 Aug 2026 21:09:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c21c01cf3so38319741cf.2
        for <linux-omap@vger.kernel.org>; Sat, 01 Aug 2026 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785618558; x=1786223358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+QnrZ4/gBqFlKmDVWiKKlCYQOhkw0/cY20YHLWTsZcg=;
        b=ePqMKnOJZe1pjvszuzNWYz0TfrMghCu0u2hzJuInNxSjQR31KyQKHZVDwUh4a31r7J
         o9pTQVRDGfhC/WAHcFWYI+aLN4OMZ21CGXkRWPnPOBX54zE/oia1j9b+VnlZ7wD3rVvR
         oI0og9D1sTyOb6GCT+s7hO2M8Q7NqDf3AFAW8mfrG52LzA1pNu4/VCuoXrb7Guyd9KTe
         oJPvNkTmTwUgk9+RRMfuHMolqQS6R/p95feYzPCOodUbvI6DkYgTE+nD/AVvw/Af4yOX
         ND0bWROaympnlQ54ALg1ZoVIDjhYXFBv/LajRm9C7fRoNRrnbTTiSEAP5elCZ/D+LyGf
         iKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785618558; x=1786223358;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+QnrZ4/gBqFlKmDVWiKKlCYQOhkw0/cY20YHLWTsZcg=;
        b=Vwc+5T2tRvSD3rktCttpiK8BxHGSmolQgPoenWkf4sP1HQ8WBTj/Ldqre7MqvGOcMF
         3eL3ZSqR/GR4L43XzpqFj06wxARMM6uMVHI4C88Ut5Ldr5iGPSjsk6wIRq8zRA/VvT8U
         CzWnftlipDjNyFOpvghN10kCMNK5gjCO60YJU+KQ+PEzxmR1dTnQfQ2W/n/eIY8a/iyI
         TuJseEVltSqpfnrLW+6zUp1ZKmMb2PYUlP1KBtfRRy80rvnWweT105xTajIsqwOtIinZ
         NAxJXmR9EBU6UJCBWT2Xvy52ppgAVWo+0GZHw8uuWUwOQLwKjlR2468h2eT9fDd0dA5/
         AIFw==
X-Forwarded-Encrypted: i=1; AHgh+RrEpD6vlbSk4Ms2ShUdj8YffLSkryZSgh/Pk5Z6O6y0YlrRaAbjTYYlfPcpGrazuPYg1wI01wxJYGQO@vger.kernel.org
X-Gm-Message-State: AOJu0YwKhF/T2448tzoPFjvmRKj6me9uewkSSM5RlFGfxapC+NexL+SG
	h9bVcj8iZ+cDIVEHoyvbHQ/HjJ45Ya+/OKGQvCdc7v8M6224vfZ9oD94sGFcmgQTiXykYwl9P6Z
	UITtJ5x2jS/6eEwPc6pMi+vk9vrYwE3aWBFkqUVZwCHfrrcDxURPlCBZ8oBn4IuBT+iXmAeeT
X-Gm-Gg: AR+sD13Wypb8uAhqRnzvJlzrn6AcFb4gJU7STYWOZ28ChpkPkr3TQNAS/cMa4t6i15o
	BUzKs/zNs7EsdsH4hLN8d5zar21Wtn1Wi0nFvd+Gx88e3E8UriDV4DigqWzzNE5jj9J5k05nBbo
	6wPT2QvPyqgo3CvW8FX/Cp4jz0TrmsNO7MVEyGM8OfGiSGkKn3Vv0FB/5xgRJIBAgA0IXAByOgG
	A3qk4NBtDPPhFpLFcs9pJ6RIjLpqQlqk2BWg+z2rJikPGXcLHHVy6YPXF66jLko39e1Q+4y388c
	5nwIQ5aQsiRSpLCyxUfJxtLZEyfJxG1ecVPLTZ2IqlY3v825kGfGGBsHOsv+TSVj7SAUqMXcgEM
	KyyOqSeSlzkkI7SYgGXCDox98wY9U6g==
X-Received: by 2002:a05:622a:53c4:b0:519:5680:1b5 with SMTP id d75a77b69052e-52b5674be9cmr112046111cf.21.1785618557655;
        Sat, 01 Aug 2026 14:09:17 -0700 (PDT)
X-Received: by 2002:a05:622a:53c4:b0:519:5680:1b5 with SMTP id d75a77b69052e-52b5674be9cmr112045761cf.21.1785618557262;
        Sat, 01 Aug 2026 14:09:17 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91bfsm18716122f8f.15.2026.08.01.14.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 14:09:16 -0700 (PDT)
Message-ID: <2d82022e-b7cc-4b73-a423-9ca24403a484@oss.qualcomm.com>
Date: Sat, 1 Aug 2026 23:09:13 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: ti: Correct white-space style
To: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20260801210404.383925-3-krzysztof.kozlowski@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260801210404.383925-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hfbnkNhaanMlrYd-v9OAWaS39-jlNvIy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE3MCBTYWx0ZWRfX19jksmcSKRIq
 +u/kUzYe6zBLsONXnyyntSUvThSkrGglLNigGR78rYdZ88WYm/RdAeaxpl8XoVx2IaSFztyXxKb
 zx+YJKwXHu4Gvh262Kc50W8jBWbB+2cLiamqMehfDw8vd5srFIuVoXaNuexEiUqOd0hbM2Qrc38
 oWs4sO4Wu5rF1SZ10MR0aPPPs/BllTqi+PWhRF+9rGPKv/9TrQ7DMEE235iwxqvolw6efwxh5ry
 mlL6tICg9CKl6h3fupDPTwBT/QlNAmopj0Uk+QENwwLkjy012NyxmYmTd/vq0u1WotZCCUqXEG8
 ohPhWQYzsvd+p7T+i0sZvkZMQVbQcwQdq4YqBnRIzIGYNILHyCSezIuKFsfzsYrQrNe3ODscQYs
 OB0Wqu+WzH93DXKQRBPhtaElvxZ4hzUB66ofSl5upnFHu+56dpfmK/T3SOTqncXBte3ZwRgXVWS
 Ks5haH8EwdI8OegcyqQ==
X-Authority-Analysis: v=2.4 cv=TYSmcxQh c=1 sm=1 tr=0 ts=6a6e607e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=8u-3XouvhUw7l0pFq2gA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: hfbnkNhaanMlrYd-v9OAWaS39-jlNvIy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE3MCBTYWx0ZWRfX/C+tr2N2i+t3
 +8XI6/2n9DKINX6zl2ma2/+rcEeVvgXGiCxj4l+GvJDaW9zo/LKYgZW+Ank94TThBtWfgPg2lVs
 rEjU5Gc4M9EAj7woP4MJsOVnM6E7Flw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010170

On 01/08/2026 23:04, Krzysztof Kozlowski wrote:
> diff --git a/arch/arm/boot/dts/ti/keystone/keystone.dtsi b/arch/arm/boot/dts/ti/keystone/keystone.dtsi
> index ff16428860a9..22c8b8b04340 100644
> --- a/arch/arm/boot/dts/ti/keystone/keystone.dtsi
> +++ b/arch/arm/boot/dts/ti/keystone/keystone.dtsi
> @@ -123,7 +123,7 @@ uart0: serial@2530c00 {
>  			interrupts = <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> -		uart1:	serial@2531000 {
> +		uart1:serial@2531000 {

This needs a fix...


Best regards,
Krzysztof
