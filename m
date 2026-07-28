Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB842AF95
	for <linux-omap@vger.kernel.org>; Tue, 28 Jul 2026 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247881; cv=none; b=OE3ZQwn6JnUAhJZMjuM/RLf8f1WFx1yRhcgWdHEZmnyVmgmtfwHbO6ehM9qmzdJvVGFOymlHm1xyriYvEDp0d+u0JiDzaVG9rihbwd4rLWjeqsM7JwNR50XezQOrywJdAyspngEMsJxULFpG1s27jZ6h//W7CxFEn3zdY6HVVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247881; c=relaxed/simple;
	bh=APl65JmD8YB3Hl0jNbBtGEbN02P8z0BF9+HzMPWth80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFlGr73fJop/xI/atnnWKx1ohow/lkOiGpnB73JeUww6Zf10XMP2Ww76kfuU8oEIVeq74EPx7iSmRQWs5lNQ/S9R9wGbXFU+2qkUQb3L/A4VDv/i+MajIOzzDZ23MF12uQ7TUS6OoPMDYn6flJ+FYQUMWBZwG58KwJHBb7GBjJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJNpszzh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qs9jw7nM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJNpszzh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qs9jw7nM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785247878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdGSrg4lc9i4XaCQajX4CkNJu7rAnpQm8bC2lSUfnJA=;
	b=CJNpszzhALryzHMuf0JABPLq1YROYL4iFqGUKOS21ApzeQkeA85sAb0MllKxONYFn9SBe5
	zuFUGqbmrPmWWIsEEKWS+o34d36sciq0QQWm5YDz6QGVgOIDS65oarea0HSVF91m6vD0PZ
	lrWlJIbN1Lbna5fvLq2+fH0fkgbrPfQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-SQugrg7wMb6NhbFGIaXJqg-1; Tue, 28 Jul 2026 10:11:15 -0400
X-MC-Unique: SQugrg7wMb6NhbFGIaXJqg-1
X-Mimecast-MFC-AGG-ID: SQugrg7wMb6NhbFGIaXJqg_1785247874
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5283fa0656dso13496381cf.1
        for <linux-omap@vger.kernel.org>; Tue, 28 Jul 2026 07:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785247874; x=1785852674; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wdGSrg4lc9i4XaCQajX4CkNJu7rAnpQm8bC2lSUfnJA=;
        b=Qs9jw7nMxKnqSf8dHBkaUXKiswhSry0Q4kASfj943uOd+vi6UNataHdYwhke8FjklT
         JlIaPQE7x7S77qG0aXaQP/rpQnO72CYxiuBrtch8y7ZfRinHtAe2dTGgazDih1CdjOzm
         xHYCSR3ZqmL0M0yK9UXALGTVFf6o4yQlXABn+kuVoUvL7ppzKiU8yjOrKNcjV3QWLxr1
         jTa30PG9+9FPPEdVruqoVYkzJPwmcjzjaNh6RU1Me2nqfPZFROcx9iV5XDDRCC1i/KFs
         KTn0rZRcrRvYzJWA5i1gyjrgsTH0d1AWtCqQcIPkkyKGVBGXkV3y0YCgzJzwzJCXyscE
         pFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785247874; x=1785852674;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wdGSrg4lc9i4XaCQajX4CkNJu7rAnpQm8bC2lSUfnJA=;
        b=GVaxDBJpBe3kwqrjh+Z9Pb+LrAjpoQ/WTXtpFCA5ag7RWE1wZpN60wvh4WyWq/UgkG
         s1Ft9tE2eYeIISe5BeE3oAEnPtkKHlbSWQB1XBUh9U0bmJR0JP98+VP8eI8cQm+LD5n1
         P99L1QDw14HHF/NL5ur2q66v1IHsZhbjn7hl5jZ/cFnuWNajKhylEm/DZbqlWv8eK6tw
         Ibnrnmi+55N+fvh2+HkFvOSw3/t49+TwTv5H11RCR8njm9d27QLocROlblBEdplVbgoV
         AOJ8fgc6651XytqU0Q0SlWWeWyycp7sIw/E1A4hEQsn+FI1ec8GRJIodmbQhHyPwfCSv
         QZsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLfzCZ4sws3u8IaAs2ee0kPhaDD7t2+D9f0I5mvsGXUadhSxqeoi1j3EQ3m4oGzm4cbZTzCzksIV40@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8nycRjNFBIu00guhYN2kS1RQoESNo6OidUpNHFcbhIH3deych
	UK92pgEVUrcPiJXdP2TIWvi4YRhxGR0YYUnzWmpZu4h2dQ0UAiHyVbSwP9pf3Y/HJgh6fizHQ5f
	p9FrY8Fy3Odo3xJOFSfkD0SuQEARsci7AA6t9rFMC/AQ4sOzVUnHDiJyBd5J2LzI=
X-Gm-Gg: AR+sD11i2X7eqmPRg/Ekllm3ABRbJLoGYt3A3Q1rN0kTs+2hcPZW1KrHvwOIZESpb/Y
	t3RbyRTKM8BPxFz/GNa9RyfwJmKaos+5a6unENlaDqh7Kd5MOKFnK1bZdj6R0HSX6GFnV/y2y5V
	3/Vx8lJYzkzayo/fBMy5xPXNGM2cN8jeJwmD3J2fjHEB1IB4n2dqqCc//ubxf87GuguTzupVZsc
	1ZL1ofeq9NHMHJeYR+iTIccqNF8tkApvAuxtDepHAe6RPKO0SwT80xhgzjnktlIjPVzbQX8cUyl
	36hvlYscDpGcgCK5Bdvj7J5NPLQ+ENoDQ+B2FwJmZmtdh2atDORH3zpMUrLcZ7sw+Ug04V3JDAo
	Xxuyt0r+ybQdq8LF8vw23G+Ihirjqnk4yCYQ=
X-Received: by 2002:ac8:5fd4:0:b0:517:c699:3387 with SMTP id d75a77b69052e-529d7163a49mr20348081cf.37.1785247873925;
        Tue, 28 Jul 2026 07:11:13 -0700 (PDT)
X-Received: by 2002:ac8:5fd4:0:b0:517:c699:3387 with SMTP id d75a77b69052e-529d7163a49mr20347531cf.37.1785247873337;
        Tue, 28 Jul 2026 07:11:13 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dc4286dsm162646d6.7.2026.07.28.07.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:11:12 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:11:08 -0400
From: Brian Masney <bmasney@redhat.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Tero Kristo <kristo@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
Message-ID: <ami4fLPMg9_p28Nm@redhat.com>
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
 <20260727-mathieu-wdt-clock-theo-v2-1-c048a6394436@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-mathieu-wdt-clock-theo-v2-1-c048a6394436@bootlin.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Mon, Jul 27, 2026 at 09:41:40AM +0200, Mathieu Dubois-Briand wrote:
> Resolve parent clocks by their index into the device tree "clocks"
> property rather than matching names as strings. Name-based matching is
> fragile because a clock's "clock-output-names" value in its provider
> node can differ from the name used to reference it in a consumer node,
> and because names must be globally unique across all clock providers.
> 
> On AM335x, this caused broken clock trees where some clocks failed to
> enable because their parents could not be found.
> 
> Replace of_clk_parent_fill() with a clk_parent_data array that sets
> .index to the array position.
> 
> Fixes: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

