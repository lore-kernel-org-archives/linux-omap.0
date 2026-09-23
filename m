Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A995A3749F7
	for <linux-omap@vger.kernel.org>; Wed, 23 Sep 2026 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174537; cv=none; b=UAYjn9bt+GtMFHacP7SLV0wFmrjX/sdqlzsHqeEzcb69Kx5oAz/fGzlLhNQUlSkjWncfrwiWXVaXj9qLRfPNUnrgj0vecWg983uxWwqxPTZnSAGUS3lf2vguWF+Ba71xh/BsOGM3WZzDVAoMTTLyk68tR7SvfTedfqL/qBPQKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174537; c=relaxed/simple;
	bh=3Uj+B1NgxgU58OpZlj2YX/Lnv7Y6GkrNPSxd8oQ7guQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDqwcZvcLvXdMKUQ4rgktHIx1RdfTTOFXdz6lj038ZwvhGr1yuh/I8KYAWUb7CCryFMEVXXr18WIcGqFQWkHwNK7IASanyEWjsZEQvNaMzVISL7Eij+YWQJoNyA4GivL85/nT1U075jlEuwAxBSe39LC2qPCVicf9Qi2pB6jlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ksc0vwm0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=akgVYc5s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ksc0vwm0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="akgVYc5s"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbRFd3295400
	for <linux-omap@vger.kernel.org>; Wed, 23 Sep 2026 14:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zGf+MRsaXm8VLXvKHe+lyfwUTfJuXmVtuDhAYC8JphA=; b=ksc0vwm0bbTIijxq
	3o5bW273wzguMNDnOnaaZrH9ilPdnHjTF9CD1yX8g1i3r3N77Afg+gZSbXduibkn
	1zbn20CVDYWevvd6RYf91VEELDjvX+94i0ePS9kITvm9seFjLZjqNM8V4EtTwgKG
	qFzgsVqkPS//FdCWRWTGmXR33ziGGz55vtbEoedQQ0gSP2bKiS0LqZoOREJAr53f
	ExSzqfCD5nSOlvRuacxMi5HfMtNM2nGzfIjxnqaaDFs193CcfhHY8tjsvQLmB9/A
	tWM2I7wfd3ePtcqBveN4zXkof3+gY0zxBoeYSsz2evUdu662gj2m+C9zGj8ssc+h
	FEylNg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwm9c95-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 23 Sep 2026 14:42:14 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98513b850f1so143076241.2
        for <linux-omap@vger.kernel.org>; Wed, 23 Sep 2026 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790174534; x=1790779334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zGf+MRsaXm8VLXvKHe+lyfwUTfJuXmVtuDhAYC8JphA=;
        b=akgVYc5sovooQs1vCGcu6LhOAcSl2ohO/1OuoMdaaqYAS4ZfSqL8nUGN2CIzvxsYn+
         28I/Ys+cPniX/fx434JtSQ9BvNRP9N4tKiBDYFYNasdWK1wNzWaZDCAiH+4duPyG2564
         uzThh0CrZnhH9TSujlZaw8qPWvQMN2UzY2dOlvlvflmNeD+c9i0judB1O5HZTEkjXooc
         Jpy/fg2lO1vwWMEhsyCwmLIDc+iJKtbm7ZKKLIAu2rPBEJxIWnDmD+6+RbZmd8eIWnwq
         XG/4Avi93gqH+qZ6TISFHccmsKUo0Xw+yQ7Ds9LGkNvD05q9uUYr9OwhVscgcYsg14MI
         gqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174534; x=1790779334;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGf+MRsaXm8VLXvKHe+lyfwUTfJuXmVtuDhAYC8JphA=;
        b=mkFwB+IM+bn4Q0lU8J+1RdZHdBIa6iCXCoMMwzO3TwPLpb83lNLBwfETQDzrN336Ks
         EgGOOCWqwfbZljKHZvYWmAG6/X0n6ed5c5YWz38bH9qBVlNgfuD7WejNb6eOjT+bpffi
         TZheAhGaSGDDQ+G+uhwskAwFonqiHjVeFShA/58kex7QGwZKynUFB/p3MjN0vNOmSu+R
         5Mcq3iF2bLFTS/nAGyFI2SuT9KGeSG2Fmty9y32FviCK8Eb5LaA9xHONnn9GFrKkQZvA
         Hijj2HAQDK5KYamAHLhmELYZgMEjIxIuD9Yv9QCQmUrC/GaZyZR7R73yRKShNIsIc3T3
         jAxA==
X-Forwarded-Encrypted: i=1; AKwUvByv/RZ1OqltXNduucJtALi8pWO0962uAle3VK6egn/f55N9ZR4pd3toP6pplO2aMnSBlvUVcH1C/nvH@vger.kernel.org
X-Gm-Message-State: AFuF++l3OnpkoYeguty3+LjMG9B3GqIJCmT8Vp7D63t0IbOE6zQ8J3JF
	jO/dnF/MqK0yviY0w3FvB+DjiLwoxprOlRZLAQkx8Yw5b8iOSND2VSBV8wRTXThAE4M35be0nTJ
	NIc7bRsOHq+zLoV4B/esZ1QrxDh0WEX7x5HemofP9UzK0CGH7D7lbXy+f2I140rFn
X-Gm-Gg: AYBFou0EJt5Ko/m9PrhGuSYREjmnxEobvl62NFkH1q8YRDNfHXMGRwHwgHw61Jb/QLB
	NnQXll9AB0MWr+xn6wp2xgYG9vpsVAtXNxuvZ+dnpchksbM3abjN51qvdWOQJ0uEOkHbj9JXAd/
	9BsN6Y4jgbd5pBMOuN3POkTIq2do2JDBKw6Jlmy5ANNcqGAZRUylRMmHO5cItY0rt99t8HDgkKs
	jVdeo53VIYZAbh737o216FjkQHFPacFEXUQd1UDuQD9qd9CCbX7z4oN6uKiA2Xn+tCnROIJ72yK
	uk8VORwURJftY+7L0hnOH1xd86t8b5EKjcCKTXGEDmUOoeIeOQP70cefpjhgo+tJqIrgG+IpFKy
	MwbyRfC7xFl2bzob4Rf2pW29erwk=
X-Received: by 2002:a05:6102:162a:b0:7a8:2a34:432e with SMTP id ada2fe7eead31-7ac1b81cb78mr2670606137.9.1790174533741;
        Wed, 23 Sep 2026 07:42:13 -0700 (PDT)
X-Received: by 2002:a05:6102:162a:b0:7a8:2a34:432e with SMTP id ada2fe7eead31-7ac1b81cb78mr2670574137.9.1790174533193;
        Wed, 23 Sep 2026 07:42:13 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:34c6:dbd6:5b58:a3fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde134739sm76935275e9.0.2026.09.23.07.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:42:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Karl Mehltretter <kmehltretter@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Jerome Neanne <jneanne@baylibre.com>,
        Jonathan Cormier <jcormier@criticallink.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Shree Ramamoorthy <s-ramamoorthy@ti.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] gpio: tps65219: Fix TPS6521x GPIO handling
Date: Wed, 23 Sep 2026 16:42:09 +0200
Message-ID: <179017452737.62498.16565807565260585932.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919171100.90430-1-kmehltretter@gmail.com>
References: <20260919171100.90430-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX8vuW8aJh4ZNF
 4JIYEXbvxCWNczIr6G5lRYZ+nRz9a6EGEtamZ4KsPoeUjv/9TRtqlPxEtsTe8zNejPhI/uTivGa
 /B32iXWz3TK3XwJ3c+bmCOyLMhvEPZk=
X-Authority-Analysis: v=2.4 cv=R/6WitRX c=1 sm=1 tr=0 ts=6ab3e546 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZxkUJIZQlAJGTDoIxtwA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: CJro6vGTvqg3__-X7hYQWu8rs35fxxIV
X-Proofpoint-ORIG-GUID: CJro6vGTvqg3__-X7hYQWu8rs35fxxIV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX7oaBBCzCYGBk
 wQmUmzO+WvTELhLJtcAjGplYxRnB9Ww/F2YhhiuYIij7xnvhNFLDXlf26KLqhXi3bA0BsjpEf61
 LRK+fVJ225xtNjUHv1unLGxy7AWr7Abro/I6NQKvLaIOoxqcHk543pLVfE9X8OH7oBH+R0EsIYi
 +IpAQvvUwlgsGhBASTb7AlTAFaqgd3RYvpAW53p3MH3Wzjj/B73r29LsJ4JUqeB+wwPPtVEiay/
 No9a3flkm9cWBVhgE60uiUXQaa8ooRQDxZUV+9FUblthW2JfJyXGUHYLRicvIb/fQdUpGcK5LGb
 oBIATejP32gT3+mWVTcwCIOyGYlbzIIrAhI8N8E1shlNPlEZ8Id03IrIJGqFWlK8fKXIz8blZdV
 SMlRFgee0VRpOR0lV7idBUg66POJ5ITUqkWCv1482N2tDs+4Fh6b42mwCN9mbGuAGKmx++sFSmd
 FS5iZ0PzOB48M76fQ2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230058


On Sat, 19 Sep 2026 19:10:57 +0200, Karl Mehltretter wrote:
> I found patch 1 while looking through the tree for code that mixes up
> bit numbers and bit masks. Patches 2 and 3 turned up while checking the
> nearby TPS65214 code.
> 
> Patch 1 fixes TPS65219 input reads. Patches 2 and 3 fix TPS65214
> direction handling.
> 
> [...]

Applied, thanks!

[1/3] gpio: tps65219: Fix GPIO input value reads
      https://git.kernel.org/brgl/c/4cbe530c0233c7413aaaeb029a4f32dd6aadacbb
[2/3] gpio: tps65219: Use the variant-specific direction callback
      https://git.kernel.org/brgl/c/93cf8cedeaaa05714f709b539cfb976e0b80c830
[3/3] gpio: tps65219: Fix TPS65214 GPIO direction programming
      https://git.kernel.org/brgl/c/270437f3fe62516f16482742a7762a075e7a9457

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
