Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ACE380FE0
	for <linux-omap@vger.kernel.org>; Thu,  2 Jul 2026 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026825; cv=pass; b=NVqSAfO7HoWfYue1mTrjhD11wrAxnJZybTrsPksIa9cENy+TYProuVTEMEhjMP1vK4srSjon2Mbc6TdalP0m294OzEFdp3zeg5nxov/dzvHRl2bTh8uustOKFFWFBhbkBZ5urI1RMSGPIN0GyRZWFRE/mQeXeQNXzqfiHRvZpdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026825; c=relaxed/simple;
	bh=UMP72jH48Rq6NbnrlPu/ZWb1zwUhMl3lYtFHVM6IbQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdjPdwOTiETx+67yFYMDx9lRiyNhMs9Ozcsv6k3DyIXJ710+TUP2G0LPIa5HYrsBpbKUckHYfDtWnUStNFmLhw9bTF4qXbJZteQN7/SpUeLwwPuswLDVyoZRPNI89dnGVHbMS/n6aLNT+xa6k1i+8XaWvzRpB4DRsm7AKq6MBzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwNwjL/a; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwNwjL/a"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c127a694ccbso331420466b.3
        for <linux-omap@vger.kernel.org>; Thu, 02 Jul 2026 14:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783026822; cv=none;
        d=google.com; s=arc-20260327;
        b=qpyBADCJ0oeLlEkIC5A/Da3SXTMSrLDThIMoE9tG6KGZvo/0L79WaNZ3fdggTgVvLG
         qPk2erVRs+bfQmDqrQHSh7hfXnnuot6R9wbU2hKLiYPH6gS3HI8dSQOigWy0s+7BsYjp
         J4HkOihHELkN2M4Y6+MSn6UyRNeyrKudU3HDW0lQSR3PhtqzZB9GMbj06CxQy5XOPwaV
         qGtYdW7vls94WkAREUDAvmjgxEzbvCYUIF8dG39zC8smQFvRZD1zn9LgFbH4ravvWihU
         UeAb0GxsnZLpI71yWv+AYp8CGaZIZTk2Ak8pZSxvPHZHU1EQCuH395/B6QWjMPC75wD2
         LKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Cltvcsp5S5OpTUXmNU/LPetkh3uHo/gzqcpiFn+u3Fw=;
        fh=0Cb28y7TkIyBgsiiZjbqdYKFQjVnIOqUPJZJ+pV5OFE=;
        b=f7c9j2egnOopXPp/NINxOVllkLm9W7d77XaEL9VUO1ujhxvXUbi7aepnuh/EO/7d8R
         NEnn8MKe3c5hf94IZbFWOFILAnXZwy7qVhanMKGXOWAYNTY9Y+eoPtD69+TPZKfvQTrk
         yk+5eRcn/IsDPE7P2kCaZn1sbQu2pRhRZR4ST4phy1KcBtdsAHkyQsceMjBSuVgKiL6f
         CO9okUjnVNYIlQVz2p/hts07ejLQVALoMtpGFdDR03p/71rP8d1Cbp4wvZHuZscG/y1T
         x5x+twUiFR/5YRzI3HnWAAAm0XbO0bIeJhDP7QThOAOp0Di1ENSVFcnnPUnD5fovQzR5
         hFIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783026822; x=1783631622; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cltvcsp5S5OpTUXmNU/LPetkh3uHo/gzqcpiFn+u3Fw=;
        b=bwNwjL/aMH/4kMnz4UQiDCZN5qObXYsWzgi7/z/ji3Qebg9ECh3mnunyepgdApsrCj
         9a1FMVzR6ZgzsqkNUJUtNivgRV+Wp4rWauSXelBD0H3QsZ/LvcwieMihqXf/FdSILOWs
         OpN6mq8k5kObnGAmT7G+/OXjDa4WzrzHCa5el7CzXqwWtISc1Nmb82uR1/ZbSm1K6Ydp
         zG7mwjVFN1iMXtUfRf2wgSsNvAZVUzOuEsuXYaUycr1DM0gc6oTuwf3nHlbmM2qla/wz
         2vMuStl7XeXIqZRYNk47fuHr9sPOxSlllzxd+yNPgHCjByLd9Q7wKM9uDOrPD888H9rv
         q8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783026822; x=1783631622;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cltvcsp5S5OpTUXmNU/LPetkh3uHo/gzqcpiFn+u3Fw=;
        b=dnxHrCuYwz2k+CWdzqCOU6OjF4ztZWDFU13QAR2qkqd1oNWyU1W8M5S7Y+LSuX6ovX
         vbc2njzwqTUvMnh2hWoBa+hukpGISCrYECwv62u2pMXIqqW2ox0wbGRdMNoBJC91aRni
         QqbZS59N3vaHOZo0WpQYbwTp6+DnW0v30ly5Otw/d+0e9+bYKFR4Y2K+FL7uus4tB6Ky
         ddGp5Z/ZcdeGzqciXxUFYmp+2KP7Me0qiaT5oK4az8kmOEfWUmQL3dxs5LVWU3ZWPhZB
         DoU1TUrJD+dFGYK5oo7aHVdc6/CjZEIk5drx3a9juvWBXTmytkx4F9IM9tPAsfcVXrVj
         2g3Q==
X-Gm-Message-State: AOJu0Yxfzv04TZHudN5dwK6NCkoUU5d/8bvVjCLBgxfZFPhkNVPiaOs3
	uRJdCmuaxdLWYylUXNWrgPa1mEjEghHlTSpQ27hCvxlliwNUs4ij4pDjmok8vTOcqwUuUNz7nel
	hbbSQlPexxnol2StYQQkTdib5isIrXHg=
X-Gm-Gg: AfdE7clUFgo70QbkEm0LVhNnQTHok0OoJYODYaw7O8VJv/md/UKXwez7Lluaip/hDin
	MthV4I6DAbVkXZR3Jn3/nQWg7SyF/dUCAsJzgdKO74U7c5JL1Ti7U5Z66CpcfICxqW5K5k8rd8j
	3K6munXli4GYp1eLic5YYJlZRyJjlTi0kiMPE3arSNMz+MC7UOQPDBSEvDJmO9KgXG0pfK/vw/F
	rQFwBtVLuRU391aCf3HP9rkgB7ge68GIP/lIHaKvfMLp4tAdrWJlLQUWrxyirX84cEIIR6OnYQj
	F6Aa0H2u2UKTo6dcter1WRWdQIsPHyWqKyKhizGt/3W0KEZgeLfq
X-Received: by 2002:a17:907:d13:b0:c12:4246:885c with SMTP id
 a640c23a62f3a-c12ae4c1ac0mr342129566b.26.1783026821817; Thu, 02 Jul 2026
 14:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615200540.770205-1-dbgh9129@gmail.com>
In-Reply-To: <20260615200540.770205-1-dbgh9129@gmail.com>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Thu, 2 Jul 2026 17:13:28 -0400
X-Gm-Features: AVVi8Cfq3tuleR6tpZDgcAyqLTAGOCOZXKRi4fTPfcaLKoebAlBvHPFMqzsMLOs
Message-ID: <CACrCO_XcYF=T3kpeUcm_ReHdUXrwd6znPkpmLbonVKTVoNkw+w@mail.gmail.com>
Subject: Re: [PATCH v1] bus: ti-sysc: Fix /chosen node reference leak
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Just a gentle ping on this patch.

I would appreciate any feedback when you have a chance to review this.

Thanks

On Mon, 15 Jun 2026 at 16:05, Yuho Choi <dbgh9129@gmail.com> wrote:
>
> sysc_init_stdout_path() gets the /chosen node with
> of_find_node_by_path() to read stdout-path. The function then overwrites
> the local node pointer with the stdout-path lookup result, or exits on
> error, without dropping the /chosen reference.
>
> Keep the /chosen node in a separate variable and put it after the
> stdout-path value has been used for the lookup. The successful stdout
> node lookup remains referenced by the cached stdout_path pointer.
>
> Fixes: 3bb37c8e6e6a ("bus: ti-sysc: Handle stdout-path for debug console")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  drivers/bus/ti-sysc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> index a5b9507de37c..e118b900c9ac 100644
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -682,6 +682,7 @@ static struct device_node *stdout_path;
>
>  static void sysc_init_stdout_path(struct sysc *ddata)
>  {
> +       struct device_node *chosen;
>         struct device_node *np = NULL;
>         const char *uart;
>
> @@ -691,15 +692,18 @@ static void sysc_init_stdout_path(struct sysc *ddata)
>         if (stdout_path)
>                 return;
>
> -       np = of_find_node_by_path("/chosen");
> -       if (!np)
> +       chosen = of_find_node_by_path("/chosen");
> +       if (!chosen)
>                 goto err;
>
> -       uart = of_get_property(np, "stdout-path", NULL);
> -       if (!uart)
> +       uart = of_get_property(chosen, "stdout-path", NULL);
> +       if (!uart) {
> +               of_node_put(chosen);
>                 goto err;
> +       }
>
>         np = of_find_node_by_path(uart);
> +       of_node_put(chosen);
>         if (!np)
>                 goto err;
>
> --
> 2.43.0
>
