Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF06113A86C
	for <linux-omap@vger.kernel.org>; Mon,  6 Jul 2026 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358207; cv=none; b=WB+DgqQX1snjMr4Ati/iLM8FFLo6TTBzaKHujdhq+m+WdOUamr8cSlfERa4d3A7Lju7D/Czo+xPSZgCyNignkf74z4EgQONEzSU9/g+suspDJYx3ubRTt3Ahxj8wSHQzDw7MXCiacIvfZLB6GTrrc2N4FZWn7U0Yc5pfidhA+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358207; c=relaxed/simple;
	bh=IkPAsQFWKMi0Ay6Ry3S3gT4vAm5wqkrZAM4RTAHMCSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co8D6V1bMyciuKYkzAwgkDqgou7l3PeR4jCP8TIbe9nC/4roiRXXwvQi/xqmaecREXRaDZkLsENFnpkwzQ76AumNO9Z6MA+Wh7jgWoeYtDQV2i5BIrme8dXSfQuUx9XngWtsrIXjHTKb6jyxFPu+QhWRMomvBmk4evBfL7gLqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CN/0sMYF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=krRzD2PS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN/0sMYF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="krRzD2PS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783358205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ucP00vuSVgg389id6t/z181QkBlpSQnaQFPI67Zm964=;
	b=CN/0sMYFxb1WRatxA+uze9Acjf1VM/adVcZg+hUx8sOpq880D043gEREVrZPW1TIryqDwY
	41ZUJEqWWMrxVebRRvQRBARIxkfztz3kl6GTJtuFQALFDsyH1POQ4YkFty0GdPEhZATx1F
	1er5GZ2yCR5JKRrHQ8HN7Sw+NtntWwI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-d6NVDMMwNVW9phmZzbD-1Q-1; Mon, 06 Jul 2026 13:16:43 -0400
X-MC-Unique: d6NVDMMwNVW9phmZzbD-1Q-1
X-Mimecast-MFC-AGG-ID: d6NVDMMwNVW9phmZzbD-1Q_1783358203
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1c7f135bso61496811cf.0
        for <linux-omap@vger.kernel.org>; Mon, 06 Jul 2026 10:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783358203; x=1783963003; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ucP00vuSVgg389id6t/z181QkBlpSQnaQFPI67Zm964=;
        b=krRzD2PSBQzcT2nokR1zS1jq5b2X+kxwEJREZ5pZo+f8UGCrLvhzW2mfnj5tbAr7qa
         850VqXQV0vf0XRoxYlnfT7gP8uYHj4/J/72IgTVb2p+SCrAbiV8LMbm1EKbb+IK+KvbW
         g0LtfwlxTerIIqDRQyhjgb37wc1jX3wYEsyh12xK7XTNy/Mj7wGDWfHfg2Udms1ZPMGP
         qFI7J/CIxQM5gl8U727lYrZOM/mgGh/NRKSXxwJUFdvGPFVbxEPZ3ABTvak7CFCgq9y0
         6cHADAr3nDAYPHe5ql+a14tlgsWPlCA2aHuOa0XASPSFLl8aRv7JiHPA1xDInQY5xkvF
         Lr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358203; x=1783963003;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucP00vuSVgg389id6t/z181QkBlpSQnaQFPI67Zm964=;
        b=LVaf4lzA3bVevCikrv+G9Hhtbvl4ovKmT4L4HvTs5VLwHy2Q/LGVfi5gC713fvcGYQ
         fYbR+aBgnlzvrNr/0s9I7//Kw7qbzrx8qUBdvEhGO5j2ai+G8JOhOoPFhpJzoOB6Eg+A
         QpMvIwKtrcuQj6mFlHrJ7GPFPG4j2Ygu9r1e9ip205fU7TremKv2LznV/orbcEJ1EUgq
         eM0p0Q49EltuhxvR235az0Jw7GkgmAJSlj4IedFkwf+/vG7YLnN9QVB7Hk6eub3F55ef
         edhIshD1MSD/hkUfoqNkRG1adW+ajkBONHwomZPuru+1Lp5Nw2HTitC/pr0GvpalqWQ3
         xz/Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro4buXJTE8rR9uRC8Anm1wEd8GsbAXyVJ3z5tjRINp2Wz+es3p8BalhepdLvLNVuUOiIeozGe/J8Sch@vger.kernel.org
X-Gm-Message-State: AOJu0YyDEv4fk+vJsEw4KZ6GqgwYEaiNctsdFZ5nQbZ9gLDC0Eqmg7nI
	potr2vFMEq2omyS+wRp9dUWUyZpU8vqIK8o9LkfC4TzP1kln9o9Wwqc1jnVtHmUnBI4xL4h/R+i
	Q5hJxoS7a+ZcYbsMZX7GpaSrCHSsWDwnWGlR9ge8++EnN5L7vGePUR7VMZbWrUaw=
X-Gm-Gg: AfdE7ckcvAicr4Hh067xsLXhiP2hQn2vMGss28fNXwSW13nrXrzBDIZeMScwSEHC3dt
	hr47eiEElbFxsGiXqWwzJ3j4WsCYnhJvHQLk47ml88Uob91WPjOUw2W1bOaLQcqj/ASowM9WTLc
	vzu+IgTcWcCWrVDUsujcv92BZ3Q+H7WCXGWzIea9QBVVN85eYuS4tcmPQ4bcbV7JywMoW/VmjDY
	9gu0MHjf1wN4c5RMicG0AbJ/XWbUhP2bKF5OItOXhFoIqUSeeVkrYPJ/4SHp/MIL7l2uiFC0wf9
	Ybn6fV5AGt3Qdx2EwIJbRzJmxWZEy5MMemydfLgJ6tSF9XRsvpL6ZPmQcDn+PlE6dhT6tUwznRX
	WSUhpuejUijo4U86EyDKN785k9nGn8dLCHSvm6xz1QU1PFQ==
X-Received: by 2002:ac8:5a15:0:b0:517:90d2:598b with SMTP id d75a77b69052e-51c7487fe16mr17439131cf.39.1783358203376;
        Mon, 06 Jul 2026 10:16:43 -0700 (PDT)
X-Received: by 2002:ac8:5a15:0:b0:517:90d2:598b with SMTP id d75a77b69052e-51c7487fe16mr17438771cf.39.1783358202925;
        Mon, 06 Jul 2026 10:16:42 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b19a66sm93193941cf.7.2026.07.06.10.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:16:42 -0700 (PDT)
Date: Mon, 6 Jul 2026 13:16:40 -0400
From: Brian Masney <bmasney@redhat.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Tero Kristo <kristo@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] clk: ti: adpll: unregister OF clock provider on remove
Message-ID: <akvi-LCvVYYH2r6P@redhat.com>
References: <20260626094134.71961-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626094134.71961-1-mhun512@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)

On Fri, Jun 26, 2026 at 06:41:26PM +0900, Myeonghun Pak wrote:
> ti_adpll_probe() registers the driver's onecell clock provider with
> of_clk_add_provider().  The remove path only frees the clock resources,
> leaving the provider registered after the backing data has been torn
> down.
> 
> Unregister the OF clock provider before freeing the ADPLL resources so
> the provider no longer points at released driver data after device
> removal.
> 
> Fixes: 21330497f303 ("clk: ti: Add support for dm814x ADPLL")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

