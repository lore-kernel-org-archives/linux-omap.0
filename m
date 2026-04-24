Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BACB1A9F90
	for <linux-omap@vger.kernel.org>; Fri, 24 Apr 2026 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777008771; cv=pass; b=bGzfttIdy6l7nxKLFwsmNanrLLv1H8nZoCOO3zbMKlTs6+IrYppEh5mU4lIm2zoGaBwiB3yEm+fSY5LaoS+g47vO3lO4ixPVKqO/ECKBbs8QvVJsJ/nqsOFvfkxVOfI8OLrM0b5nJCFvskOJlp6IL8FOyceaufgCIGuc8tQMm30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777008771; c=relaxed/simple;
	bh=WeR454MIF6XD7WivrKik5WjQw4uaLEFSXdm3lgCCH+M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JUGsnopYwG/pVDM5wb9USy3MUE9K6cf24Dc5B9cUMMlm539wq3uJ3DXiTaCtWo3LKlpFivZjSG9gDxiajSa+j/2zbMxAGun6hf3h8BPkcqqk0CXpW5NLOdnOS7pu6K0rGUydlmQNnLJGysYYEepT4ymlpdZZSAyvF/hkMb69H18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwmnBEVf; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwmnBEVf"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7986e0553bdso71337287b3.2
        for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2026 22:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777008769; cv=none;
        d=google.com; s=arc-20240605;
        b=Ary5m1um9u7M1WwW7a6/cn8ptK5YgkiABBrh0B8K8vKRd0K4uKd6EOnxd+b/BRhm5i
         oGAsXh4z2ZotA+uDRi8zMIqzdmfwGdIlGtTGe/W2iIkX/w9Q9obF0yYUevGEHvU+QFgJ
         k430jhtAKklep63uFKsiA4WXXXVxJH+rWhlGBSzaQuOi1vI8arLKsTVyqIFo95oHBTD4
         ncnqIxcPjh1vrm1p7ziMPYDc7j4bZ7z1w9CB/JweVqZHc5IFsYFc+krK7pL/RAAZ6aNg
         mqmwkfJtSohPx3YmI+gRi1DXC+HxF0DSXnRzSWa75iwS12pTUhYrlV1xUZlptETPkffL
         1zEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=aTWDo7tfrhFJ+mriWX1EXSAY360G5GQcYwGOoiyouIo=;
        fh=GbaxtsqtgzG0GRlKsQLbsiPsA74pUp3ufNym1hQI0jQ=;
        b=cUeJqtMkWqpQcqCrDDwi6FaaYn7Zhlq60j7yzQLFqigEsgA2Kfxgv3G+xtviJAfD2i
         aKB+IWWHkNrq+0e8NdGie8BhhzIC3jXUxKb1MspJD5IRRGCjW6mmAua6NRHRLJmewTK9
         pXe63ZlDwif5JLXEtO/fC5c/hHii7/qItWl3SC2w1/zAlAUg6qW8VzGF9o+x72owp42T
         lt5ASOsYAMEWWlR96qRpox7tlqZxl28cpu/SFZDTmTEWcvFcWHKwLCOuomcjL78Z6yna
         ApyM3f1ZWFxwbv5RqLhE40pXwOV8nihhuEysu7VAeddq6oEQYgAKSY4d3oHnTb+56BUU
         a4vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777008769; x=1777613569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aTWDo7tfrhFJ+mriWX1EXSAY360G5GQcYwGOoiyouIo=;
        b=rwmnBEVf7uRtUvdS8ToX0USskf3gXagrH/WJ6KN0/1nm8F3D1WwqiHm9wwCtVyupNv
         9hh60z//uPHKWhRuwgiBSeYae/E1df3OtWkK2WVPhStSo+FD76frtVPJX1B6qh9JgfUM
         oX7EqxYrIr65+kNlW1wXFAOZq9WN5s0SAT5Bdaz0vJ7Qar2z/CApbxQScO31HoEWXJFL
         qO0InWUY/O4S+F2983E+DtjCoT+kJDcMoxyumSAQPJwVqzPgF41fRiSbv2VXWVYxz9sx
         JqhV22Rf4v5BFeLMpoyhfRQ9bnzDM/yptuv8lw1adFoPYtMK8NrvIf/eOWStzlxaQ1m7
         ScOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777008769; x=1777613569;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTWDo7tfrhFJ+mriWX1EXSAY360G5GQcYwGOoiyouIo=;
        b=qvkEv9T6zLU5bUhkVTz2gdxpV7kSpcT8ydWD5suWBQDGCWTIW/SvRMX82nE0vVo/IA
         A0oCi3yxXSIRyiQiPIaupDOyem7B6YWKLD1kGV4OzyeCf9ljozclzdc69n7uaO4EeIhj
         7mIGRw/POJ6T1InyA1SGrE0OKbSj1KwGGYhBt6QNI997ySuxmbE0Mod18L4DNlFIgunG
         NXpBlgfNb+ZsNloMYxAfPHfVBbvadc/6otFBPegS9+cx1zKIcBttiqerRqKEX/WkNnGL
         SxEPbimRNV5PRiPj2xsQkIBlGSsSvrWHNCNIt9LUox1v31d5RA8D1YDptOPuSHHPh8x0
         KYmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sXqzfXYj/LloV56629VKV/oRM5fEHGezx06ZX6QDh98wi1otM+SjUIq91UoT+dRvW2/JkDT0vUpHR@vger.kernel.org
X-Gm-Message-State: AOJu0YwmorJXItxjoy/bD2H08YiWUGRf0UwlfXa5SpoThkL29tJJ6+u0
	z8Wi2on4W+aZNSEvJi/1aztC4htoPc3876n4wiffurC5LDGrG1vGeqAhpBxq9BwH/ZcOK1Afznv
	s7OT0S8NjhQ/1ygf8Urvv+MgvGqir76A=
X-Gm-Gg: AeBDiesCOWAGSPlnjS/rr6J9GITa7pWiwqsZLSNFGQA9xQdd9pVVYmagLTbSJoIsDDf
	9u8T50ugb8PmkdJRj9JJ5OkRXGpOV2HTqv/reZhrhEdE0sbIGFWhEmDR73hg0HXc3eF0THrKKU0
	U/iBALNk7xapN4rm/zH+eDM75KUoQFLnJlJvuGxy1pSnU/jN3lHBPgolVVCXlhl6u/lNX3bwmYt
	dR6Mo+7sIOP9MKVW3JxzqGWuxixMJTt8nFXnipp2c3Unq6BVzgdjY4DpS0WKT9iC8p3ByVvQvpJ
	A2u2/WAR7TE6gBFG9phM
X-Received: by 2002:a05:690c:f06:b0:7ba:e1dc:1b3f with SMTP id
 00721157ae682-7bae1dc26a7mr239188277b3.25.1777008769560; Thu, 23 Apr 2026
 22:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Fri, 24 Apr 2026 13:32:39 +0800
X-Gm-Features: AQROBzAftKukUZO5qXsKq3OfljKiCLNFqNzHrr6GoKnbrnXrbHqj9W5ZAtNDkkY
Message-ID: <CAGp+u1ZRvs6UJDRu1041mO93DsQvM1dkZ0CZRfEEsVBAVPvKig@mail.gmail.com>
Subject: [bug report] Potential deadlock bug in 'drivers/thermal/ti-soc-thermal/ti-bandgap.c',
 between 'ti_bandgap_write_counter()' and 'ti_bandgap_talert_irq_handler()'
To: edubezval@gmail.com, j-keerthy@ti.com
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel maintainers,

My research-based static analyzer found a potential deadlock bug
within the 'drivers/thermal/ti-soc-thermal' subsystem, more
specifically, in 'drivers/thermal/ti-soc-thermal/ti-bandgap.c'.
This deadlock potentially occurs with the involvement of hard irq.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
ti_bandgap_talert_irq_handler [t1]
        --> spin_lock(&bgp->lock); [t2]

T1:
ti_bandgap_write_counter
    --> spin_lock(&bgp->lock); [t0]

T1 does not disable hardware irqs in acquiring the spin lock. If T0
(i.e., the hard irq context) occurs after T1 acquires the lock and
both happen within the same CPU, then T0 will not proceed because it
cannot hold the spin lock that has already been possessed by T1, yet
T1
cannot proceed because the hard irq runs disables preempts.

Thank you for your time and consideration.

Best regards,
Ginger
