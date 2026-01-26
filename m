Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF409303A02
	for <linux-omap@vger.kernel.org>; Mon, 26 Jan 2026 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418419; cv=none; b=drChyxlOoynsC/a2+oQvI43A0GWPFCSWSHov2BwDOLs+v/cQmhpZ7gDiOWTSUxaJHIk0CoKanQtkk6jeGOw3Ko978fBkoP4/Io4Pp/u3tKrsMsHicpuFcd4Mh41ruls6bb4qt8ImVuWVlNBGvJVz44bseppV4cdVqgsW10s+F9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418419; c=relaxed/simple;
	bh=v55gJJHvJ9Mw7NDsEoeRvb1I2iFj0dkmEX3rOHLwg9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocLbQoIqGJZlQjIQK1HYewVhPn/Bm+sPB3h9V+G8GS+7Y62yDsst6+bojzkbVSqGy7DNDOcLdKqoLTa0iMA4w1XECJmMalOypisFXdgonrXY79X61nbnEukfGHtE1o3nSlYDvPPvT4vRyTlDuuMZMmLBH9+bSW5fA/pO6lLO9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSiOab9z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSiOab9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58212C2BCB1
	for <linux-omap@vger.kernel.org>; Mon, 26 Jan 2026 09:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769418419;
	bh=v55gJJHvJ9Mw7NDsEoeRvb1I2iFj0dkmEX3rOHLwg9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pSiOab9zz78r6AF8rg38kSbdx+xDdbedRy4DNIo70fU+3afgVnV+IQaNcH40yb4VH
	 O2xdsiiD5U9W7H5NffKRstWfTZbrpOq1Y23URhjwW5My5qpbotxxMXWk3OFuI2kFlk
	 n7o+OMeX6UmryWcoji7camFZKlTp0KNn8rz1cAKPsnElRzSsd4Eoep2vnDpU7CvHnJ
	 jCUefkJmtLB3VglGHc31BRxEqYZw4MBTUyVOzCkTk8jpPynzrwOpD6bQEleSoXEM3A
	 Fegzpl/w4arx7qCa0iBq6gyWyvUYZwki4JGuRPTYCBDfjOCkpOBgTL4hQFU3eRnjxa
	 VoyxHv8yuUwmw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59dd7bfeb8aso5296415e87.0
        for <linux-omap@vger.kernel.org>; Mon, 26 Jan 2026 01:06:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXa1tbuEpDTUFVzsJmcg60Ic0AaIsWOIEqK1blYTJlaSDUE20DtB437bfgNQ2VSMty7veQbEXChddag@vger.kernel.org
X-Gm-Message-State: AOJu0YxLriDmX9XT5wRDGlMnEJf2gUnsvao8wvMZFP958jtOai1V8Zo2
	fyQDVow37OYh8rgKG5KbyIeakgFu4jH/at3awg3JBeURIXmmoeM39bqkX7g1Ze/8Wg3JzycBuIW
	fFbHepC5V78n9uWyOQIcf9GejYgg5YOMN2VBb2hhdng==
X-Received: by 2002:ac2:51c4:0:b0:59d:e5e0:f962 with SMTP id
 2adb3069b0e04-59df3a2060bmr1269509e87.32.1769418417999; Mon, 26 Jan 2026
 01:06:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123133614.72586-1-dakr@kernel.org> <DFW0HVK6AF0G.TW6R157R8O27@kernel.org>
In-Reply-To: <DFW0HVK6AF0G.TW6R157R8O27@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 26 Jan 2026 10:06:41 +0100
X-Gmail-Original-Message-ID: <CAMRc=MctBqEcoDOG6BGtd=ri-c9X9awnfrojtYRVPQfp8EfGdQ@mail.gmail.com>
X-Gm-Features: AZwV_QjJQcS-YTz7pMN63EdVshPvZ8cjnQzfsDEbS0FnwMyUJXwj1PqCjnf-GKA
Message-ID: <CAMRc=MctBqEcoDOG6BGtd=ri-c9X9awnfrojtYRVPQfp8EfGdQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: do not register driver in probe()
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org, 
	will@kernel.org, grygorii.strashko@ti.com, ssantosh@kernel.org, 
	khilman@kernel.org, linusw@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 2:44=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Fri Jan 23, 2026 at 2:31 PM CET, Danilo Krummrich wrote:
> > However, for the purpose of avoiding the described potential deadlock i=
n
> > combination with commit dc23806a7c47 ("driver core: enforce device_lock=
 for
> > driver_match_device()"), this patch only addresses the driver registrat=
ion
> > issue.
>
> I.e. unless there are any concerns, I'd like to take this one through the
> driver-core tree.

It looks good to me, but it's a GPIO driver, this can go together with
GPIO fixes for v6.19-rc8 as usual.

Bart
