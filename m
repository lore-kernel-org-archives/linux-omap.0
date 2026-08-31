Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB63CB55F
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217349; cv=pass; b=eVzIyA3+TTlth2JV2SXqSk/hm+KybfJJ2AMeDQWwluHnwROCvZQaaTDrrpzCwgzCizFeJZC/WY2Ev23iY6XIg61Rday97VCa6AUKbGccn9wzU+AhVN9msdhyvLCTQFq4sQEQRzZjyOr/EQoJxfdwUJ5P5u64heP0ROSPbm3GBoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217349; c=relaxed/simple;
	bh=QPDBNzw+KWCEMD9k4Xi8uOYkWevA+MR4K4kPjQL2HXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+BWDwKCCCmRl5n8JYWfiHLCUNjTPH7MhlkiBQAhPw+cRZL3zoiaK6T7IinI3LfGME//rJI5OSHUPPmztf5Ab9YX1uxlzT+T0n88v9G49Y+IQ2guqUEOqwGRJfH9WVvxmNUXhvyiWAwRT/17gliC1s/Uf0cwZDWNWEc/gGsAWe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifAx9q3R; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifAx9q3R"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a5f5d37778so477424a12.2
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 16:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788217346; cv=none;
        d=google.com; s=arc-20260327;
        b=oj5oJr6v79utbJ+H9xULIapVF/LP7XDKS8i8WawL6XZOKqIHPEje3MJZQbcCRIPGbn
         XGhZe2I3DsnKmox8qf/7Cg6wUYnp1CdN093mu+SaT38QJ5CXWtHA6eyxtHKD0weLoQgK
         QWTxxwM6NSoqqCluVaJVcSJpOLITfvMOFuctzNeqolVaoLMSllD/MfMeN+nlNrqcCHxl
         jKZi8re3okpl/KJBegvABq5wFvZJn09Aldv4O0GNge0zLRpmEC7Wnf0nsIl7AdHzVCSk
         vJ4F9YlXIhxipZGo/Ja6TzdX49nagdgCs+0KYeJLq86jrO1oWdFvqu5UF3KNXgKJtmRX
         vKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QPDBNzw+KWCEMD9k4Xi8uOYkWevA+MR4K4kPjQL2HXg=;
        fh=6wuzNH195hEsrw445Fz4/09P8JtrIicfY9MVVyqRJe4=;
        b=VQy7sAkNeoDl5iqMVQBsvucjnKEJBrfrW9zOkkAWVm7xd2qsY3eGWGhlFbxu5XgwCk
         b+hMPx2pOpsbQBRBMbopHZbZ/ii9kZCxJSaRFf1hd1MK6fWAdlk1Mmnznxce8PaqLUTz
         2QeL5V70LeL9LGm/w4ZkPrc2Z3xO50nkkNXnIwWLkRsFVH9we0qW+XvZz8PV7UeECI7F
         uxbONxt6ep3jJIyJwbFaRdBtFIov1RAV5zHa3DQITMCHMFZY0oIgVmMdhoOTBlSYSXL5
         sR8Pi0OE0FhswS00V12PEPHkuuYgoRtPpikBQxhfousK0Uua5TH0+XcTbCoNnAdhnhfz
         NMpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788217346; x=1788822146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QPDBNzw+KWCEMD9k4Xi8uOYkWevA+MR4K4kPjQL2HXg=;
        b=ifAx9q3RlC6ARp0ztxGHiYF8R3lsuyHdfd75Sqji3lFJLwP1kpmViWwvQmd3/yfyf0
         KDR7P0k+mJVSuHGHi9j+Cp30NtYgS7RSnqe/9mj1DIQapHsSAYDHRdYi6QCDWPEegnva
         Q1LwIQMU5eX65XkPV6ONsYL0ILxwlwxtBIK+OrdH40x7apHzJpTM1vL5jLVuDjgf/RRe
         1NXEWoMdp1XPBhOzgUnNUuOqrnuNNC2zkwvQDdXHa+XolulBwfBR49ADVuqUlZ74oufe
         uwWazj5+wpTOwCjT5pOhOa/vx2mfBAyq4Od3vJjLrSSh844fV1Y8S5U5wifmNeX2Ees5
         0RHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788217346; x=1788822146;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QPDBNzw+KWCEMD9k4Xi8uOYkWevA+MR4K4kPjQL2HXg=;
        b=OGimTN2CXIrVuV6awNOMaUHKdiUCvBfDvrpDszvUrjKIgH7ruhcXAx6xUiwTP2t4lQ
         1Zb9CyoIVhQy+/j7dEjMUd+PV12DHswCZLtsuz3PnUIvrtySKMnuCtA5rWMMBukYA8CH
         5cTVY/KdeUrYISYm65vAnJOOeK04emX5nS6cKQdRkC70GET7Vrozi0dUrkjlRf+0cVhl
         aoLiFXQK3r6Us6YUj6T+VrpUXr5TRav3uQiHYs0a5hRiQ+6bsrURG/wr/3mLVjQjyoZ2
         Nexs3+iG7JHnxM8lWQj2GD2L59ku36jNO+yEl7YAo04E08YpdYL5rwIYoc2zXsbnYAlo
         ltxA==
X-Forwarded-Encrypted: i=1; AKwUvBwlpHfD+vna+oqG/HAWAB3qMbZgRo49JxgnMP651OXH00bF+0YJqTW2RfjoyqYu4mUUBQFgiqvELBvr@vger.kernel.org
X-Gm-Message-State: AFuF++m63GZoVOA6E9o+OwSV0X7+jdMVnLpE1fmtGdu31OxdJatY36Is
	glCGjeU7xuxKJPFdWu1Hnnv0Ku9g7sbVwO/uBLbgRZU591ieX1EggZwEg4UAZ0YcVVgGzrEuilO
	ONLb0YRoidcx+XiAx5xb74ix7K/gwBbA=
X-Gm-Gg: AYBFou2HISx/WJ/Odv+sb8WQbh62IQRruf7u5GYS+/YiQ/Z/oZl9Yz64WfAcm9MveLt
	VOdb72Nnd/yhTuCwfHuI2KWhKXNtTCqT1fVcmB9Vnu/+gVWChcGbc9kpCimSRJkYl1rtt5cGWf/
	0meJ+9WfqcS/3HsDcTbvT7vb3on/cbTBxnMN0FnA9VtzUJeC48ueGKDomoEtSLUp4LEjEtFHnuZ
	iU0d39LEl7tebsJz/chh00K410xpTS6ui7bWUvLDZorZgsyjIl6fEq9Li1YiiPa54xJsXvmWx9Q
	JC59qZ/Ym4l/4eT0tyaB0v1oFNj7H6Dps2ByLJiL9SIz6nKg0fIfsQmX5yhbir3Y0OK9/dUx86H
	tBWI=
X-Received: by 2002:a05:6402:43c6:b0:6a0:d411:930d with SMTP id
 4fb4d7f45d1cf-6a60d36c8ddmr8084948a12.2.1788217345227; Mon, 31 Aug 2026
 16:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
 <20260818-ti-am33-usb-v2-3-66fd44d66824@gmail.com> <20260831134643.GA733140-robh@kernel.org>
In-Reply-To: <20260831134643.GA733140-robh@kernel.org>
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 1 Sep 2026 04:32:13 +0530
X-Gm-Features: AcwNN1X3HOOhqJKkqX2zS7vFMQd-QWtG1Ec31OOg1tzrgRf7iaa2sG06AC-hKII
Message-ID: <CAOWyW_4RpTD9zAmFDr41sFOj5LtRaGdad7M8QCvQNAQDtamYMA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ARM: dts: ti: am335x: Fix redundant interrupts
 property in USB nodes
To: Rob Herring <robh@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrzej Siewior <bigeasy@linutronix.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Ravi B <ravibabu@ti.com>, 
	Kumar Gupta <ajay.gupta@ti.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-omap@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
	daniel.baluta@gmail.com, simona.toaca@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 7:16=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Aug 18, 2026 at 07:58:45PM +0530, Bhargav Joshi wrote:
> > The am33xx.dtsi defines a single interrupts property for the MUSB nodes=
.
> > Several board-level files override the usb0 node to use
> > interrupts-extended instead to include vbus interrupt.
> >
> > Since both interrupts and interrupts-extended cannot be used
> > simultaneously, Add /delete-property/ interrupts to the overriding
> > nodes to resolve the schema warnings.
>
> Actually, both should be allowed. In theory, an OS version not support
> 'interrupts-extended' and 'interrupts' is also needed for compatibility.
> Though in reality, we've now had 'interrupts-extended' defined for a
> long time. I'll look into what's causing this warning.

Sure will drop this patch in the next version. I also opened pull request t=
o
dt-schema fixing this warning
https://github.com/devicetree-org/dt-schema/pull/206
>
Best Regards,
Bhargav
