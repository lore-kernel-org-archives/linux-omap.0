Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795458;
	b=th3CHmpo0XgbK1Vl0FEgDcjbGk4jxlTynx9D0cdePneFkCMU7NfEz6NSbeUzi9K0jLFi
	 2GZYPQTCRVN0q4T2bKHg9SY6xz3NgsSPoG45mGH1GZEjX4pXI8OUbLiEoLJbvsXm10wQ1
	 yVFa2YLlI7/t0GWeYmu9STB2+9eZ9+27oE38sj0u4elKEdInmIgIFB+NuUGTUyH4ZyQiy
	 hXMpoT69xNwvYnlMSLDy0s+0gtzmUelqBpJBET8hXlHsZPuoC8SJdF2MRwJpVUp1lcof/
	 HtjAZbX0DdxSJ5YKUtCcpiRodN9pIZR7mCP1rMHQvhkECWz7UmgnWOE5NVJlqaWEJSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795458;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nLTKrRV7zGj2+I2eiQhkslScmWRTzYP0lSx7u0c6KX0=;
	b=PfO9vK15MrVbFSP6V9LDPF2QpQ4qKy1jz9unsr8IfVNClckBgRlYsb93nBHk4agizFVN
	 gVJk8gxaIuCQcemnrmWTqUrcyWBY395V6kFIfegoUOajqNlnEgqjjzmPKRg59hrUpK8Ii
	 veflYO2JDzTfAzYg+nBlN/dsEtV4UNBgjlKtr4bvB2QhEOqdlxyh6jcsCrL0RAqdmDQmn
	 6KdeYkxGxDpnXYzBOIisssoRTjHo3qc8xrIRIW5qd9Uyt5sBAuPj8uxez0sZ4si/0rIdo
	 SQp80+6CkxM15Hcf4FbYkQZ+ApbU8StKfO9lAlIhw96icgxaKkh/IEUqECU9cyo7sgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B531606A329
	for <linux-omap@vger.kernel.org>; Wed,  4 Nov 2026 12:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7691F00A1A
	for <linux-omap@vger.kernel.org>; Wed,  4 Nov 2026 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793795448;
	bh=nLTKrRV7zGj2+I2eiQhkslScmWRTzYP0lSx7u0c6KX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i+eOpIVCD6c9q3d8U7OaPRj1DAkcCbwKg0e0/FB4gvbWHhi53k/RkjVa0uRQXDCQ1
	 zAvMD+YbSdnJSgGy25maWzemVTB7PwuC1McmSi1j6y2JieTGBPLJN1h2Z1OLzBVXPg
	 j48YnItp8Vtjr5vRU1ggfwvm9WN+pdGbfrSw0o+XLh5yr3ygW4Gu+yKjE0BlN9XR5y
	 uEjIJ0p/MAGSP2G908hwhZduD9zfnPlyPpCVzp4pdXsXiMWLorsj50bnoaX7EhOjjh
	 Wu54b2wlES4jjZJ41wtWivS0w+8qvi5sNm7SSJtwrhbfe+SsghRpIg3Xir1PcIdSlC
	 Pnt6va1saxJIQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be4fea434bso1578757e87.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Nov 2026 04:30:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw5t1bT27qbW/oKul92bXibxCwmsriyjKf17oR119+dOpZA7ZelY8qJth2AQbuaj7DOFLdcoCRoFZRL@vger.kernel.org
X-Gm-Message-State: APuU4Z82QByW4zHvfbwMRGVOPvE2WatSun9xIHxwS58Oj9swtpN4WoJQ
	IlmfNmNee7R1QcMIxPjwFYEIUwpyfZoCU7Leexv6o1ZmnAQJjMaqifZnuTiQH+I7Q/YK5Q0EDhl
	oGzUn66V+4yzEB3bVoMyT+0eFFYvh/HY=
X-Received: by 2002:a05:6512:a8c:b0:5bf:c97d:d170 with SMTP id
 2adb3069b0e04-5bfd11f352bmr5131215e87.17.1793795446847; Wed, 04 Nov 2026
 04:30:46 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261001085217.1778645-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20261001085217.1778645-1-alexander.sverdlin@siemens.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 4 Nov 2026 13:30:34 +0100
X-Gmail-Original-Message-ID: <CAD++jLn8yxh3LmUzbb2vZfJFJB=_mCZ+VeQhnZktfmuMiv5uEg@mail.gmail.com>
X-Gm-Features: AclHuK_xh55IfYWDcMEadkkQPRWoFw-pLiRPci8jz0ty-rrKgkyopgwVmzEI3cA
Message-ID: <CAD++jLn8yxh3LmUzbb2vZfJFJB=_mCZ+VeQhnZktfmuMiv5uEg@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: fix group/function table leaks on consumer re-probe
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-gpio@vger.kernel.org, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Lokesh Vutla <lokeshvutla@ti.com>, 
	Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:52=E2=80=AFAM A. Sverdlin
<alexander.sverdlin@siemens.com> wrote:

> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> Pinctrl drivers that create their groups/functions lazily from the
> consumer's device-tree node in .dt_node_to_map() leak the per-mapping
> tables when the same node is mapped again. The core deduplicates
> groups/functions by name and keeps the first instance for the controller'=
s
> lifetime, so it silently drops the copies built on every subsequent
> mapping - e.g. on each re-probe of the consumer device. kmemleak does not
> flag them because they stay reachable from the controller's devres list.
>
> Reproducer (patch 1, pinctrl-single) - any board where a device referenci=
ng
> a pinctrl-single state is repeatedly re-probed; here an I2C TPM whose nod=
e
> has a "default" pinctrl state:
>
>   while modprobe tpm_tis_i2c; do rmmod tpm_tis_i2c; done
>
> The tables land in a generic kmalloc-N cache (kmalloc-192 on arm64, where
> ARCH_KMALLOC_MINALIGN pads every devres allocation; the bucket differs by
> config), so watch it cache-independently by diffing /proc/slabinfo after
> dropping the reclaimable slab:
>
>   sync; echo 3 > /proc/sys/vm/drop_caches
>   cat /proc/slabinfo | awk 'NR>2{print $1,$2}' | sort > /tmp/a
>   <run N cycles>
>   sync; echo 3 > /proc/sys/vm/drop_caches
>   cat /proc/slabinfo | awk 'NR>2{print $1,$2}' | sort > /tmp/b
>   join /tmp/a /tmp/b | awk '$3>$2{print $1,$3-$2}'
>
> Patch 1 (pinctrl-single) was found and fixed with the above test on real
> hardware. Patch 2 (ti-iodelay) has the same bug pattern - plus a missing
> .dt_free_map that leaks the mapping table as well - but was found by code
> review only and is compile-tested only; I have no such hardware to
> reproduce it.
>
> Alexander Sverdlin (2):
>   pinctrl: single: don't leak group/function tables on consumer re-probe
>   pinctrl: ti-iodelay: fix memory leaks on consumer re-probe

I got exactly zero reviews on this patch set from the pinctrl-single
maintainers, so I have now just applied it.

Maybe the old maintainers have other things to do, have you considered
signing up as co-maintainer? You seem to know what you are doing.

Yours,
Linus Walleij
